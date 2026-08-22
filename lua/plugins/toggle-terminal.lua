return {
	"akinsho/toggleterm.nvim",
	-- tag = "*",

	config = function()
		-- Paleta ANSI vine din colorschemă (colors/maple-dark.lua), nu de aici.
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
