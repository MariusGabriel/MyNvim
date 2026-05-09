return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		show_help = true,
		show_keys = true,
		preset = "modern",

		-- Eliminăm complet triggerele personalizate pentru g
		-- Lăsăm doar comportamentul implicit
		triggers = {
			{ "<auto>", mode = "nixs" },
		},
		-- Specificăm ce prefixe să NU mai asculte
		-- Asta e varianta corectă
		-- triggers_blacklist = {
		-- 	-- Nu mai asculta pentru 'g' în modurile astea
		-- 	n = { "g" },
		-- 	v = { "g" },
		-- 	x = { "g" },
		-- 	o = { "g" },
		-- },
		delay = 0,

		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
			ellipsis = "…",
			mappings = true,
			rules = {},
			colors = true,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},

		-- Grupuri personalizate
		spec = {
			{ "<leader>g", group = "Git" },
			-- Eliminăm grupul pentru "g" ca să nu mai creeze conflict
		},
	},
	keys = {
		{
			"<leader>,",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
