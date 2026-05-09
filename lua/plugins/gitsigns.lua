local function set_change_hl()
	vim.api.nvim_set_hl(0, "GitSignsChange",       { fg = "#f38ba8" })
	vim.api.nvim_set_hl(0, "GitSignsChangedelete",  { fg = "#f38ba8" })
	vim.api.nvim_set_hl(0, "GitSignsChangeNr",      { fg = "#f38ba8" })
	vim.api.nvim_set_hl(0, "GitSignsChangeLn",      { fg = "#f38ba8" })
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("gitsigns").setup({
		signs = {
			add          = { text = "▎" },
			change       = { text = "░" },
			delete       = { text = "▁" },
			topdelete    = { text = "▔" },
			changedelete = { text = "▒" },
			untracked    = { text = "╎" },
		},
		numhl = true,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 500,
			ignore_whitespace = true,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc, silent = true })
			end

			-- Navigare (cu protecție pentru modul diff)
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd("normal! ]c")
					return
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
			end, "Next hunk")

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd("normal! [c")
					return
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
			end, "Prev hunk")

			-- Acțiuni
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage hunk visual")
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset hunk visual")

			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hP", gs.preview_hunk_inline, "Preview hunk inline")
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")
			map("n", "<leader>hd", gs.diffthis, "Diff this")
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "Diff this ~")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
			map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk (around)")

			-- Extra utile
			map("n", "<leader>ht", gs.toggle_deleted, "Toggle show deleted")
			map("n", "<leader>hW", gs.toggle_word_diff, "Toggle word diff")
		end,
		})

		set_change_hl()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = set_change_hl })
	end,
}
