return {
	"code-biscuits/nvim-biscuits",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufReadPost",
	config = function()
		require("nvim-biscuits").setup({
			show_on_start = true,
			cursor_line_only = false,
			trim_by_words = true, -- taie textul dupa cuvinte, nu caractere

			default_config = {
				prefix_string = "  ",
				max_length = 40,
				min_distance = 5,
				disabled = false,
			},

			language_config = {
				lua = {
					prefix_string = "  ",
					max_length = 40,
				},
				python = {
					prefix_string = "  ",
					max_length = 40,
				},
				javascript = {
					prefix_string = " 󰌞 ",
					max_length = 40,
				},
				typescript = {
					prefix_string = " 󰛦 ",
					max_length = 40,
				},
				javascriptreact = {
					prefix_string = " 󰜈 ",
					max_length = 40,
				},
				typescriptreact = {
					prefix_string = " 󰜈 ",
					max_length = 40,
				},
				rust = {
					prefix_string = " 󱘗 ",
					max_length = 40,
				},
				go = {
					prefix_string = " 󰟓 ",
					max_length = 40,
				},
				cpp = {
					prefix_string = " 󰙲 ",
					max_length = 40,
				},
				c = {
					prefix_string = " 󰙱 ",
					max_length = 40,
				},
				java = {
					prefix_string = " 󰬷 ",
					max_length = 40,
				},
				html = {
					prefix_string = " 󰌝 ",
					max_length = 40,
				},
				css = {
					prefix_string = " 󰌜 ",
					max_length = 40,
				},
				vue = {
					prefix_string = " 󰡄 ",
					max_length = 40,
				},
				json = {
					disabled = true, -- json nu are nevoie de biscuits
				},
				yaml = {
					disabled = true,
				},
			},

			-- toggle cu keymap
			on_events = { "InsertLeave", "CursorHoldI" },
		})

		vim.keymap.set("n", "<leader>zb", function()
			require("nvim-biscuits").toggle_biscuits()
		end, { desc = "Toggle biscuits" })
	end,
}
