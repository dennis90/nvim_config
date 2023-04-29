local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins")

-- Settings
vim.opt.guicursor = ""
vim.wo.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.colorcolumn = "120"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.o.mouse = "a"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Define display explorer command
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew" })

-- Remaps W to w and Q to q
vim.cmd([[ca W w]])
vim.cmd([[ca Q q]])

-- Useful mappings
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find previous and center" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste over selection" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy to clipboard" })

vim.keymap.set("n", "<leader>d", '"_d', { desc = "Cut to clipboard" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Cut to clipboard" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape from insert mode" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>K", "<cmd>cnext<CR>zz", { desc = "Next error" })
vim.keymap.set("n", "<leader>J", "<cmd>cprev<CR>zz", { desc = "Previous error" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous diagnostic" })

-- Remove the terrible cyan theme
vim.cmd([[ colorscheme tokyonight ]])

-- Lsp configure
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.configure("tsserver", {
	on_attach = function(client, bufnr)
		require("twoslash-queries").attach(client, bufnr)
	end,
})

lsp.on_attach(function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
end)

lsp.nvim_workspace()

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

local function format_imports()
	vim.cmd("write", { silent = true })
	vim.fn.system("format-imports " .. vim.fn.expand("%"))
	vim.cmd("e!", { silent = true })
	vim.notify("Formatted imports")
end

-- Import sorter
vim.keymap.set("n", "<leader>o", format_imports, { noremap = true, silent = true, desc = "Format imports" })

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)

		local format_cmd = function(input)
			vim.lsp.buf.format({
				id = client.id,
				timeout_ms = 5000,
				async = input.bang,
			})
		end

		local bufcmd = vim.api.nvim_buf_create_user_command
		bufcmd(bufnr, "NullFormat", format_cmd, {
			bang = true,
			range = true,
			desc = "Format using null-ls",
		})
	end,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		-- null_ls.builtins.diagnostics.cspell.with({
		-- 	filetypes = { "typescript", "markdown", "typescriptreact" },
		-- }),
		-- null_ls.builtins.code_actions.cspell.with({
		-- 	filetypes = { "typescript", "markdown", "typescriptreact" },
		-- }),
	},
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "lua", "python", "rust", "typescript", "help", "vim", "tsx" },

	autotag = { enable = true },
	autopairs = { enable = true },

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- Setup neovim lua configuration
require("neodev").setup()

-- Tailwind must have
require("cmp").config.formatting = {
	format = require("tailwindcss-colorizer-cmp").format,
}

-- Copilot settings
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#83519f" })
vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#83519f" })

vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Fuck my life
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Fuck my life" })

-- Format using null ls
local formatGrp = vim.api.nvim_create_augroup("FormattingGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "NullFormat",
	group = formatGrp,
})

-- Lua snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

-- Copy file path
local function copy_file_path()
	local path = vim.fn.expand("%")
	vim.fn.setreg("+", path)
	vim.notify("Copied " .. path .. " to clipboard")
end

vim.keymap.set("n", "<leader>cf", copy_file_path, { noremap = true, silent = true, desc = "Copy file path" })

vim.keymap.set(
	"n",
	"L",
	"<cmd> call search('\\u')<CR>",
	{ noremap = true, silent = true, desc = "Go to next camel case word" }
)

function ChangeDirectory()
	vim.cmd("cd %:p:h")
end

vim.cmd("command! ChangeDir lua ChangeDirectory()")
