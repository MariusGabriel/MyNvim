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
				buffer_selected = {
					fg = "#E5E9F0", -- alb
					bg = "#D08F70", -- portocaliu
					bold = true,
				},
				buffer_visible = {
					fg = "#6C7A96",
					bg = "#3B4252", -- gri pentru cei vizibili
				},
				background = {
					fg = "#646A76",
					bg = "#2E3440", -- bg onenord
				},
				indicator_selected = {
					fg = "#D08F70",
					bg = "#D08F70",
				},
				modified = {
					fg = "#EBCB8B",
					bg = "#2E3440",
				},
				modified_selected = {
					fg = "#E5E9F0", -- alb
					bg = "#D08F70",
				},
				close_button = {
					fg = "#646A76",
					bg = "#2E3440",
				},
				close_button_selected = {
					fg = "#E5E9F0", -- alb
					bg = "#D08F70",
				},

				separator = {
					fg = "#2E3440",
					bg = "#2E3440",
				},
				separator_selected = {
					fg = "#2E3440",
					bg = "#D08F70",
				},
				separator_visible = {
					fg = "#2E3440",
					bg = "#2E3440",
				},
				tab_selected = {
					fg = "#2E3440",
					bg = "#D08F70",
				},
				fill = {
					bg = "#2E3440",
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
					local pinned = pinned_buffers[buf.bufnr] and "📌 " or ""
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

				-- Separator rotunjit
				separator_style = "padded_slant",

				-- separator_style = "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
				-- separator_style = "",
				-- separator_style = "any", -- Setări generale
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
