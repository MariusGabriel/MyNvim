-- Setup our JDTLS server any time we open up a java file
vim.cmd([[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'jdtls'.setup_jdtls()
    augroup end
]])

-- Open :help in a centered floating window with border
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local win = vim.api.nvim_get_current_win()

		if vim.api.nvim_win_get_config(win).relative ~= "" then return end

		local width = math.floor(vim.o.columns * 0.85)
		local height = math.floor(vim.o.lines * 0.85)

		vim.api.nvim_win_close(win, false)
		vim.api.nvim_open_win(buf, true, {
			relative = "editor",
			width = width,
			height = height,
			col = math.floor((vim.o.columns - width) / 2),
			row = math.floor((vim.o.lines - height) / 2),
			style = "minimal",
			border = "rounded",
		})

		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
	end,
})
