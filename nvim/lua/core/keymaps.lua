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
map('n', '<leader>w', ':w!<cr>', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)


-- NOTE: plugins keymaps
map('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', opts)

-- NOTE: buffers manage..
map('n', '<leader>fm', ':lua require("buffer_manager.ui").toggle_quick_menu()<cr>', opts)
map('n', '<C-k>', ':lua require("buffer_manager.ui").nav_next()<cr>', opts)
map('n', '<C-j>', ':lua require("buffer_manager.ui").nav_prev()<cr>', opts)

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
    }




})
