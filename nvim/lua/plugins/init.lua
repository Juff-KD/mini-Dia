require('plugins.depsplugins')
require('plugins.lspplugs')
require('plugins.uiplugs')
require('plugins.gits')
require('plugins.coolplugs')
require('plugins.ftplugs')
require('plugins.debug')

-- Snacks rename
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
})
--
-- -- undo-glow
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        require("undo-glow").yank()
    end,
})
--
vim.api.nvim_create_autocmd("CursorMoved", {
    desc = "Highlight when cursor moved significantly",
    callback = function()
        require("undo-glow").cursor_moved({
            animation = {
                animation_type = "slide",
            },
        })
    end,
})
--
vim.api.nvim_create_autocmd("CmdLineLeave", {
    pattern = { "/", "?" },
    desc = "Highlight when search cmdline leave",
    callback = function()
        require("undo-glow").search_cmd({
            animation = {
                animation_type = "fade",
            },
        })
    end,
})
-- -- jsx-element
vim.api.nvim_create_autocmd("FileType", {
    pattern = { 'typescriptreact', 'javascriptreact' }, -- 'javascript'
    callback = function()
        -- Access the plugin (triggers loading)
        local jsx = require("jsx-element")
        jsx.setup({})
    end,

})
--
--
--
-- -- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd [[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
    else
        vim.cmd [[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end

--
-- -- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true })
-- -- conform autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
--
-- --lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require("lint").try_lint("cspell")
    end,
})

--TODO  markmap
-- Define a custom command to run markmap on the current file asynchronously
-- vim.api.nvim_create_user_command('Markmap', function()
--     local filepath = vim.fn.expand('%:p')
--     vim.fn.jobstart('markmap -w ' .. filepath, {
--         on_exit = function()
--             vim.cmd('redraw!')
--         end
--     })
-- end, {})
--
-- -- Define a custom command to start live-server
-- vim.api.nvim_create_user_command('LiveServer', function()
--     local dir = vim.fn.expand('%:p:h')
--     vim.fn.jobstart('live-server --port=8080 --no-browser --watch=' .. dir, {
--         on_exit = function()
--             vim.cmd('redraw!')
--         end
--     })
-- end, {})
--
-- -- Set up an autocmd to start live-server when opening a Markdown file
-- vim.api.nvim_create_autocmd('BufEnter', {
--     pattern = '*.md',
--     callback = function()
--         vim.cmd('LiveServer')
--     end,
-- })

-- HACK:

-- Track the markmap process ID
local markmap_pid = nil

vim.api.nvim_create_user_command('MarkmapStart', function()
    local filepath = vim.fn.expand('%:p') -- Get the full path of the current file

    -- Start markmap
    markmap_pid = vim.fn.jobstart('markmap -w ' .. filepath, {
        on_exit = function()
            vim.cmd('redraw!')
            markmap_pid = nil -- Reset PID when the process exits
        end
    })
    print('Markmap started. Edge tab opened automatically by markmap.')
end, {})


-- Define a custom command to stop markmap and close the Firefox tab
vim.api.nvim_create_user_command('MarkmapStop', function()
    -- Stop the markmap process
    if markmap_pid then
        vim.fn.jobstop(markmap_pid)
        markmap_pid = nil
        print('Markmap process stopped.')
    else
        print('No Markmap process is running.')
    end
end, {}) -- markmap process Stop!
--
--     -- Close the Firefox tab opened by markmap (platform-specific solution)
--     local os_name = vim.loop.os_uname().sysname
--     if os_name == "Linux" or os_name == "Darwin" then
--         if os_name == "Darwin" then
--             -- macOS: Use AppleScript to close only the "Markmap" tab
--             vim.fn.jobstart(
--                 'osascript -e \'tell application "Firefox" to tell front window to close (first tab whose name contains "Markmap")\'',
--                 {
--                     on_exit = function()
--                         vim.cmd('redraw!')
--                     end
--                 })
--         else
--             -- Linux: Use xdotool to close only the "Markmap" tab
--             vim.fn.jobstart('xdotool search --name "Markmap" windowactivate --sync key --clearmodifiers ctrl+w', {
--                 on_exit = function()
--                     vim.cmd('redraw!')
--                 end
--             })
--         end
--     elseif os_name == "Windows_NT" then
--         -- Close Firefox Developer Edition tab with PowerShell
--         vim.fn.jobstart(
--             'powershell -Command "Get-Process | Where-Object { $_.MainWindowTitle -like \'*Markmap — Firefox Developer Edition*\' } | ForEach-Object { Stop-Process -Id $_.Id }"',
--             -- 'powershell -Command "Get-Process | Where-Object { $_.MainWindowTitle -like \'*Markmap — Firefox Developer Edition*\' } | %{ $_.CloseMainWindow() }"',
--             {
--                 on_exit = function()
--                     vim.cmd('redraw!')
--                 end
--             }
--         )
--         print('Attempted to close Markmap tab in Firefox Developer Edition.')
--     end
--
--     print('Firefox tab closed.')
-- end, {})
