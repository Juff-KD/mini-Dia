local g, o = vim.g, vim.o
-- local options = {
-- General Neovim options
-- guiterm = "alacritty", -- Or your preferred terminal
g.mapleader =
" "                     -- Leader key
g.maplocalleader =
" "                     -- Local leader key
o.conceallevel = 2
o.termguicolors = true  -- Use true colors in the terminal
o.background =
"dark"                  -- Set background (dark or light)
o.swapfile = false      -- Disable swapfiles
o.stal = 1
o.backup = false        -- Disable backups
o.undofile = true       -- Enable undofiles
o.hlsearch = false      -- Disable highlight on search
o.incsearch = true      -- Incremental search
o.smartindent = true    -- Smart indenting
o.wrap = false          -- Don't wrap lines
o.scrolloff = 999       -- Keep cursor in the middle of the screen
o.sidescrolloff = 999   -- Keep cursor in the middle of the screen horizontally
o.number = true         -- Show line numbers
o.relativenumber = true -- Show relative line numbers
o.cursorline = true     -- Highlight the current line
o.tabstop = 4           -- Number of spaces per tab
o.softtabstop = 4       -- Number of spaces when pressing <Tab>
o.shiftwidth = 4        -- Number of spaces for indentation
o.expandtab = true      -- Use spaces instead of tabs
o.autoindent = true     -- Auto indent new lines
o.cindent = true        -- C-style indenting
o.mouse = "a"           -- Enable mouse support
o.splitbelow = true     -- Split windows below
o.splitright = true     -- Split windows to the right
--g.wildignore = { "*/.git/*", "*/.svn/*", "*/.hg/*", "*.pyc", "*.class", "*.DS_Store", "*/.cache/*", "*/__pycache__/*" } -- Ignore these files in searches
-- ... other options ...
-- o.ve = all
