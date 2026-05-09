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
-- return {
--
-- 	"vpoltora/cursor-light.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("cursor-light").setup({
-- 			ui = true, -- Enable UI customizations (statuscolumn, line numbers, etc.)
-- 			integrations = {
-- 				lspsaga = true, -- Enable lspsaga breadcrumbs theming
-- 				nvim_tree = true, -- Enable nvim-tree styling
-- 				barbar = true, -- Enable barbar tab styling
-- 			},
-- 		})
-- 		vim.cmd.colorscheme("cursor-light")
-- 	end,
-- }

return {
	"luisiacc/the-matrix.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("thematrix")

		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#d8c9a3" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#4a5a4a" })

		vim.o.winblend = 0
		vim.o.pumblend = 0

		-- warm override palette: cream text, amber functions, terracotta strings, sage keywords
		local warm = {
			["Normal"] = { fg = "#d8c9a3" },
			["@variable"] = { fg = "#d8c9a3" },
			["@variable.builtin"] = { fg = "#c8a87a" },
			["@string"] = { fg = "#c8956c" },
			["@string.escape"] = { fg = "#e0845a" },
			["@keyword"] = { fg = "#7ec8a0" },
			["@keyword.return"] = { fg = "#e08060" },
			["@keyword.operator"] = { fg = "#a0c090" },
			["@function"] = { fg = "#e8c46a" },
			["@function.call"] = { fg = "#d4aa55" },
			["@function.builtin"] = { fg = "#d4aa55" },
			["@method"] = { fg = "#e8c46a" },
			["@method.call"] = { fg = "#d4aa55" },
			["@type"] = { fg = "#7db5c8" },
			["@type.builtin"] = { fg = "#6a9fb5" },
			["@constant"] = { fg = "#c8a87a" },
			["@constant.builtin"] = { fg = "#c8956c" },
			["@number"] = { fg = "#c8956c" },
			["@boolean"] = { fg = "#c8956c" },
			["@operator"] = { fg = "#a0b890" },
			["@punctuation.bracket"] = { fg = "#8a9880" },
			["@punctuation.delimiter"] = { fg = "#7a8870" },
			["@parameter"] = { fg = "#b8cca8" },
			["@field"] = { fg = "#b0c898" },
			["@property"] = { fg = "#b0c898" },
			["@comment"] = { fg = "#7a9e78", italic = true },
			["Comment"] = { fg = "#7a9e78", italic = true },
			["LineNr"] = { fg = "#4a5a4a" },
			["CursorLineNr"] = { fg = "#8a9a6a" },
			["CursorLine"] = { bg = "none" },
			["Search"] = { bg = "#4a3a20", fg = "#e8c46a" },
			["IncSearch"] = { bg = "#6a4a18", fg = "#fff0c0" },

			-- popup menu (cmdline suggestions, blink.cmp)
			["Pmenu"] = { bg = "NONE", fg = "#d8c9a3" },
			["PmenuSel"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },
			["PmenuSbar"] = { bg = "NONE" },
			["PmenuThumb"] = { bg = "#3a5a3a" },
			["NormalFloat"] = { bg = "NONE", fg = "#d8c9a3" },
			["FloatBorder"] = { bg = "NONE", fg = "#4a6a4a" },
			["FloatTitle"] = { bg = "NONE", fg = "#7ec8a0", bold = true },

			-- blink.cmp
			["BlinkCmpMenu"] = { bg = "NONE", fg = "#d8c9a3" },
			["BlinkCmpMenuBorder"] = { bg = "NONE", fg = "#4a6a4a" },
			["BlinkCmpMenuSelection"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },
			["BlinkCmpDoc"] = { bg = "NONE", fg = "#d8c9a3" },
			["BlinkCmpDocBorder"] = { bg = "NONE", fg = "#4a6a4a" },
			["BlinkCmpDocSeparator"] = { bg = "NONE", fg = "#4a6a4a" },
			["BlinkCmpGhostText"] = { fg = "#7aac88", italic = true },
			["BlinkCmpLabel"] = { fg = "#c8c0a8" },
			["BlinkCmpLabelMatch"] = { fg = "#e8c46a", bold = true },
			["BlinkCmpKind"] = { fg = "#7db5c8" },

			-- LSP inlay hints and virtual text
			["LspInlayHint"] = { fg = "#7aac88", bg = "#0e1a0e", italic = true },
			["VirtualText"] = { fg = "#7aac88", italic = true },
			["DiagnosticVirtualTextHint"] = { fg = "#6aaa82", italic = true },
			["DiagnosticVirtualTextInfo"] = { fg = "#7db5c8", italic = true },
			["DiagnosticVirtualTextWarn"] = { fg = "#c8a84a", italic = true },
			["DiagnosticVirtualTextError"] = { fg = "#c86a5a", italic = true },

			-- noice cmdline popup
			["NoiceCmdlinePopup"] = { bg = "NONE", fg = "#d8c9a3" },
			["NoiceCmdlinePopupBorder"] = { bg = "NONE", fg = "#4a6a4a" },
			["NoiceCmdlineIcon"] = { fg = "#7ec8a0" },
			["NoicePopupmenu"] = { bg = "NONE", fg = "#d8c9a3" },
			["NoicePopupmenuBorder"] = { bg = "NONE", fg = "#4a6a4a" },
			["NoicePopupmenuSelected"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },

			-- nvim-notify: mesaje de commit/info/warn/error
			["NotifyBackground"] = { bg = "#0d1a0d" },
			["NotifyINFOBorder"] = { fg = "#4a9a6a" },
			["NotifyINFOIcon"] = { fg = "#7ec8a0" },
			["NotifyINFOTitle"] = { fg = "#7ec8a0", bold = true },
			["NotifyINFOBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
			["NotifyWARNBorder"] = { fg = "#c8a84a" },
			["NotifyWARNIcon"] = { fg = "#e8c46a" },
			["NotifyWARNTitle"] = { fg = "#e8c46a", bold = true },
			["NotifyWARNBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
			["NotifyERRORBorder"] = { fg = "#a84a4a" },
			["NotifyERRORIcon"] = { fg = "#c86a5a" },
			["NotifyERRORTitle"] = { fg = "#c86a5a", bold = true },
			["NotifyERRORBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
			["NotifyDEBUGBorder"] = { fg = "#4a6a4a" },
			["NotifyDEBUGIcon"] = { fg = "#7a9e78" },
			["NotifyDEBUGTitle"] = { fg = "#7a9e78", bold = true },
			["NotifyDEBUGBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
			["NotifyTRACEBorder"] = { fg = "#5a4a6a" },
			["NotifyTRACEIcon"] = { fg = "#9a7ab8" },
			["NotifyTRACETitle"] = { fg = "#9a7ab8", bold = true },
			["NotifyTRACEBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },

			-- noice mini (mesaje undo/redo/write la bara de jos)
			["NoiceMini"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
			["MsgArea"] = { fg = "#c8c0a0" },

			-- gitsigns blame (virtual text "Not Committed yet" si autorul)
			["GitSignsCurrentLineBlame"] = { fg = "#a09060", italic = true },

			-- noice cmdline popup mai luminos
			["NoiceCmdlinePopup"] = { bg = "NONE", fg = "#e0d4b0" },
			["NoiceCmdlinePopupBorder"] = { bg = "NONE", fg = "#7ab87a" },
			["NoiceCmdlinePopupTitle"] = { bg = "NONE", fg = "#b8e0a0", bold = true },
			["NoiceCmdlineIcon"] = { fg = "#a0e890" },
			["NoiceCmdlineIconSearch"] = { fg = "#e8c46a" },
		}

		for group, hl in pairs(warm) do
			vim.api.nvim_set_hl(0, group, hl)
		end

		for _, group in ipairs({
			"@lsp.typemod.function.defaultLibrary",
			"@lsp.typemod.method.defaultLibrary",
			"@lsp.typemod.function.defaultLibrary.lua",
			"@lsp.typemod.method.defaultLibrary.lua",
		}) do
			vim.api.nvim_set_hl(0, group, { link = "@function.call" })
		end
	end,
}
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
-- return {
-- 	"rmehri01/onenord.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("onenord").setup({
-- 			theme = "dark", -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
-- 			borders = false, -- Split window borders
-- 			fade_nc = false, -- Fade non-current windows, making them more distinguishable
-- 			-- Style that is applied to various groups: see `highlight-args` for options
-- 			styles = {
-- 				comments = "italic",
-- 				strings = "NONE",
-- 				keywords = "NONE",
-- 				functions = "NONE",
-- 				variables = "NONE",
-- 				diagnostics = "underline",
-- 			},
-- 			disable = {
-- 				background = true, -- Disable setting the background color
-- 				float_background = false, -- Disable setting the background color for floating windows
-- 				cursorline = false, -- Disabsle the cursorline
-- 				eob_lines = false, -- Hide the end-of-buffer lines
-- 			},
-- 			-- Inverse highlight for different groups
-- 			inverse = {
-- 				match_paren = false,
-- 			},
-- 			custom_highlights = {}, -- Overwrite default highlight groups
-- 			custom_colors = {}, -- Overwrite default colors
-- 		})
-- 	end,
-- }
--
-- return {
-- 	"tanvirtin/monokai.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("monokai").setup({ palette = require("monokai").soda })
-- 		vim.cmd("colorscheme monokai_soda")
-- 	end,
-- }

-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("tokyonight").setup({
-- 			style = "day",
-- 		})
-- 		vim.cmd("colorscheme tokyonight-moon")
-- 	end,
-- }

-- return {
-- 	"rafi/awesome-vim-colorschemes",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }

-- return {
-- 	"sainnhe/sonokai",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.sonokai_style = "maia"
-- 		vim.g.sonokai_better_performance = 1
-- 		vim.g.sonokai_transparent_background = 2
-- 		vim.cmd("colorscheme sonokai")
-- 	end,
-- }
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
