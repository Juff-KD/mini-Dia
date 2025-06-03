local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
    add({
        source = 'tanvirtin/vgit.nvim',
        depends = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    })
    require("vgit").setup()
end)

later(function()
    add({ source = 'lewis6991/gitsigns.nvim' })
    require('gitsigns').setup()
end)
