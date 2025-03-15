local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add({ source = "mistweaverco/kulala.nvim" })
    require('kulala').setup({
        global_keymaps = false,
    })


    add({ source = "axieax/urlview.nvim" })
    add({ source = "toppair/peek.nvim" })
    require("peek").setup({
        app = 'firefox'
    })
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

    add({ source = 'barrett-ruth/live-server.nvim', build = 'pnpm add -g live-server' })
    require('live-server').setup(opts)

    add({
        source = 'MeanderingProgrammer/render-markdown.nvim',
        depends = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }
    })
    require('render-markdown').setup({})

    add({
        source = 'iamcco/markdown-preview.nvim',
    })
end)

later(function()
    add({ source = "stevearc/quicker.nvim" })
    require("quicker").setup()
    vim.keymap.set("n", "<leader>qf", function()
        require("quicker").toggle()
    end, {
        desc = "Toggle quickfix",
    })
    vim.keymap.set("n", "<leader>ql", function()
        require("quicker").toggle({ loclist = true })
    end, {
        desc = "Toggle loclist",
    })
end)

later(function()
    add({ source = "folke/trouble.nvim", depends = { "ibhagwan/fzf-lua" } })
    require('trouble').setup()
    local config = require("fzf-lua.config")
    local actions = require("trouble.sources.fzf").actions
    config.defaults.actions.files["ctrl-t"] = actions.open
end)


later(function()
    add({ source = "epwalsh/obsidian.nvim", depends = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" } })
    require("obsidian").setup({
        workspaces = {
            {
                name = "personal",
                path = "~/vaults/personal",
            },
            {
                name = "work",
                path = "~/vaults/work",
            },
        },

        -- see below for full list of options 👇
    })
end)
