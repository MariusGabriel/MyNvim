return {
	"akinsho/toggleterm.nvim",
	-- tag = "*",

	config = function()
		-- terminal ANSI palette — warm overlay matching the-matrix theme
		vim.g.terminal_color_0 = "#0d1a0d" -- black
		vim.g.terminal_color_1 = "#c86a5a" -- red
		vim.g.terminal_color_2 = "#7ec8a0" -- green
		vim.g.terminal_color_3 = "#e8c46a" -- yellow/amber
		vim.g.terminal_color_4 = "#7db5c8" -- blue
		vim.g.terminal_color_5 = "#9a7ab8" -- magenta
		vim.g.terminal_color_6 = "#7aac88" -- cyan
		vim.g.terminal_color_7 = "#d8c9a3" -- white/cream
		vim.g.terminal_color_8 = "#4a5a4a" -- bright black
		vim.g.terminal_color_9 = "#e08060" -- bright red
		vim.g.terminal_color_10 = "#a0c090" -- bright green
		vim.g.terminal_color_11 = "#fff0c0" -- bright yellow
		vim.g.terminal_color_12 = "#6a9fb5" -- bright blue
		vim.g.terminal_color_13 = "#c8a87a" -- bright magenta
		vim.g.terminal_color_14 = "#b8cca8" -- bright cyan
		vim.g.terminal_color_15 = "#e0d4b0" -- bright white

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
			highlights = {
				Normal = { bg = "NONE", fg = "#d8c9a3" },
				NormalFloat = { bg = "NONE", fg = "#d8c9a3" },
				FloatBorder = { bg = "NONE", fg = "#4a6a4a" },
				StatusLine = { bg = "NONE", fg = "#d8c9a3" },
				StatusLineNC = { bg = "NONE", fg = "#4a5a4a" },
			},
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "FloatBorder",
					background = "NormalFloat",
				},
			},
			responsiveness = {
				horizontal_breakpoint = 135,
			},
		})
	end,
}
