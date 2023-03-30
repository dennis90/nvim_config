return {
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
				mode = "background",
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", configs = true },
		},
		opts = {
			formatting = {
				format = require("tailwindcss-colorizer-cmp").formatter,
			},
		},
	},
}
