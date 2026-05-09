return {
	"NStefan002/screenkey.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("screenkey").setup({
			win_opts = {
				width = 30,
				height = 1,
				border = "rounded",
				style = "minimal",
			},
			compress_after = 3,
			clear_after = 3,
			show_leader = true,
		})

		-- Culoare portocalie
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "screenkey",
			callback = function(ev)
				vim.api.nvim_set_hl(0, "ScreenkeyWin", { fg = "#FFA500", bg = "NONE" })
				vim.api.nvim_win_set_option(
					vim.fn.bufwinid(ev.buf),
					"winhighlight",
					"Normal:ScreenkeyWin,NormalFloat:ScreenkeyWin"
				)
			end,
		})

		-- Pornit automat după ce pluginul e încărcat
		vim.schedule(function()
			require("screenkey").toggle()
		end)
	end,
}
