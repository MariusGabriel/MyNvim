return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open LazyGit (root)" },
		{ "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit current file" },
		{ "<leader>gl", "<cmd>LazyGitFilter<cr>", desc = "LazyGit log" },
	},
	-- Configurație opțională
	config = function()
		-- Activează neovim-remote
		vim.g.lazygit_use_neovim_remote = true -- Poți seta opțiuni implicite aici
		vim.g.lazygit_floating_window_winblend = 0 -- transparență
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- dimensiune
		vim.g.lazygit_use_neovim_remote = true -- folosește nvim-remote
	end,
}
