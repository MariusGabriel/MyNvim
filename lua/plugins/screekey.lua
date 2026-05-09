return {
	"NStefan002/screenkey.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		vim.g.screenkey_statusline_component = true

		require("screenkey").setup({
			compress_after = 3,
			clear_after = 3,
			show_leader = true,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = { "ScreenkeyUpdated", "ScreenkeyCleared" },
			callback = function()
				require("lualine").refresh()
			end,
		})
	end,
}
