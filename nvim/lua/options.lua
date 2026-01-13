-- Show line numbers toggle
vim.o.number = true

-- Mouse mode toggle
vim.o.mouse = 'a'

-- Show mode in status line
vim.o.showmode = false

-- Sync OS and Neovim clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Breakindent toggle
vim.o.breakindent = true
-- Breakindent character
vim.o.showbreak = '> '

-- Save undo history toggle
vim.o.undofile = true

-- Case insensitive serach unless one or more capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Sign column (~) setting
vim.o.signcolumn = 'yes' 

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Enable Bottom and Right split panes
vim.o.splitright = true
vim.o.splitbelow = true

-- Show (:s) substitutions while typing
vim.o.inccommand = 'nosplit' 

-- Highlight current cursor line
vim.o.cursorline = true

-- Set indentation to 4 spaces
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- Minimal amout of lines above and below cursor
vim.o.scrolloff = 10
