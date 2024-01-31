return {
  'github/copilot.vim',
  config = function()
    -- Set copilot settings to use C-j to autocomplete
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
  end,
}
