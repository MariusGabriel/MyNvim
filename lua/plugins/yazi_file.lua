return
---@type LazySpec
{
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>o",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<leader>yy",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi in nvim's working directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	---@type YaziConfig | {}
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
		},
		highlight_hovered_buffers_in_same_directory = true,
		open_multiple_tabs = true,
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_border = "rounded",
		integrations = {
			grep_in_directory = "fzf-lua",
			grep_in_selected_files = "fzf-lua",
		},
	},
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
