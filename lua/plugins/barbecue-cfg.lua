return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("barbecue").setup({
			attach_navic = true,
			create_autocmd = true,
			include_buftypes = { "" },
			exclude_filetypes = {
				"netrw", "toggleterm", "neo-tree",
				"alpha", "dashboard", "help", "lazy", "mason",
			},

			modifiers = { dirname = ":~:.", basename = "" },

			show_dirname = true,
			show_basename = true,
			show_modified = true,

			modified = function(bufnr)
				return vim.bo[bufnr].modified
			end,

			show_navic = true,
			context_follow_icon_color = false,

			lead_custom_section = function() return " " end,
			custom_section = function() return " " end,

			theme = "auto",

			symbols = {
				modified  = "●",
				ellipsis  = "…",
				separator = "",
			},

			})

		vim.api.nvim_set_hl(0, "WinBar",   { bg = "NONE", fg = "#d8c9a3" })
		vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE", fg = "#4a5a4a" })
	end,
}
