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
		-- BUFFERLINE SETUP (ROTUNJIT ȘI SIMPLU)
		-- ─────────────────────────────────────────────
		require("bufferline").setup({
			highlights = {
				-- Selected: matrix green bg, white text
				buffer_selected = {
					fg = "#ffffff",
					bg = "#63c263",
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
				-- Indicator: green pill on green bg (blends nicely)
				indicator_selected = {
					fg = "#4aaa4a",
					bg = "#63c263",
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
					fg = "#ffffff",
					bg = "#63c263",
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
					fg = "#ffffff",
					bg = "#63c263",
				},
				close_button_visible = {
					fg = "#3a5a3a",
					bg = "#111f11",
				},
				-- Rounded capsule edges: fg = tab bg (draws the curve), bg = fill gutter
				separator = {
					fg = "#0a140a",
					bg = "#060e06",
				},
				separator_selected = {
					fg = "#63c263",
					bg = "#060e06",
				},
				separator_visible = {
					fg = "#111f11",
					bg = "#060e06",
				},
				-- Tabs
				tab = {
					fg = "#4a6a4a",
					bg = "#0a140a",
				},
				tab_selected = {
					fg = "#0a1a0a",
					bg = "#63c263",
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
					fg = "#0a1a0a",
					bg = "#7ec8a0",
					italic = true,
				},
				duplicate_visible = {
					fg = "#3a5a3a",
					bg = "#111f11",
					italic = true,
				},
				-- Diagnostics (matches DiagnosticVirtualText* palette)
				error = { fg = "#c86a5a", bg = "#0a140a" },
				error_selected = { fg = "#7a1a0a", bg = "#7ec8a0", bold = true },
				error_visible = { fg = "#a85a4a", bg = "#111f11" },
				warning = { fg = "#c8a84a", bg = "#0a140a" },
				warning_selected = { fg = "#3a2a00", bg = "#7ec8a0", bold = true },
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

				-- Design rotunjit
				indicator = {
					icon = "●",
					style = "icon",
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
					return pinned .. modified .. name
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

				-- Separator rotunjit (capsulă, la fel ca lualine)
				separator_style = { "", "" },
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
