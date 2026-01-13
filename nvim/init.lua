-- Mapping leader key to <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable Nerd-Font
vim.g.have_nerd_font = true

-------------------------------------
-- Setting ./lua/options.lua
require 'options'

-- Setting ./lua/keymaps.lua
require 'keymaps'

-- Initializing ./lua/lazybootstrap.lua
require 'lazybootstrap'

-- Setting ./lua/plugins/*
require("lazy").setup({
    spec = { 
        { import = 'plugins' }
    },
    -- Setting installer colorscheme
    install = { colorscheme = { "flexoki-dark" } },
    -- Check for updates on start
    checker = { enabled = true },
})
