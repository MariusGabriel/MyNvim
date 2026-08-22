return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local pinned_buffers = {}

		local function toggle_pin()
			local bufnr = vim.api.nvim_get_current_buf()
			if pinned_buffers[bufnr] then
				pinned_buffers[bufnr] = nil
				vim.notify("Buffer unpinned", vim.log.levels.INFO)
			else
				pinned_buffers[bufnr] = true
				vim.notify("Buffer pinned", vim.log.levels.INFO)
			end
			vim.cmd("redrawtabline")
		end

		-- south.nvim palette (matches lua_line.lua)
		local C = {
			fill    = "#edf2fd", -- darker_background
			active  = "#e4eaf3", -- cool_light_grey
			inactive= "#edf2fd",
			text_a  = "#323b45", -- black
			text_i  = "#9097a6", -- cool_dark_grey
			text_on = "#fcfcfd", -- text on mode color
			sep     = "#e4eaf3",
			mod     = "#d99610", -- gold
			err     = "#c1293d", -- auburn
			warn    = "#d99610",
			accent  = "#2b9728", -- grass
		}

		local mode_colors = {
			n  = "#2b9728", -- grass
			i  = "#0092bf", -- aqua
			v  = "#615FB9", -- purple
			V  = "#615FB9",
			["\22"] = "#615FB9",
			R  = "#c1293d", -- auburn
			c  = "#d99610", -- gold
			t  = "#0092bf",
		}

		local function update_hl()
			local m = vim.api.nvim_get_mode().mode
			local bg = mode_colors[m:sub(1, 1)] or "#1D5AB5"
			vim.api.nvim_set_hl(0, "BufferLineBufferSelected",      { fg = C.text_on, bg = bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineTabSelected",         { fg = C.text_on, bg = bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected",   { fg = bg, bg = bg })
			vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = C.text_on, bg = bg })
			vim.api.nvim_set_hl(0, "BufferLineModifiedSelected",    { fg = C.text_on, bg = bg })
			vim.api.nvim_set_hl(0, "BufferLineErrorSelected",       { fg = C.text_on, bg = bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineWarningSelected",     { fg = C.text_on, bg = bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected",   { fg = C.text_on, bg = bg, italic = true })
			vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected",   { fg = bg, bg = C.fill })
			for _, name in ipairs(vim.fn.getcompletion("BufferLineDevIcon", "highlight")) do
				local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
				local icon_bg = name:match("Selected$") and bg or C.inactive
				vim.api.nvim_set_hl(0, name, { fg = hl.fg, bg = icon_bg })
			end
			vim.cmd("redrawtabline")
		end

		require("bufferline").setup({
			highlights = {
				fill                = { bg = C.fill },
				background          = { fg = C.text_i, bg = C.inactive },
				buffer_selected     = { fg = C.text_a, bg = C.active, bold = true },
				buffer_visible      = { fg = C.text_i, bg = C.inactive },
				indicator_selected  = { fg = C.accent, bg = C.active },
				indicator_visible   = { fg = C.inactive, bg = C.inactive },
				modified            = { fg = C.mod, bg = C.inactive },
				modified_selected   = { fg = C.mod, bg = C.active },
				modified_visible    = { fg = C.mod, bg = C.inactive },
				close_button        = { fg = C.text_i, bg = C.inactive },
				close_button_selected = { fg = C.text_on, bg = C.active },
				close_button_visible = { fg = C.text_i, bg = C.inactive },
				separator           = { fg = C.inactive, bg = C.fill },
				separator_selected  = { fg = C.active, bg = C.fill },
				separator_visible   = { fg = C.inactive, bg = C.fill },
				tab                 = { fg = C.text_i, bg = C.inactive },
				tab_selected        = { fg = C.text_a, bg = C.active, bold = true },
				tab_close           = { fg = C.text_i, bg = C.inactive },
				duplicate           = { fg = C.text_i, bg = C.inactive, italic = true },
				duplicate_selected  = { fg = C.text_a, bg = C.active, italic = true },
				duplicate_visible   = { fg = C.text_i, bg = C.inactive, italic = true },
				error               = { fg = C.err, bg = C.inactive },
				error_selected      = { fg = C.err, bg = C.active, bold = true },
				error_visible       = { fg = C.err, bg = C.inactive },
				warning             = { fg = C.warn, bg = C.inactive },
				warning_selected    = { fg = C.warn, bg = C.active, bold = true },
				warning_visible     = { fg = C.warn, bg = C.inactive },
			},
			options = {
				mode = "buffers",
				numbers = "none",
				close_command = function(bufnr)
					if pinned_buffers[bufnr] then
						vim.notify("Unpin first!", vim.log.levels.WARN)
					else
						vim.cmd("bdelete! " .. bufnr)
					end
				end,
				right_mouse_command = "bdelete! %d",
				left_mouse_command  = "buffer %d",
				middle_mouse_command = "bdelete! %d",
				indicator = { style = "icon", icon = "▎" },
				buffer_close_icon  = "✕",
				modified_icon      = "●",
				close_icon         = "✕",
				left_trunc_marker  = "◀",
				right_trunc_marker = "▶",
				name_formatter = function(buf)
					local pinned = pinned_buffers[buf.bufnr] and " " or ""
					return " " .. pinned .. buf.name .. " "
				end,
				max_name_length    = 30,
				truncate_names     = true,
				diagnostics        = false,
				custom_filter = function(bufnr)
					local ft = vim.bo[bufnr].filetype
					for _, s in ipairs({ "help", "qf", "TelescopePrompt", "neo-tree", "NvimTree", "Oil" }) do
						if ft == s then return false end
					end
					return true
				end,
				offsets = {
					{
						filetype   = "neo-tree",
						text       = "󰪧 Explorer",
						text_align = "left",
						separator  = true,
					},
				},
				separator_style        = { vim.fn.nr2char(0xE0B6), vim.fn.nr2char(0xE0B4) },
				always_show_bufferline = true,
				show_buffer_icons      = true,
				show_buffer_close_icons = true,
				show_close_icon        = true,
				show_tab_indicators    = true,
				show_duplicate_prefix  = true,
				persist_buffer_sort    = true,
				hover = { enabled = true, delay = 200, reveal = { "close" } },
				sort_by = function(a, b)
					local pa, pb = pinned_buffers[a.bufnr] or false, pinned_buffers[b.bufnr] or false
					if pa and not pb then return true end
					if not pa and pb then return false end
					return a.id < b.id
				end,
			},
		})

		vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter", "ColorScheme" }, {
			callback = function() vim.schedule(update_hl) end,
		})
		update_hl()
		vim.defer_fn(update_hl, 100)

		local map = vim.keymap.set
		map("n", "<Tab>",     "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		map("n", "<S-Tab>",   "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
		map("n", "<A-Tab>",   "<cmd>BufferLineMoveNext<CR>",  { desc = "Move buffer right" })
		map("n", "<A-S-Tab>", "<cmd>BufferLineMovePrev<CR>",  { desc = "Move buffer left" })
		map("n", "<leader>bd", "<cmd>bp|bd #<CR>",            { desc = "Close buffer" })
		map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
		map("n", "<leader>bp", toggle_pin,                    { desc = "Toggle pin" })
	end,
}
