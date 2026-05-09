return {

	"nvim-lualine/lualine.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local warm_matrix = {
			normal = {
				a = { fg = "#0d1a0d", bg = "#6bc87a", gui = "bold" },
				b = { fg = "#b8cca8", bg = "NONE" },
				c = { fg = "#d8c9a3", bg = "NONE" },
			},
			insert = {
				a = { fg = "#0d1a0d", bg = "#e8c46a", gui = "bold" },
				b = { fg = "#b8cca8", bg = "NONE" },
				c = { fg = "#d8c9a3", bg = "NONE" },
			},
			visual = {
				a = { fg = "#0d1a0d", bg = "#b07fd4", gui = "bold" },
				b = { fg = "#b8cca8", bg = "NONE" },
				c = { fg = "#d8c9a3", bg = "NONE" },
			},
			replace = {
				a = { fg = "#0d1a0d", bg = "#c86a5a", gui = "bold" },
				b = { fg = "#b8cca8", bg = "NONE" },
				c = { fg = "#d8c9a3", bg = "NONE" },
			},
			command = {
				a = { fg = "#0d1a0d", bg = "#7db5c8", gui = "bold" },
				b = { fg = "#b8cca8", bg = "NONE" },
				c = { fg = "#d8c9a3", bg = "NONE" },
			},
			inactive = {
				a = { fg = "#4a5a4a", bg = "NONE" },
				b = { fg = "#4a5a4a", bg = "NONE" },
				c = { fg = "#4a5a4a", bg = "NONE" },
			},
		}

		local function get_mode_color()
			local mode_colors = {
				n = "#6bc87a",
				i = "#e8c46a",
				v = "#b07fd4",
				V = "#b07fd4",
				["\22"] = "#b07fd4",
				R = "#c86a5a",
				c = "#7db5c8",
			}
			return mode_colors[vim.fn.mode()] or "#6bc87a"
		end

		local function get_right_color()
			local right_colors = {
				n = "#6bc87a",
				i = "#e8c46a",
				v = "#b07fd4",
				V = "#b07fd4",
				["\22"] = "#b07fd4",
				R = "#c86a5a",
				c = "#7db5c8",
			}
			return right_colors[vim.fn.mode()] or "#6bc87a"
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = warm_matrix,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "│", right = "│" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					winbar = 1000,
				},
			},

			sections = {
				lualine_a = {
					{
						function()
							return "╰"
						end,
						color = { fg = "#4a5a4a", bg = "NONE" },
						padding = 0,
						separator = { left = "", right = "" },
					},
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_mode_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
					{
						"mode",
						color = function()
							return { fg = "#0d1a0d", bg = get_mode_color(), gui = "bold" }
						end,
						padding = { left = 1, right = 1 },
						separator = { left = "", right = "" },
					},
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_mode_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
				},

				lualine_b = {
					{
						function()
							return "│"
						end,
						color = { fg = "#6bc87a" },
						padding = { left = 1, right = 1 },
						separator = { left = "", right = "" },
					},
					"branch",
					"diff",
					"diagnostics",
				},
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
						color = { fg = "#b8cca8" },
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
						color = { fg = "#e8c46a" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#c8956c" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#c8956c" },
					},

					"encoding",
					"fileformat",
					"filetype",
				},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = {
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_right_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
					{
						"progress",
						color = function()
							return { fg = "#0d1a0d", bg = get_right_color(), gui = "bold" }
						end,
						padding = { left = 1, right = 1 },
						separator = { left = "", right = "" },
					},
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_right_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
				},
				lualine_z = {
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_right_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
					{
						"location",
						color = function()
							return { fg = "#0d1a0d", bg = get_right_color(), gui = "bold" }
						end,
						padding = { left = 1, right = 1 },
						separator = { left = "", right = "" },
					},
					{
						function()
							return ""
						end,
						color = function()
							return { fg = get_right_color(), bg = "NONE" }
						end,
						padding = 0,
						separator = { left = "", right = "" },
					},
					{
						function()
							return "╯"
						end,
						color = { fg = "#4a5a4a", bg = "NONE" },
						padding = 0,
						separator = { left = "", right = "" },
					},
				},
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

		-- Invalidate harpoon lualine cache on buffer entry so position updates
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function(ev)
				vim.b[ev.buf]._harpoon_lualine = nil
			end,
		})
	end,
}
