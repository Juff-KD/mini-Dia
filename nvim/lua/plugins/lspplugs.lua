local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add({ source = "zbirenbaum/copilot.lua" })
require("copilot").setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
    }
})

later(function()
    -- Use other plugins with `add()`. It ensures plugin is available in current
    -- session (installs if absent)
    add({ source = 'nvimdev/lspsaga.nvim', depends = { 'neovim/nvim-lspconfig' } })

    add({
        source = 'neovim/nvim-lspconfig',
        -- Supply dependencies near target plugin
        depends = { 'williamboman/mason.nvim',
            "williamboman/mason-lspconfig.nvim",
            "stevearc/conform.nvim",
            "zapling/mason-conform.nvim",
            "mfussenegger/nvim-lint",
            "rshkarin/mason-nvim-lint",
            "hrsh7th/nvim-cmp",
            'hrsh7th/cmp-nvim-lsp',
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            -- "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        }
    })
    local lsp_defaults = require("lspconfig").util.default_config

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    -- This should be executed before you configure any language server
    lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- LspAttach is where you enable features that only work
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,

    })

    --md-Oxide
    -- An example nvim-lspconfig capabilities setting
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- setup Markdown Oxide daily note commands
    require("lspconfig").markdown_oxide.setup({
        -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
        -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
        capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            {
                workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                },
            }
        ),
        on_attach = on_attach -- configure your on attach config
    })
    -- setup Markdown Oxide daily note commands

    --cmp {}
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    cmp.setup({
        sources = cmp.config.sources({
            { name = "luasnip",          keyword_length = 2 },
            { name = "friendly-snippets" },
            { name = "buffer" },
            { name = 'render-markdown' },
            { name = 'ecolog' },
            {
                name = 'nvim_lsp',
                option = {
                    markdown_oxide = {
                        keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
                    }
                }
            },
        }),
        mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, false),
                        ""
                    )
                else
                    fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    vim.fn.feedkeys(
                        vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, false),
                        ""
                    )
                else
                    fallback()
                end
            end,
        }),
        sinppet = {
            expand = function(args)
                vim.snippet.expand(args.body)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    })

    -- mason {}
    require("mason").setup()
    require("mason-conform").setup()
    require("mason-nvim-lint").setup({
        ignore_install = { 'janet', 'ruby', 'clj-kondo', 'inko', 'hadolint', 'tflint' },
    })
    -- require("mason-nvim-dap").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls" },
        handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
            lua_ls = function()
                require("lspconfig").lua_ls.setup({
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                            diagnostics = {
                                disable = { "missing-fields" },
                            },
                        },
                    },
                })
            end,

        },
    })

    -- conform
    require("conform").setup({
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    })
end)

later(function()
    add({
        source = 'nvim-treesitter/nvim-treesitter',
        -- Use 'master' while monitoring updates in 'main'
        checkout = 'master',
        monitor = 'main',
        -- Perform action after every checkout
        hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
    })
    add({ source = 'nvim-treesitter/nvim-treesitter-textobjects' })
    add({ source = 'nvim-treesitter/nvim-treesitter-context' })
    --
    add({ source = 'mawkler/jsx-element.nvim' })
    add({ source = "andymass/vim-matchup" })
    require('nvim-treesitter.configs').setup({
        -- ensure_installed = { 'lua' },
        highlight = { enable = true },
        matchup = {
            enable = true,
        }
    })
end)

later(function()
    add({
        source = 'https://github.com/fatih/vim-go.git',
        hooks = { post_checkout = function() vim.cmd('GoUpdateBinaries') end },
    })
end)

later(function()
    add({ source = "rachartier/tiny-inline-diagnostic.nvim" })
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false })
end)
