-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Notification settings
require("notify").setup({
  background_colour = "#1e222a",
})
