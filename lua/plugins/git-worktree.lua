local ok, Worktree = pcall(require, "git-worktree")

if ok ~= false then
	Worktree.on_tree_change(function(op, metadata)
		if op == Worktree.Operations.Create then
			print("Switched from " .. metadata.path .. " to " .. metadata.branch .. " branch" .. metadata.upstream)
		end
	end)
end

local function create_worktree()
	local worktree = require("git-worktree")

	local branch_name = ""
	-- local origin_branch_name = "qa"

	vim.ui.input({
		prompt = "New branch name: ",
	}, function(input)
		branch_name = input
	end)

	-- vim.ui.input({
	-- 	prompt = "Origin branch name (qa): ",
	-- }, function(input)
	-- 	if input ~= "" then
	-- 		origin_branch_name = input
	-- 	end
	-- end)

	worktree.create_worktree(branch_name, branch_name, "origin")
end

local function switch_branch()
	local worktree = require("git-worktree")

	local branch_name = ""

	vim.ui.input({
		prompt = "Branch to switch: ",
	}, function(input)
		branch_name = input
	end)

	worktree.switch_worktree(branch_name)
end

local function delete_branch()
	local worktree = require("git-worktree")

	local branch_name = ""

	vim.ui.input({
		prompt = "Branch to delete: ",
	}, function(input)
		branch_name = input
	end)

	worktree.delete_worktree(branch_name)
end

return {
	"ThePrimeagen/git-worktree.nvim",
	config = function() end,
	keys = {
		{
			"<leader>gcb",
			create_worktree,
			desc = "[G]it [C]reate [B]ranch",
		},
		{
			"<leader>gsb",
			switch_branch,
			desc = "[G]it [S]witch [W]orktree",
		},
		{
			"<leader>gdb",
			delete_branch,
			desc = "[G]it [D]elete [B]ranch",
		},
		{
			"<leader>glb",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
			desc = "[G]it [L]ist [B]ranches",
		},
		-- {
		-- 	"<leader>gcb",
		-- 	function()
		-- 		require("telescope").extensions.git_worktree.create_git_worktree()
		-- 	end,
		-- 	desc = "[G]it [C]reate [B]ranch",
		-- },
	},
}
