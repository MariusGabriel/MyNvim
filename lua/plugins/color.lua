-- return
-- {
-- 	"ATTron/bebop.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("bebop").setup()
-- 		vim.cmd([[colorscheme bebop]])
-- 	end,
-- }
--
-- -- return {
--
-- 	"masisz/wisteria.nvim",
-- 	name = "wisteria",
-- 	opts = {
-- 		transparent = true,
-- 		---@type fun(colors:WisteriaColors):HighlightSpec
-- 		overrides = function(colors)
-- 			return {}
-- 		end,
-- 	},
-- }
--
--  return {
--
--     "vpoltora/cursor-light.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("cursor-light").setup({
--             ui = true, -- Enable UI customizations (statuscolumn, line numbers, etc.)
--             integrations = {
--                 lspsaga = true, -- Enable lspsaga breadcrumbs theming
--                 nvim_tree = true, -- Enable nvim-tree styling
--                 barbar = true, -- Enable barbar tab styling
--             },
--         })
--         vim.cmd.colorscheme("cursor-light")
--     end,
-- }
-- return {
--
-- 	"Mofiqul/vscode.nvim",
--
-- 	config = function()
-- 		--	vim.o.background = "dark"
-- 		-- For light theme
-- 		--vim.o.background = "light"
--
-- 		require("vscode").setup({
-- 			-- Alternatively set style in setup
-- 			style = "dark",
--
-- 			-- Enable transparent background
-- 			transparent = false,
--
-- 			-- Enable italic comment
-- 			italic_comments = true,
--
-- 			-- Underline `@markup.link.*` variants
-- 			underline_links = true,
--
-- 			-- Disable nvim-tree background color
-- 			disable_nvimtree_bg = true,
--
-- 			-- Apply theme colors to terminal
-- 			terminal_colors = true,
--
-- 			-- Override colors (see ./lua/vscode/colors.lua)
-- 			color_overrides = {
-- 				vscLineNumber = "#f2f20a", --#FFFF00",
-- 			},
--
-- 			-- Override highlight groups (see ./lua/vscode/theme.lua)
-- 			-- group_overrides = {
-- 			-- 	-- this supports the same val table as vim.api.nvim_set_hl
-- 			-- -- use colors from this colorscheme by requiring vscode.colors!
-- 			-- 	Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
-- 			-- },
-- 		})
-- 		-- require('vscode').load()
-- 		vim.cmd.colorscheme("vscode")
--
-- 		-- load the theme without affecting devicon colors.
-- 		-- vim.cmd.colorscheme("vscode")
-- 	end,
-- }
--
return {
	"rmehri01/onenord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onenord").setup({
			theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
			borders = false, -- Split window borders
			fade_nc = false, -- Fade non-current windows, making them more distinguishable
			-- Style that is applied to various groups: see `highlight-args` for options
			styles = {
				comments = "italic",
				strings = "NONE",
				keywords = "NONE",
				functions = "NONE",
				variables = "NONE",
				diagnostics = "underline",
			},
			disable = {
				background = false, -- Disable setting the background color
				float_background = false, -- Disable setting the background color for floating windows
				cursorline = false, -- Disabsle the cursorline
				eob_lines = false, -- Hide the end-of-buffer lines
			},
			-- Inverse highlight for different groups
			inverse = {
				match_paren = false,
			},
			custom_highlights = {}, -- Overwrite default highlight groups
			custom_colors = {}, -- Overwrite default colors
		})
	end,
}
-- --
-- return {
--
-- 	"navarasu/onedark.nvim",
--
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		require("onedark").setup({
-- 			-- Main options --
-- 			style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 			transparent = false, -- Show/hide background
-- 			term_colors = true, -- Change terminal color as per the selected theme style
-- 			ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 			cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
-- 			-- toggle theme style ---
-- 			toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
--
-- 			-- Change code style ---
-- 			-- Options are italic, bold, underline, none
-- 			-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
-- 			code_style = {
-- 				comments = "italic",
-- 				keywords = "none",
-- 				functions = "none",
-- 				strings = "none",
-- 				variables = "none",
-- 			},
--
-- 			-- Lualine options --
-- 			lualine = {
-- 				transparent = false, -- lualine center bar transparency
-- 			},
--
-- 			-- Custom Highlights --
-- 			colors = {}, -- Override default colors
-- 			highlights = {}, -- Override highlight groups
--
-- 			-- Plugins Config --
-- 			diagnostics = {
-- 				darker = true, -- darker colors for diagnostic
-- 				undercurl = true, -- use undercurl instead of underline for diagnostics
-- 				background = true, -- use background color for virtual text
-- 			},
-- 		})
-- 		-- Enable theme
-- 		require("onedark").load()
-- 	end,
-- }
--
-- return {
-- 	{
-- 		"catppuccin/nvim",
-- 		name = "catppuccin",
-- 		priority = 1000,
--
-- 		config = function()
-- 			require("catppuccin").setup({
-- 				transparent_background = true,
-- 			})
--
-- 			-- setup must be called before loading
-- 			vim.cmd.colorscheme("catppuccin-macchiato")
-- 		end,
-- 	},
-- }
-- return {
-- 	"lalitmee/cobalt2.nvim",
-- 	event = { "ColorSchemePre" }, -- if you want to lazy load
-- 	dependencies = { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
-- 	init = function()
-- 		require("colorbuddy").colorscheme("cobalt2")
-- 	end,
-- }
