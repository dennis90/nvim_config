return {
	"windwp/nvim-spectre",
	keys = {
		{ "<leader>R", "<cmd>lua require('spectre').open()<CR>", desc = "Find and [R]eplace", mode = "n" },
		-- {"n", "<leader>Rw" },
		-- {"v", "<leader>s"},
		-- {"n", "<leader>sp"},
	},
}

-- nnoremap <leader>S <cmd>lua require('spectre').open()<CR>
--
-- "search current word
-- nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
-- vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
-- "  search in current file
-- nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
