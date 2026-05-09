return {

	"nvim-lualine/lualine.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons", "tamton-aquib/keys.nvim" },

	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "wombat",
				component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
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
						"mode",
						icons_enabled = true, -- Enables the display of icons alongside the component.
						-- Defines the icon to be displayed in front of the component.
						-- Can be string|table
						-- As table it must contain the icon as first entry and can use
						-- color option to custom color the icon. Example:
						-- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}

						-- icon position can also be set to the right side from table. Example:
						-- {'branch', icon = {'', align='right', color={fg='green'}}}
						icon = nil,

						separator = nil, -- Determines what separator to use for the component.
						-- Note:
						--  When a string is provided it's treated as component_separator.
						--  When a table is provided it's treated as section_separator.
						--  Passing an empty string disables the separator.
						--
						-- These options can be used to set colored separators
						-- around a component.
						--
						-- The options need to be set as such:
						--   separator = { left = '', right = ''}
						--
						-- Where left will be placed on left side of component,
						-- and right will be placed on its right.
						--

						cond = nil, -- Condition function, the component is loaded when the function returns `true`.

						draw_empty = false, -- Whether to draw component even if it's empty.
						-- Might be useful if you want just the separator.

						-- Defines a custom color for the component:
						-- 'highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' } | function
						-- Note:
						--  '|' is synonymous with 'or', meaning a different acceptable format for that placeholder.
						-- color function has to return one of other color types ('highlight_group_name' | { fg = '#rrggbb'|cterm_value(0-255)|'color_name(red)', bg= '#rrggbb', gui='style' })
						-- color functions can be used to have different colors based on state as shown below.
						--
						-- Examples:
						--   color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
						--   color = { fg = 204 }   -- When fg/bg are omitted, they default to the your theme's fg/bg.
						--   color = 'WarningMsg'   -- Highlight groups can also be used.
						--   color = function(section)
						--      return { fg = vim.bo.modified and '#aa3355' or '#33aa88' }
						--   end,
						color = nil, -- The default is your theme's color for that section and mode.

						-- Specify what type a component is, if omitted, lualine will guess it for you.
						--
						-- Available types are:
						--   [format: type_name(example)], mod(branch/filename),
						--   stl(%f/%m), var(g:coc_status/bo:modifiable),
						--   lua_expr(lua expressions), vim_fun(viml function name)
						--
						-- Note:
						-- lua_expr is short for lua-expression and vim_fun is short for vim-function.
						type = nil,

						padding = 1, -- Adds padding to the left and right of components.
						-- Padding can be specified to left or right independently, e.g.:
						--   padding = { left = left_padding, right = right_padding }

						fmt = nil, -- Format function, formats the component's output.
						-- This function receives two arguments:
						-- - string that is going to be displayed and
						--   that can be changed, enhanced and etc.
						-- - context object with information you might
						--   need. E.g. tabnr if used with tabs.
						on_click = nil, -- takes a function that is called when component is clicked with mouse.
						-- the function receives several arguments
						-- - number of clicks in case of multiple clicks
						-- - mouse button used (l(left)/r(right)/m(middle)/...)
						-- - modifiers pressed (s(shift)/c(ctrl)/a(alt)/m(meta)...)
					},
				},

				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
					{
						function()
							local ok, harpoon = pcall(require, "harpoon")
							if not ok then return "" end
							local list = harpoon:list()
							if list:length() == 0 then return "" end
							local current = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
							local parts = {}
							for i = 1, list:length() do
								local item = list:get(i)
								if item then
									local name = vim.fn.fnamemodify(item.value, ":t")
									if item.value == current then
										table.insert(parts, string.format("[%d:%s]", i, name))
									else
										table.insert(parts, string.format("%d:%s", i, name))
									end
								end
							end
							return " " .. table.concat(parts, " | ")
						end,
						color = { fg = "#7aa2f7" },
					},
				},
				lualine_x = {
					{
						require("noice").api.status.message.get_hl,
						cond = require("noice").api.status.message.has,
					},
					{
						require("noice").api.status.command.get,

						cond = require("noice").api.status.command.has,
						color = { fg = "#f5ee2c" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#ff9e64" },
					},

					"encoding",
					"fileformat",
					"filetype",
				},
				-- lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = {
					"location",
					{

						"datetime",
						-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
						style = "%H:%M %y%m%d",

						-- right = "",
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
	end,
}
