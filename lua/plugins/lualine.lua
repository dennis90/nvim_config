return {
	"nvim-lualine/lualine.nvim", -- Fancier statusline
	config = {
		options = {
			theme = "tokyonight",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			icons_enabled = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { "diagnostics", { "filename", path = 1 } },
			lualine_x = { "filetype" },
			lualine_y = { "progress", "location" },
			lualine_z = { require("capslock").status_string },
		},
	},
}
