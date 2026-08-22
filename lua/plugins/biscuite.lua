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
				prefix_string = " 󰅩 ",
				max_length = 40,
				min_distance = 5,
				disabled = false,
			},

			-- Doar iconița diferă per limbaj; max_length vine din default_config.
			language_config = {
				lua = { prefix_string = " 󰢱 " },
				python = { prefix_string = " 󰌠 " },
				javascript = { prefix_string = " 󰌞 " },
				typescript = { prefix_string = " 󰛦 " },
				javascriptreact = { prefix_string = " 󰜈 " },
				typescriptreact = { prefix_string = " 󰜈 " },
				rust = { prefix_string = " 󱘗 " },
				go = { prefix_string = " 󰟓 " },
				cpp = { prefix_string = " 󰙲 " },
				c = { prefix_string = " 󰙱 " },
				java = { prefix_string = " 󰬷 " },
				html = { prefix_string = " 󰌝 " },
				css = { prefix_string = " 󰌜 " },
				vue = { prefix_string = " 󰡄 " },
				json = { disabled = true }, -- json are acolade, se vede unde se închide
				-- yaml n-are delimitatori de închidere, deci pe manifeste k8s sau
				-- CI e cazul în care biscuits ajută cel mai mult. min_distance mai
				-- mic decât default: blocurile yaml sunt scurte.
				yaml = { prefix_string = " 󰈙 ", min_distance = 3 },
			},

			-- CursorHold prinde și editările din modul normal (dd, p, u), care
			-- altfel lăsau biscuits-urile învechite până la următorul InsertLeave.
			-- Se declanșează după `updatetime` (250ms) de inactivitate, deci nu
			-- reparsează la fiecare tastă, cum ar face TextChanged.
			on_events = { "InsertLeave", "CursorHoldI", "CursorHold" },
		})

		-- Plugin-ul leagă fiecare BiscuitColor<limbaj> de BiscuitColor printr-un
		-- `highlight default link`, deci e destul să definim grupul de bază.
		-- Implicit e #808080, un gri hardcodat care nu ține de temă.
		local function set_biscuit_hl()
			vim.api.nvim_set_hl(0, "BiscuitColor", { fg = "#737994", italic = true }) -- overlay0
		end

		set_biscuit_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_biscuit_hl })

		vim.keymap.set("n", "<leader>zb", function()
			require("nvim-biscuits").toggle_biscuits()
		end, { desc = "Toggle biscuits" })
	end,
}
