return
{
  'nvim-mini/mini.nvim',
  event = { 'InsertEnter'},
  version = false,
  config = function()
    -- [[ UI ELEMENTS ]]
    require('mini.icons').setup()
    require('mini.indentscope').setup()
    require('mini.diff').setup()
    require('mini.notify').setup()
    require('mini.statusline').setup()

    -- [[ CODING UTILITIES ]]
    require('mini.comment').setup()
    require('mini.surround').setup()
  end,
}
