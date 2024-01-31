vim.keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', { desc = 'Dismiss noice message', noremap = true, silent = true })

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  -- config = function()
  --   require('noice').config()
  -- end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
