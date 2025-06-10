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
        depends = { 'echasnovski/mini.nvim' }
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
    add({
        source = 'pwntester/octo.nvim',
        depends = { 'nvim-lua/plenary.nvim', "ibhagwan/fzf-lua", 'echasnovski/mini.icons' }
    })
    require("octo").setup({
        picker = "fzf-lua",
    })

    add({ source = "folke/snacks.nvim" })
    require("snacks").setup({
        picker = { enabled = true },
        bigfile = { enabled = true },
        rename = { enabled = true },
        lazygit = { enabled = true },
        dim = { enabled = true },
    })
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

later(function()
    add({ source = "vuki656/package-info.nvim", depends = { "MunifTanjim/nui.nvim" } })
    -- Show dependency versions
    vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })

    -- Hide dependency versions
    vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })

    -- Toggle dependency versions
    vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })

    -- Update dependency on the line
    vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })

    -- Delete dependency on the line
    vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })

    -- Install a new dependency
    vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })

    -- Install a different dependency version
    vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })
end)

later(function()
    add({ source = 't3ntxcl3s/ecolog.nvim' })
    require('ecolog').setup({
        preferred_environment = 'local',
        types = true,
        providers = {
            {
                pattern = '{{[%w_]+}}?$',
                filetype = 'http',
                extract_var = function(line, col)
                    local utils = require 'ecolog.utils'
                    return utils.extract_env_var(line, col, '{{([%w_]+)}}?$')
                end,
                get_completion_trigger = function()
                    return '{{'
                end,
            },
        },
        interpolation = {
            enabled = true,
            features = {
                commands = false,
            },
        },
        sort_var_fn = function(a, b)
            if a.source == 'shell' and b.source ~= 'shell' then
                return false
            end
            if a.source ~= 'shell' and b.source == 'shell' then
                return true
            end

            return a.name < b.name
        end,
        integrations = {
            lspsaga = true,
            nvim_cmp = true,
            statusline = {
                hidden_mode = true,
                highlights = {
                    env_file = 'Directory',
                    vars_count = 'Number',
                },
            },
            snacks = true,
        },
        shelter = {
            configuration = {
                sources = {
                    ['.env.example'] = 'none',
                },
                partial_mode = {
                    min_mask = 5,
                    show_start = 1,
                    show_end = 1,
                },
                mask_char = '*',
            },
            modules = {
                files = true,
                peek = false,
                fzf_previewer = true,
                snacks = false,
                cmp = true,
            },
        },
        path = vim.fn.getcwd()
    })
end)
