return 
{
    'kepano/flexoki-neovim',
    lazy = false,
    name = 'flexoki', 
    priority = 1000, 
    config = function()
        vim.cmd.colorscheme 'flexoki-dark' -- Load the colorscheme
    end,
}
