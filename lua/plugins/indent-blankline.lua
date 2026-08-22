return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",

	opts = {
		indent = {
			char = "▏",
			highlight = { "IblIndent1", "IblIndent2", "IblIndent3", "IblIndent4" },
		},

		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			injected_languages = false,
			priority = 1024,
			highlight = "IblScope",
		},

		exclude = {
			buftypes = { "terminal", "nofile" },
			filetypes = { "help", "packer", "NvimTree", "conf", "alpha", "FTerm", "oil", "dashboard" },
		},
	},

	config = function(_, opts)
		local function set_ibl_hls()
			vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#2e4830" })
			vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#1e3038" })
			vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#483020" })
			vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#382038" })
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#5a9a6a" })
		end

		set_ibl_hls()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_ibl_hls,
		})

		require("ibl").setup(opts)
	end,
}
