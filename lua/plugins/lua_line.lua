return {

	"nvim-lualine/lualine.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- Maple Dark palette (identică cu colors/maple-dark.lua)
		-- Culorile de mod sunt pastelate, deci textul de deasupra e închis, nu alb.
		local transparent = vim.g.maple_dark_transparent == true
		local od = {
			bg      = "#1e1e1f", -- text pe culoarea de mod
			bg_dark = transparent and "NONE" or "#171718", -- inactive
			bg_mid  = "#232a39", -- surface / secțiunea b, rămâne opacă pentru contrast
			bg_c    = transparent and "NONE" or "#1e1e1f", -- secțiunea c
			fg      = "#cbd5e1",
			fg_dim  = "#94a3b8",
			green   = "#a4dfae", -- normal
			cyan    = "#8fc7ff", -- insert
			lavender= "#d2ccff", -- visual
			red     = "#edabab", -- replace
			amber   = "#eecfa0", -- command
		}

		local maple_theme = {
			normal = {
				a = { fg = od.bg, bg = od.green,    gui = "bold" },
				b = { fg = od.fg, bg = od.bg_mid },
				c = { fg = od.fg, bg = od.bg_c },
			},
			insert = {
				a = { fg = od.bg, bg = od.cyan,     gui = "bold" },
				b = { fg = od.fg, bg = od.bg_mid },
				c = { fg = od.fg, bg = od.bg_c },
			},
			visual = {
				a = { fg = od.bg, bg = od.lavender, gui = "bold" },
				b = { fg = od.fg, bg = od.bg_mid },
				c = { fg = od.fg, bg = od.bg_c },
			},
			replace = {
				a = { fg = od.bg, bg = od.red,      gui = "bold" },
				b = { fg = od.fg, bg = od.bg_mid },
				c = { fg = od.fg, bg = od.bg_c },
			},
			command = {
				a = { fg = od.bg, bg = od.amber,    gui = "bold" },
				b = { fg = od.fg, bg = od.bg_mid },
				c = { fg = od.fg, bg = od.bg_c },
			},
			inactive = {
				a = { fg = od.fg_dim, bg = od.bg_dark },
				b = { fg = od.fg_dim, bg = od.bg_dark },
				c = { fg = od.fg_dim, bg = od.bg_dark },
			},
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = maple_theme,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {}, winbar = {} },
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = { statusline = 1000, winbar = 1000 },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
					{
						function()
							local ok, harpoon = pcall(require, "harpoon")
							if not ok then return "" end
							local list = harpoon:list()
							local len = list:length()
							if len == 0 then return "" end

							local bufnr = vim.api.nvim_get_current_buf()
							local cache = vim.b[bufnr]._harpoon_lualine
							if cache then return cache end

							local current = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(bufnr)) or ""
							local parts = {}
							for i = 1, len do
								local item = list:get(i)
								if item then
									local full = vim.loop.fs_realpath(item.value) or item.value
									local name = item.value:match("([^/]+)$") or item.value
									if full == current then
										table.insert(parts, ("[%d:%s]"):format(i, name))
									else
										table.insert(parts, ("%d:%s"):format(i, name))
									end
								end
							end
							local result = #parts > 0 and (" " .. table.concat(parts, " | ")) or ""
							vim.b[bufnr]._harpoon_lualine = result
							return result
						end,
						color = { fg = "#a1e8e5" },
					},
				},
				lualine_x = {
					{
						require("noice").api.status.message.get_hl,
						cond = require("noice").api.status.message.has,
					},
					{
						function()
							return require("screenkey").get_keys()
						end,
						cond = function()
							return vim.g.screenkey_statusline_component == true
						end,
						color = { fg = "#a1e8e5" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#eecfa0" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#eecfa0" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function(ev)
				vim.b[ev.buf]._harpoon_lualine = nil
			end,
		})
	end,
}
