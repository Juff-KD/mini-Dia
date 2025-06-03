local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add({ source = "igorlfs/nvim-dap-view" })

    add({
        source = 'mfussenegger/nvim-dap',
        depends = { "theHamsta/nvim-dap-virtual-text",
            "mfussenegger/nvim-dap-python",
            "leoluz/nvim-dap-go" }
    })

    add({
        source = "jay-babu/mason-nvim-dap.nvim",
        depends = { "mfussenegger/nvim-dap",
            "williamboman/mason.nvim", }
    })

    --DapView
    local dap, dv = require("dap"), require("dap-view")
    dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
    end
    dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
    end
    dap.listeners.before.event_terminated["dap-view-config"] = function()
        dv.close()
    end
    dap.listeners.before.event_exited["dap-view-config"] = function()
        dv.close()
    end

    --py setup
    local pydap = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/Scripts/python'
    require("dap-python").setup(pydap)

    --go setup

    --js dap
    -- local jsdap = require("mason-registry").get_package("js-debug-adapter")
    require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = { vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', "${port}" },
        }
    }

    require("dap").configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }

    --Dap
    --mason-nvim-dap
    require("mason-nvim-dap").setup({
        handlers = {},
        automatic_installation = {
            -- These will be configured by separate plugins.
            exclude = {
                -- "delve",
                -- "python",
            },
        },
        -- DAP servers: Mason will be invoked to install these if necessary.
        ensure_installed = {
            -- "bash",
            -- "codelldb",
            -- "php",
            -- "python",
        },
    })
end)
