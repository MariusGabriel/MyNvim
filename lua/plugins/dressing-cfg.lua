return {
	"stevearc/dressing.nvim",

	config = function()
		require("dressing").setup({
			input = {
				enabled = true,
				default_prompt = "Input",
				trim_prompt = true,
				title_pos = "left",
				start_mode = "insert",
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				win_options = {
					wrap = false,
					list = true,
					listchars = "precedes:…,extends:…",
					sidescrolloff = 3,
				},

				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<C-p>"] = "HistoryPrev",
						["<C-n>"] = "HistoryNext",
					},
				},
			},
			select = {
				enabled = true,
				backend = { "fzf-lua", "telescope", "fzf", "builtin", "nui" },
				trim_prompt = true,
				fzf = {
					window = {
						width = 0.5,
						height = 0.4,
					},
				},
				fzf_lua = {},
				nui = {
					position = "50%",
					relative = "editor",
					border = {
						style = "rounded",
					},
					buf_options = {
						swapfile = false,
						filetype = "DressingSelect",
					},
					win_options = {
						winblend = 0,
					},
					max_width = 80,
					max_height = 40,
					min_width = 40,
					min_height = 10,
				},
				builtin = {
					show_numbers = true,
					border = "rounded",
					relative = "editor",
					win_options = {
						cursorline = true,
						cursorlineopt = "both",
						winhighlight = "MatchParen:",
						statuscolumn = " ",
					},
					max_width = { 140, 0.8 },
					min_width = { 40, 0.2 },
					max_height = 0.9,
					min_height = { 10, 0.2 },
					mappings = {
						["<Esc>"] = "Close",
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
					},
				},
				format_item_override = {},
			},
		})
	end,
}
