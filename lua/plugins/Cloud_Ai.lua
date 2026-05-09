return {
	"folke/sidekick.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		nes = { enabled = false },
		cli = {
			win = {
				layout = "right",
				split = { width = 60 },
			},
			tools = {
				claude = {}, -- folosește config-ul default din sidekick
			},
		},
	},
	keys = {
		{
			"<c-a>",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			mode = { "n", "t", "i" },
			desc = "Toggle Claude Code",
		},
		{
			"<leader>vf",
			":lua require('sidekick.cli').send({ msg = '{file}' })<cr>",
			mode = { "n", "x" },
			desc = "Send file to Claude",
		},
		{
			"<leader>va",
			":lua require('sidekick.cli').send({ msg = '{selection}' })<cr>",
			mode = "x",
			desc = "Send selection to Claude",
		},
		{
			"<leader>vp",
			":lua require('sidekick.cli').prompt()<cr>",
			mode = { "n", "x" },
			desc = "Select prompt",
		},
		{
			"<leader>ve",
			":lua require('sidekick.cli').send({ msg = 'Explain {this}' })<cr>",
			mode = { "n", "x" },
			desc = "Explain this",
		},
		{
			"<leader>vx",
			":lua require('sidekick.cli').send({ msg = 'Can you fix {this}?' })<cr>",
			mode = { "n", "x" },
			desc = "Fix this",
		},
	},
}
