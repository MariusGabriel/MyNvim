return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",

	opts = {
		indent = { char = "┊" },

		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			injected_languages = false,
			priority = 1024,
		},
	},
	buftype_exclude = { "terminal", "nofile", "FTerm", "alpha" },
	exclude = {
		"help",
		"packer",
		"NvimTree",
		"conf",
		"alpha",
		"FTerm",
		"oil",
		"dashboard",
	},
}
