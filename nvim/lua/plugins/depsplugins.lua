local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- Safely execute immediately
-- now(function()
--   vim.o.termguicolors = true
--   vim.cmd('colorscheme cyberdream')
-- end)
now(function()
    require('mini.notify').setup()
    vim.notify = require('mini.notify').make_notify()
end)
now(function() require('mini.icons').setup() end)
-- now(function() require('mini.tabline').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.cursorword').setup() end)

--- --
later(function()
    require('mini.ai').setup()
    require('mini.animate').setup()
    require('mini.basics').setup()
    require('mini.bracketed').setup()
    require('mini.bufremove').setup()
    require('mini.comment').setup()
    require('mini.completion').setup()
    require('mini.clue').setup()
    require('mini.diff').setup()
    require('mini.extra').setup()
    require('mini.files').setup()
    require('mini.git').setup()
    require('mini.indentscope').setup()
    require('mini.jump').setup()
    require('mini.jump2d').setup()
    require('mini.map').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pick').setup()
    require('mini.surround').setup()
    require('mini.pairs').setup()
    require('mini.sessions').setup()
    require('mini.splitjoin').setup()
    require('mini.test').setup()
    require('mini.trailspace').setup()
    require('mini.visits').setup()
end)

later(function()
    local gen_loader = require('mini.snippets').gen_loader
    require('mini.snippets').setup({
        snippets = {
            -- Load custom file with global snippets first (adjust for Windows)
            gen_loader.from_file('~/local/nvim/snippets/global.json'),
            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
    })
end)

-- colorscheme and dashboard..
now(function()
    add({ source = "scottmckendry/cyberdream.nvim" })
    require('cyberdream').setup({
        transparent = true,
    })

    add({ source = 'aliqyan-21/darkvoid.nvim' })
    require('darkvoid').setup({
        transparent = false,
        glow = false,
        show_end_of_buffer = true,
    })
    vim.cmd("colorscheme darkvoid")
end)


later(function()
    add({ source = "catgoose/nvim-colorizer.lua" })
    require("colorizer").setup()
end)

now(function()
    add({
        source = 'goolord/alpha-nvim',
        depends = { 'echasnovski/mini.icons' }
    })
    require 'alpha'.setup(require 'alpha.themes.startify'.config)
end)


later(function()
    add({ source = '2kabhishek/termim.nvim' })
    add({ source = 'pluffie/neoproj' })
end)

later(function()
    add({
        source = 'nanotee/zoxide.vim',
        depends = { 'junegunn/fzf', 'junegunn/fzf.vim' }
    })
end)
