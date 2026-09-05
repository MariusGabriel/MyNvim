return {
	'echasnovski/mini.cursorword',
	event = 'VeryLazy',
	version = '*',
	config = function()
		require('mini.cursorword').setup()
		vim.api.nvim_set_hl(0, 'MiniCursorword', { underline = true, sp = '#7ec8a0' })
		vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { underline = true, sp = '#e8c46a' })
	end,
}
