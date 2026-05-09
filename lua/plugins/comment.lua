return {
	"numToStr/Comment.nvim",
	enabled = true,
	lazy = true,
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = true,
		})

		require("Comment").setup({})

		-- Setează commentstring pentru toate shell-urile
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sh", "bash", "zsh", "ksh", "fish" },
			callback = function()
				vim.bo.commentstring = "# %s"
			end,
		})

		-- Verifică și pentru extensia .zsh direct
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*.zsh",
			callback = function()
				vim.bo.filetype = "zsh"
				vim.bo.commentstring = "# %s"
			end,
		})

		pcall(vim.keymap.del, "n", "<space>/")
		vim.keymap.set("n", "<space>/", "<Plug>(comment_toggle_linewise_current)", {
			desc = "Comment Line",
			nowait = true,
			noremap = true,
			silent = true,
		})
		vim.keymap.set("v", "<space>/", "<Plug>(comment_toggle_linewise_visual)", {
			desc = "Comment Selected",
			nowait = true,
			noremap = true,
			silent = true,
		})

		local keys_to_delete = { "gc", "gcc", "gcO", "gco", "gcA", "gb", "gbc" }
		for _, key in ipairs(keys_to_delete) do
			pcall(vim.keymap.del, "n", key)
		end
	end,
}
