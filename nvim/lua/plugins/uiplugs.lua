local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    add({ source = "y3owk1n/undo-glow.nvim", checkout = "main" })
    require("undo-glow").setup()
end)

-- NOTE: (using) tido-comments instead or mini-hipatterns
later(function()
    add({ source = "catgoose/nvim-colorizer.lua" })
    require("colorizer").setup()
    -- =================+++++=====================
    add({ source = 'HiPhish/rainbow-delimiters.nvim' })

    --  ==============++++========================

    add({ source = "folke/todo-comments.nvim" })
    require("todo-comments").setup()

    --NOTE: keymap for todo-comments
    vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })

    --  ==============++++========================
    add({ source = "aidancz/buvvers.nvim" })
    require("buvvers").setup({
        name_prefix = function(buffer_handle)
            local icon, hl = MiniIcons.get("file", vim.api.nvim_buf_get_name(buffer_handle))
            return {
                icon .. " ",
                hl,
            }
        end,
    })
    vim.keymap.set("n", "<leader>b", require("buvvers").toggle)
end)
