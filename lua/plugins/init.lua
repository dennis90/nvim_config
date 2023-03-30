return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{
		"tpope/vim-fugitive",
		keys = { { "<leader>gs", "<CMD>Git<CR>" } },
	},
	"folke/neodev.nvim",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end)

			vim.keymap.set("n", "<leader>gph", gs.preview_hunk, { desc = "[G]it [P]review [H]unk" })
			vim.keymap.set("n", "<leader>gbl", gs.toggle_current_line_blame, { desc = "[G]it [B]lame [L]ine" })

			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	}, -- Add indentation guides even on blank lines
	{
		"numToStr/Comment.nvim",
		config = {},
	}, -- "gc" to comment visual regions/lines

	{
		"nvim-lua/plenary.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
		},
	},

	{
		"theprimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			vim.keymap.set("n", "<leader>m", mark.add_file, { desc = "Harpoon mark file" })
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })

			vim.keymap.set("n", "<C-h>", function()
				ui.nav_file(1)
			end, { desc = "Harpoon file 1" })
			vim.keymap.set("n", "<C-j>", function()
				ui.nav_file(2)
			end, { desc = "Harpoon file 2" })
			vim.keymap.set("n", "<C-k>", function()
				ui.nav_file(3)
			end, { desc = "Harpoon file 3" })
			vim.keymap.set("n", "<C-l>", function()
				ui.nav_file(4)
			end, { desc = "Harpoon file 4" })
		end,
	},

	{
		"barklan/capslock.nvim",
		config = function()
			require("capslock").setup()
			vim.keymap.set("i", "<C-l>", "<Plug>CapsLockToggle", { desc = "Virtual capslock" })
		end,
	},

	"github/copilot.vim",
	"eandrju/cellular-automaton.nvim",

	{
		"nvim-treesitter/playground",
		lazy = false,
	},
}
