return {
	"jiaoshijie/undotree",
	event = "VeryLazy", -- <leader>u se defineste in config
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("undotree").setup({
			float_diff = true,
			layout = "left_bottom",
			position = "right",
			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"neo-tree",
			},
			window = {
				width = 0.3,
				height = 0.3,
				border = "rounded",
			},
			keymaps = {
				["move_next"] = "j",
				["move_prev"] = "k",
				["move2parent"] = "gj",
				["move_change_next"] = "J",
				["move_change_prev"] = "K",
				["action_enter"] = "<cr>",
				["enter_diffbuf"] = "p",
				["quit"] = "q",
				["update_undotree_view"] = "S",
			},
		})

		vim.keymap.set("n", "<leader>u", require("undotree").toggle, { desc = "Toggle undotree" })
	end,
}
