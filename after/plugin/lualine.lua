local lualine = require('lualine')

require("capslock").setup()
vim.keymap.set({ "i", "c", "n" }, "<C-g>c", "<Plug>CapsLockToggle")
vim.keymap.set("i", "<C-l>", "<Plug>CapsLockToggle")

lualine.setup {
  options = {
    theme = 'rose-pine',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'diagnostics', {'filename', path = 1}},
    lualine_x = {'filetype'},
    lualine_y = {'progress', 'location'},
    lualine_z = {require'capslock'.status_string},
  },
--  inactive_sections = {
--    lualine_a = {},
--    lualine_b = {},
--    lualine_c = {'filename'},
--    lualine_x = {'location'},
--    lualine_y = {},
--    lualine_z = {}
--  },
  tabline = {},
  extensions = {}
}
