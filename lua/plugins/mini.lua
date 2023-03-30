return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "<leader>za", -- Add surrounding in Normal and Visual modes
				delete = "<leader>zd", -- Delete surrounding
				find = "<leader>zf", -- Find surrounding (to the right)
				find_left = "<leader>zF", -- Find surrounding (to the left)
				highlight = "<leader>zh", -- Highlight surrounding
				replace = "<leader>zr", -- Replace surrounding
				update_n_lines = "<leader>zn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup(opts)
		end,
	},
	{
		"echasnovski/mini.starter",
		version = "*",
		event = "VimEnter",
		opts = function()
			local pad = string.rep(" ", 12)

			local new_section = function(name, action, section)
				return { name = name, action = action, section = pad .. section }
			end

			local logo = [[
         ________    _           
        / ____/ /_  (_)___  _____
       / /   / __ \/ / __ \/ ___/
      / /___/ / / / / /_/ (__  ) 
      \____/_/ /_/_/ .___/____/  
                  /_/            
      ]]
			local starter = require("mini.starter")
			local config = {
				evaluate_single = true,
				header = logo,
				items = {
					new_section("Find file", "Telescope find_files", "Telescope"),
					new_section("Recent files", "Telescope oldfiles", "Telescope"),
					new_section("Grep text", "Telescope live_grep", "Telescope"),
					new_section("init.lua", "e $MYVIMRC", "Config"),
					new_section("New file", "ene | startinsert", "Built-in"),
					new_section("Quit", "qa", "Built-in"),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(pad .. "░ ", false),
					starter.gen_hook.aligning("center", "center"),
				},
			}
			return config
		end,
		config = function(_, config)
			require("mini.starter").setup(config)
		end,
	},
}
