return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons", { "rktjmp/lush.nvim", lazy = true } },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	opts = {},

	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
			desc = "[F]ind [F]iles in [P]roject [D]irectory",
		},
		{
			"<leader>gf",
			function()
				require("fzf-lua").live_grep()
			end,
			desc = "[F]ind by [G]repping in [P]roject [D]irectory",
		},
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = "~/.config" })
			end,
			desc = "[F]ind in [N]eovim [C]onfiguration",
		},
		{
			"<leader>fh",
			function()
				require("fzf-lua").helptags()
			end,
			desc = "[F]ind [H]elp",
		},
		{
			"<leader>fk",
			function()
				require("fzf-lua").keymaps()
			end,
			desc = "[F]ind [K]eymaps",
		},
		{
			"<leader>fb",
			function()
				require("fzf-lua").builtin()
			end,
			desc = "[F]ind [B]uiltin FZF",
		},
		{
			"<leader>fw",
			function()
				require("fzf-lua").grep_cword()
			end,
			desc = "[F]ind curreent [W]ord",
		},
		{
			"<leader>fW",
			function()
				require("fzf-lua").grep_cWORD()
			end,
			desc = "[F]ind curreent [W]ORD",
		},

		{
			"<leader>fd",
			function()
				require("fzf-lua").diagnostics_document()
			end,
			desc = "[F]ind [D]iagnostics",
		},
		{
			"<leader>fr",
			function()
				require("fzf-lua").resume()
			end,
			desc = "[F]ind [R]esume",
		},
		{
			"<leader>fo",
			function()
				require("fzf-lua").oldfiles()
			end,
			desc = "[F]ind [O]ld [F]iles",
		},
		{
			"<leader>bb",
			function()
				require("fzf-lua").buffers()
			end,
			desc = "[F]ind [B]uffers",
		},
		{
			-- <leader>gF, nu <leader>ggf: altfel `<leader>gg` (lazygit) devine prefix
			-- și așteaptă `timeoutlen`. Perechea e <leader>gf = grep pe proiect.
			"<leader>gF",
			function()
				require("fzf-lua").lgrep_curbuf()
			end,
			desc = "[gF] Live grep the current buffer",
		},
	},
}
