return {
	"jiaoshijie/undotree",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("undotree").setup({
			float_diff = true,
			layout = "right_bottom", -- ← dreapta ca sa nu se bata cu neo-tree
			position = "right",
			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"neo-tree", -- ← ignora neo-tree
			},
			window = {
				winblend = 0,
			},
			keymaps = {
				["j"] = "move_next",
				["k"] = "move_prev",
				["J"] = "move_change_next",
				["K"] = "move_change_prev",
				["<cr>"] = "action_enter",
				["p"] = "enter_diffbuf",
				["q"] = "quit",
			},
		})

		vim.keymap.set("n", "<leader>u", require("undotree").toggle, { desc = "Toggle undotree" })
	end,
}
