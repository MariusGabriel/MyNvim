return {
	"akinsho/toggleterm.nvim",
	-- tag = "*",

	config = function()
		require("toggleterm").setup({

			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = { "none", "fzf" },
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			autochdir = false,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
			responsiveness = {
				-- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
				-- instead of next to each other
				-- default = 0 which means the feature is turned off
				horizontal_breakpoint = 135,
			},
		})
	end,
}
