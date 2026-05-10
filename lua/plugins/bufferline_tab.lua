return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- ─────────────────────────────────────────────
		-- SIMPLE CLEAN DESIGN WITH ROUNDED CORNERS
		-- ─────────────────────────────────────────────

		-- ─────────────────────────────────────────────
		-- BUFFER MANAGEMENT SIMPLU
		-- ─────────────────────────────────────────────
		local pinned_buffers = {}

		local function refresh_bufferline()
			vim.cmd("redrawtabline")
		end

		local function toggle_pin()
			local bufnr = vim.api.nvim_get_current_buf()
			if pinned_buffers[bufnr] then
				pinned_buffers[bufnr] = nil
				vim.notify("Buffer unpinned", vim.log.levels.INFO)
			else
				pinned_buffers[bufnr] = true
				vim.notify("Buffer pinned", vim.log.levels.INFO)
			end
			refresh_bufferline()
		end

		-- ─────────────────────────────────────────────
		-- PATCH: înlocuiește triunghiurile slant cu E0B6/E0B4 (identic lualine)
		-- ─────────────────────────────────────────────
		local ok_const, constants = pcall(require, "bufferline.constants")
		if ok_const then
			-- chars[1] = right_sep (marginea dreaptă), chars[2] = left_sep (marginea stângă)
			constants.sep_chars.slant = { "\xee\x82\xb4", "\xee\x82\xb6" }
		end

		-- ─────────────────────────────────────────────
		-- BUFFERLINE SETUP
		-- ─────────────────────────────────────────────
		require("bufferline").setup({
			highlights = {
				buffer_selected = {
					fg = "#0d1a0d",
					bg = "#6bc87a",
					bold = true,
				},
				-- Visible (split focus): lifted bg, sage text
				buffer_visible = {
					fg = "#8ab88a",
					bg = "#111f11",
				},
				-- Inactive: dim on darkest bg
				background = {
					fg = "#4a6a4a",
					bg = "#0a140a",
				},
				indicator_selected = {
					fg = "#6bc87a",
					bg = "#6bc87a",
				},
				indicator_visible = {
					fg = "#2a4a2a",
					bg = "#111f11",
				},
				-- Modified dot: amber warning
				modified = {
					fg = "#c8a84a",
					bg = "#0a140a",
				},
				modified_selected = {
					fg = "#0d1a0d",
					bg = "#6bc87a",
				},
				modified_visible = {
					fg = "#c8a84a",
					bg = "#111f11",
				},
				-- Close buttons
				close_button = {
					fg = "#2a4a2a",
					bg = "#0a140a",
				},
				close_button_selected = {
					fg = "#0d1a0d",
					bg = "#6bc87a",
				},
				close_button_visible = {
					fg = "#3a5a3a",
					bg = "#111f11",
				},
				-- Rounded capsule edges: fg = tab bg (draws the curve), bg = fill gutter
				-- Inactive: invisible (fg = fill bg → no shadow)
				separator = {
					fg = "#060e06",
					bg = "#060e06",
				},
				-- Selected: fg = tab bg → creates rounded capsule edges
				separator_selected = {
					fg = "#6bc87a",
					bg = "#060e06",
				},
				separator_visible = {
					fg = "#060e06",
					bg = "#060e06",
				},
				-- Tabs
				tab = {
					fg = "#4a6a4a",
					bg = "#0a140a",
				},
				tab_selected = {
					fg = "#0d1a0d",
					bg = "#6bc87a",
					bold = true,
				},
				tab_close = {
					fg = "#4a6a4a",
					bg = "#0a140a",
				},
				-- Duplicate prefix: italic + dim (like @comment)
				duplicate = {
					fg = "#2a4a2a",
					bg = "#0a140a",
					italic = true,
				},
				duplicate_selected = {
					fg = "#0d1a0d",
					bg = "#6bc87a",
					italic = true,
				},
				duplicate_visible = {
					fg = "#3a5a3a",
					bg = "#111f11",
					italic = true,
				},
				-- Diagnostics (matches DiagnosticVirtualText* palette)
				error = { fg = "#c86a5a", bg = "#0a140a" },
				error_selected = { fg = "#8b0000", bg = "#6bc87a", bold = true },
				error_visible = { fg = "#a85a4a", bg = "#111f11" },
				warning = { fg = "#c8a84a", bg = "#0a140a" },
				warning_selected = { fg = "#4a3000", bg = "#6bc87a", bold = true },
				warning_visible = { fg = "#a8884a", bg = "#111f11" },
				-- Fill: darkest layer — the empty tabline gutter
				fill = {
					bg = "#060e06",
				},
			},
			options = {
				mode = "buffers",
				numbers = "none",

				-- Close commands
				close_command = function(bufnr)
					if pinned_buffers[bufnr] then
						vim.notify("Unpin first!", vim.log.levels.WARN)
					else
						vim.cmd("bdelete! " .. bufnr)
					end
				end,
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = "bdelete! %d",

				indicator = {
					style = "none",
				},

				-- Icoane simple
				buffer_close_icon = "✕",
				modified_icon = "●",
				close_icon = "✕",
				left_trunc_marker = "◀",
				right_trunc_marker = "▶",

				-- Nume buffer
				name_formatter = function(buf)
					local name = buf.name
					local pinned = pinned_buffers[buf.bufnr] and " " or ""
					local modified = vim.bo[buf.bufnr].modified and "● " or ""
					return " " .. pinned .. modified .. name .. " "
				end,

				max_name_length = 30,
				truncate_names = true,

				-- Fără diagnostice complicate
				diagnostics = false,

				-- Filtrează buffer-ele speciale
				custom_filter = function(bufnr)
					local ft = vim.bo[bufnr].filetype
					local special = { "help", "qf", "TelescopePrompt", "neo-tree", "NvimTree", "Oil" }
					for _, s in ipairs(special) do
						if ft == s then
							return false
						end
					end
					return true
				end,

				-- Offsets (pentru NeoTree)
				offsets = {
					{
						filetype = "neo-tree",
						text = "󰪧 Explorer",
						text_align = "left",
						separator = true,
					},
				},

				-- slant dă ambele margini (stânga + dreapta) pentru tab-ul selectat
				separator_style = "slant",
				always_show_bufferline = true,
				auto_toggle_bufferline = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = true,

				-- Hover
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},

				-- Sortare
				sort_by = function(buffer_a, buffer_b)
					local pinned_a = pinned_buffers[buffer_a.bufnr] or false
					local pinned_b = pinned_buffers[buffer_b.bufnr] or false
					if pinned_a and not pinned_b then
						return true
					end
					if not pinned_a and pinned_b then
						return false
					end
					return buffer_a.id < buffer_b.id
				end,
			},
		})

		-- ─────────────────────────────────────────────
		-- MODE-BASED COLORS
		-- ─────────────────────────────────────────────
		-- Culori identice cu lualine (lua_line.lua)
		local mode_colors = {
			n  = { fg = "#0d1a0d", bg = "#6bc87a" }, -- NORMAL:  verde lualine
			i  = { fg = "#0d1a0d", bg = "#e8c46a" }, -- INSERT:  chihlimbar lualine
			v  = { fg = "#0d1a0d", bg = "#b07fd4" }, -- VISUAL:  violet lualine
			V  = { fg = "#0d1a0d", bg = "#b07fd4" }, -- V-LINE:  violet
			s  = { fg = "#0d1a0d", bg = "#b07fd4" }, -- SELECT:  violet
			R  = { fg = "#0d1a0d", bg = "#c86a5a" }, -- REPLACE: roșu lualine
			c  = { fg = "#0d1a0d", bg = "#7db5c8" }, -- COMMAND: teal lualine
			t  = { fg = "#0d1a0d", bg = "#6bc87a" }, -- TERMINAL: verde (ca normal)
		}
		-- V-BLOCK (Ctrl+V) → cheia e caracterul ASCII 22
		mode_colors["\22"] = mode_colors.v

		local function update_mode_colors()
			local raw = vim.api.nvim_get_mode().mode
			local m = mode_colors[raw] or mode_colors[raw:sub(1, 1)] or mode_colors.n
			local bg_num = tonumber(m.bg:sub(2), 16)

			vim.api.nvim_set_hl(0, "BufferLineBufferSelected",      { fg = m.fg, bg = m.bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected",   { fg = m.bg, bg = m.bg })
			vim.api.nvim_set_hl(0, "BufferLineModifiedSelected",    { fg = "#0d1a0d", bg = m.bg })
			vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = m.fg, bg = m.bg })
			vim.api.nvim_set_hl(0, "BufferLineTabSelected",         { fg = m.fg, bg = m.bg, bold = true })
			vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected",   { fg = m.fg, bg = m.bg, italic = true })
			vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected",   { fg = m.bg, bg = "#060e06" })
			vim.api.nvim_set_hl(0, "BufferLineSeparator",           { fg = "#060e06", bg = "#060e06" })
			vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible",    { fg = "#060e06", bg = "#060e06" })

			-- DevIcon-urile sunt cachate cu bg-ul inițial — actualizare manuală la mod change
			for _, hl_name in ipairs(vim.fn.getcompletion("BufferLineDevIcon", "highlight")) do
				if hl_name:match("Selected$") then
					local orig = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
					if orig and orig.fg then
						vim.api.nvim_set_hl(0, hl_name, { fg = orig.fg, bg = bg_num })
					end
				end
			end
		end

		vim.api.nvim_create_autocmd("ModeChanged", {
			pattern  = "*",
			callback = update_mode_colors,
		})
		update_mode_colors()

		-- ─────────────────────────────────────────────
		-- KEYMAPS SIMPLE
		-- ─────────────────────────────────────────────
		local map = vim.keymap.set

		-- Navigare între buffer-e
		map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

		-- Mută buffer-e
		map("n", "<A-Tab>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
		map("n", "<A-S-Tab>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })

		-- Închide buffer
		map("n", "<leader>bd", "<cmd>bp|bd #<CR>", { desc = "Close buffer" })
		map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

		-- Pin buffer
		map("n", "<leader>bp", toggle_pin, { desc = "Toggle pin" })

		-- Ajutor
		map("n", "<leader>bh", function()
			vim.notify(
				[[
╔════════════════════════════════════════╗
║     BUFFERLINE - SIMPLE & CLEAN        ║
╠════════════════════════════════════════╣
║  <Tab>        - Next buffer            ║
║  <S-Tab>      - Previous buffer        ║
║  <A-Tab>      - Move buffer right      ║
║  <A-S-Tab>    - Move buffer left       ║
║  <leader>bd   - Close buffer           ║
║  <leader>bo   - Close others           ║
║  <leader>bp   - Pin/Unpin buffer       ║
╚════════════════════════════════════════╝
			]],
				vim.log.levels.INFO,
				{ title = "Bufferline Help", timeout = 5000 }
			)
		end, { desc = "Help" })
	end,
}
