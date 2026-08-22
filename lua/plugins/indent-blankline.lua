return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",

	opts = {
		indent = {
			-- Linie întreruptă. scope-ul moștenește caracterul de aici dacă nu i se
			-- dă unul propriu, deci punctate sunt și nivelurile, și blocul activ.
			char = "┆",
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
		-- Accente Catppuccin Frappé amestecate 45% peste base (#303446): destul cât
		-- să se vadă ghidajele, nu atât cât să concureze cu textul.
		-- Contrast față de fundal: ~2.3–2.7:1 pe niveluri, 6.7:1 pe scope-ul activ.
		local function set_ibl_hls()
			vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#657b64" }) -- green
			vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#596992" }) -- blue
			vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#86645c" }) -- peach
			vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#75648e" }) -- mauve
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#babbf1", bold = true }) -- lavender
		end

		set_ibl_hls()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_ibl_hls,
		})

		require("ibl").setup(opts)
	end,
}
