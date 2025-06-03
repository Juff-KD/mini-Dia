local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
--sys keymaps..
-- vim.api.nvim_set_keymap("i", "<A-j>", "<Left>", opts)
-- vim.api.nvim_set_keymap("i", "<A-k>", "<Right>", opts)
-- vim.api.nvim_set_keymap("i", "<A-h>", "<C-Left>", opts)
-- vim.api.nvim_set_keymap("i", "<A-l>", "<C-Right>", opts)

map('i', 'jk', '<ESC>', opts)
map('n', '<A-q>', ':qa!<cr>', opts)
map('n', '<leader>qq', ':bd<cr>', opts)
map('n', '<leader>cc', ':close<cr>', opts)
map('n', '<leader>w', ':w!<cr>', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)


--:NOTE: Termin
map('n', '<leader>t', ':Sterm pwsh<cr>', opts)

-- NOTE: plugins keymaps
map('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', opts)

-- NOTE: buffers manage..
map('n', '<leader>fm', ':lua require("buffer_manager.ui").toggle_quick_menu()<cr>', opts)
map('n', '<leader>k', ':lua require("buffer_manager.ui").nav_next()<cr>', opts)
map('n', '<leader>j', ':lua require("buffer_manager.ui").nav_prev()<cr>', opts)

-- NOTE: wk keymaps
now(function()
    add({ source = "folke/which-key.nvim" })
    map('n', '<leader>?', '<cmd>WhichKey<cr>', opts)
end)

local wk = require("which-key")
wk.add({
    { "<leader>ff", "<cmd>Pick files<cr>", desc = "Pick files",       mode = "n" },
    { "<leader>n",  "<cmd>enew<cr>",       desc = "New File",         mode = "n" },
    { "<leader>D",  "<cmd>Alpha<cr>",      desc = "Dashboard",        mode = "n" },
    { "<leader>O",  ":Outline<cr>",        desc = "Toggle Outline",   mode = "n" },
    { "<leader>sk", ":Screenkey<cr>",      desc = "Toggle Screenkey", mode = "n" },

    -- NOTE: trouble
    {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
    },
    {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },

    -- NOTE: undotree
    { '<leader>U',  "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle UndoTree",     mode = "n" },
    { '<leader>uo', "<cmd>lua require('undotree').open()<cr>",   desc = "Open UndoTree",       mode = "n" },
    { '<leader>uc', "<cmd>lua require('undotree').close()<cr>",  desc = "Close UndoTree",      mode = "n" },

    -- NOTE: obsidian
    { '<leader>os', "<cmd>ObsidianSearch<cr>",                   desc = "ObsidianSearch",      mode = "n" },
    { '<leader>oq', "<cmd>ObsidianQuickSwitch<cr>",              desc = "ObsidianQuickSwitch", mode = "n" },
    { '<leader>ow', "<cmd>ObsidianWorkspace<cr>",                desc = "ObsidianWorkspace",   mode = "n" },
    { '<leader>ob', "<cmd>ObsidianOpen<cr>",                     desc = "ObsidianOpen",        mode = "n" },

    -- NOTE: kulala
    {
        "<leader>Rs",
        function() require("kulala").run() end,
        mode = { "n", "v" }, -- optional mode, default is n
        desc = "Send request"
    },
    {
        "<leader>Ra",
        function() require("kulala").run_all() end,
        mode = { "n", "v" },
        desc = "Run all",
        -- ft = "http",
    },
    {
        "<leader>Rr",
        function() require("kulala").replay() end,
        desc = "Run Replay",
        -- ft = { "http", "rest" },
    },
    {
        "<leader>Rh",
        function() require("kulala.ui").show_headers() end,
        desc = "Show headers",
    },
    --:NOTE: undo-glow
    {
        "u",
        function()
            require("undo-glow").undo()
        end,
        mode = "n",
        desc = "Undo with highlight",
        noremap = true,
    },
    {
        "U",
        function()
            require("undo-glow").redo()
        end,
        mode = "n",
        desc = "Redo with highlight",
        noremap = true,
    },
    {
        "p",
        function()
            require("undo-glow").paste_below()
        end,
        mode = "n",
        desc = "Paste below with highlight",
        noremap = true,
    },
    {
        "P",
        function()
            require("undo-glow").paste_above()
        end,
        mode = "n",
        desc = "Paste above with highlight",
        noremap = true,
    },
    {
        "n",
        function()
            require("undo-glow").search_next({
                animation = {
                    animation_type = "strobe",
                },
            })
        end,
        mode = "n",
        desc = "Search next with highlight",
        noremap = true,
    },
    {
        "N",
        function()
            require("undo-glow").search_prev({
                animation = {
                    animation_type = "strobe",
                },
            })
        end,
        mode = "n",
        desc = "Search prev with highlight",
        noremap = true,
    },
    {
        "*",
        function()
            require("undo-glow").search_star({
                animation = {
                    animation_type = "strobe",
                },
            })
        end,
        mode = "n",
        desc = "Search star with highlight",
        noremap = true,
    },
    {
        "gc",
        function()
            -- This is an implementation to preserve the cursor position
            local pos = vim.fn.getpos(".")
            vim.schedule(function()
                vim.fn.setpos(".", pos)
            end)
            return require("undo-glow").comment()
        end,
        mode = { "n", "x" },
        desc = "Toggle comment with highlight",
        expr = true,
        noremap = true,
    },
    {
        "gc",
        function()
            require("undo-glow").comment_textobject()
        end,
        mode = "o",
        desc = "Comment textobject with highlight",
        noremap = true,
    },
    {
        "gcc",
        function()
            return require("undo-glow").comment_line()
        end,
        mode = "n",
        desc = "Toggle comment line with highlight",
        expr = true,
        noremap = true,
    },

    -- NOTE: Sancks maps
    { "<leader>z",  function() Snacks.zen() end,                    desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,               desc = "Toggle Zoom" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,     desc = "Rename File" },
    { "<leader>lg", function() Snacks.lazygit() end,                desc = "Lazygit" },
    { "<leader>fr", function() Snacks.picker.recent() end,          desc = "Recent" },
    { "<leader>:",  function() Snacks.picker.command_history() end, desc = "Command History" },
    -- { "<leader>uD", function() Snacks.toggle.dim() end,             desc = "Toggle dim" },


})
