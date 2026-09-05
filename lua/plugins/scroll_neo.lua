return {
	"karb94/neoscroll.nvim",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			mappings = {
				-- "<C-u>",
				-- "<C-d>",
				"<C-u>",
				"<C-d>",
				-- "zt",
				-- "zz",
				-- "zb",
			},
		})
	end,
}
