local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- :NOTE combining..
later(function()
    add({ source = "jbyuki/venn.nvim" })
    -- venn.nvim: enable or disable keymappings
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

    add({ source = 'jiaoshijie/undotree', depends = { "nvim-lua/plenary.nvim" } })
    require('undotree').setup()

    add({ source = 'bloznelis/before.nvim' })
    local before = require('before')
    before.setup({
        -- How many edit location to store in memory (default: 10)
        history_size = 42,
        -- Wrap around the ends of the edit history (default: false)
        history_wrap_enabled = true
    })
    vim.keymap.set('n', '<A-H>', before.jump_to_last_edit, {})
    -- Jump to next entry in the edit history
    vim.keymap.set('n', '<A-L>', before.jump_to_next_edit, {})
    -- Look for previous edits in quickfix list
    vim.keymap.set('n', '<leader>of', before.show_edits_in_quickfix, {})

    add({ source = "wurli/visimatch.nvim" })
    require("visimatch").setup()

    add({ source = "chentoast/marks.nvim", })
    require('marks').setup()

    add({
        source = 'j-morano/buffer_manager.nvim',
        depends = { 'nvim-lua/plenary.nvim' }
    })

    add({ source = 'MagicDuck/grug-far.nvim' })
    require('grug-far').setup()

    add({ source = "hedyhli/outline.nvim" })
    require("outline").setup({
        outline_window = {
            -- Where to open the split window: right/left
            position = 'left',
        }
    })

    add({ source = "m4xshen/smartcolumn.nvim" })
    require("smartcolumn").setup({
        colorcolumn = "80",
    })
end)

now(function()
    add({
        source = "folke/noice.nvim",
        depends = { "MunifTanjim/nui.nvim" },
    })
    require("noice").setup({
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = false,        -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        views = {
            cmdline_popup = {
                position = {
                    row = 2,
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
        },
    })
end)

later(function()
    add({
        source = 'athar-qadri/scratchpad.nvim',
        depends = { "nvim-lua/plenary.nvim" },
    })

    require("scratchpad"):setup({
        settings = {
            sync_on_ui_close = true,
            title = "My Scratch Pad"
        },
        default = {
            --here you specify project root identifiers (Cargo.toml, package.json, blah-blah-blah)
            --or let your man do the job
            root_patterns = { ".git", "package.json", "README.md" },
        },
    })

    vim.keymap.set("n", "<Leader>sc",
        function()
            local scratchpad = require("scratchpad")
            scratchpad.ui:new_scratchpad()
        end,
        { desc = "show scratch pad" })

    vim.keymap.set({ "n", "v" }, "<leader>sp", function()
        local scratchpad = require("scratchpad")
        scratchpad.ui:sync()
    end, { desc = "Push selection / current line to scratchpad" })
end)

-- Fun..
later(function()
    add({ source = 'tamton-aquib/duck.nvim' })
    vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
    vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    vim.keymap.set('n', '<leader>da', function() require("duck").cook_all() end, {})

    --popular candidates: 🦆 ඞ 🦀 🐈 🐎 🦖 🐤
    --     nnoremap <leader>dd :lua require("duck").hatch("ඞ")<CR>
    -- vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("🦆", 10) end, {}) -- A pretty fast duck
    -- vim.keymap.set('n', '<leader>dc', function() require("duck").hatch("🐈", 0.75) end, {}) -- Quite a mellow cat
end)

later(function()
    add({ source = "NStefan002/screenkey.nvim", tag = "*" })
    require("screenkey").setup({
        win_opts = {
            width = 16,
            height = 3,
        }
    })
end)
