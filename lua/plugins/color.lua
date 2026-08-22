-- return {
-- 	"ATTron/bebop.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("bebop").setup()
-- 		vim.cmd([[colorscheme bebop]])
-- 	end,
-- }

-- return {
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
--
-- -- return {
-- 	"luisiacc/the-matrix.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme("thematrix")
--
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
-- 		vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#d8c9a3" })
-- 		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#4a5a4a" })
--
-- 		vim.o.winblend = 0
-- 		vim.o.pumblend = 0
--
-- 		-- warm override palette: cream text, amber functions, terracotta strings, sage keywords
-- 		local warm = {
-- 			["Normal"] = { fg = "#d8c9a3" },
-- 			["@variable"] = { fg = "#d8c9a3" },
-- 			["@variable.builtin"] = { fg = "#c8a87a" },
-- 			["@string"] = { fg = "#c8956c" },
-- 			["@string.escape"] = { fg = "#e0845a" },
-- 			["@keyword"] = { fg = "#7ec8a0" },
-- 			["@keyword.return"] = { fg = "#e08060" },
-- 			["@keyword.operator"] = { fg = "#a0c090" },
-- 			["@function"] = { fg = "#e8c46a" },
-- 			["@function.call"] = { fg = "#d4aa55" },
-- 			["@function.builtin"] = { fg = "#d4aa55" },
-- 			["@method"] = { fg = "#e8c46a" },
-- 			["@method.call"] = { fg = "#d4aa55" },
-- 			["@type"] = { fg = "#7db5c8" },
-- 			["@type.builtin"] = { fg = "#6a9fb5" },
-- 			["@constant"] = { fg = "#c8a87a" },
-- 			["@constant.builtin"] = { fg = "#c8956c" },
-- 			["@number"] = { fg = "#c8956c" },
-- 			["@boolean"] = { fg = "#c8956c" },
-- 			["@operator"] = { fg = "#a0b890" },
-- 			["@punctuation.bracket"] = { fg = "#8a9880" },
-- 			["@punctuation.delimiter"] = { fg = "#7a8870" },
-- 			["@parameter"] = { fg = "#b8cca8" },
-- 			["@field"] = { fg = "#b0c898" },
-- 			["@property"] = { fg = "#b0c898" },
-- 			["@comment"] = { fg = "#7a9e78", italic = true },
-- 			["Comment"] = { fg = "#7a9e78", italic = true },
-- 			["LineNr"] = { fg = "#4a5a4a" },
-- 			["CursorLineNr"] = { fg = "#8a9a6a" },
-- 			["CursorLine"] = { bg = "none" },
-- 			["Search"] = { bg = "#4a3a20", fg = "#e8c46a" },
-- 			["IncSearch"] = { bg = "#6a4a18", fg = "#fff0c0" },
--
-- 			-- popup menu (cmdline suggestions, blink.cmp)
-- 			["Pmenu"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["PmenuSel"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },
-- 			["PmenuSbar"] = { bg = "NONE" },
-- 			["PmenuThumb"] = { bg = "#3a5a3a" },
-- 			["NormalFloat"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["FloatBorder"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["FloatTitle"] = { bg = "NONE", fg = "#7ec8a0", bold = true },
--
-- 			-- blink.cmp
-- 			["BlinkCmpMenu"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["BlinkCmpMenuBorder"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["BlinkCmpMenuSelection"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },
-- 			["BlinkCmpDoc"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["BlinkCmpDocBorder"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["BlinkCmpDocSeparator"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["BlinkCmpGhostText"] = { fg = "#7aac88", italic = true },
-- 			["BlinkCmpLabel"] = { fg = "#c8c0a8" },
-- 			["BlinkCmpLabelMatch"] = { fg = "#e8c46a", bold = true },
-- 			["BlinkCmpKind"] = { fg = "#7db5c8" },
--
-- 			-- LSP inlay hints and virtual text
-- 			["LspInlayHint"] = { fg = "#7aac88", bg = "#0e1a0e", italic = true },
-- 			["VirtualText"] = { fg = "#7aac88", italic = true },
-- 			["DiagnosticVirtualTextHint"] = { fg = "#6aaa82", italic = true },
-- 			["DiagnosticVirtualTextInfo"] = { fg = "#7db5c8", italic = true },
-- 			["DiagnosticVirtualTextWarn"] = { fg = "#c8a84a", italic = true },
-- 			["DiagnosticVirtualTextError"] = { fg = "#c86a5a", italic = true },
--
-- 			-- noice cmdline popup
-- 			["NoiceCmdlinePopup"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["NoiceCmdlinePopupBorder"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["NoiceCmdlineIcon"] = { fg = "#7ec8a0" },
-- 			["NoicePopupmenu"] = { bg = "NONE", fg = "#d8c9a3" },
-- 			["NoicePopupmenuBorder"] = { bg = "NONE", fg = "#4a6a4a" },
-- 			["NoicePopupmenuSelected"] = { bg = "#1e3020", fg = "#e8c46a", bold = true },
--
-- 			-- nvim-notify: mesaje de commit/info/warn/error
-- 			["NotifyBackground"] = { bg = "#0d1a0d" },
-- 			["NotifyINFOBorder"] = { fg = "#4a9a6a" },
-- 			["NotifyINFOIcon"] = { fg = "#7ec8a0" },
-- 			["NotifyINFOTitle"] = { fg = "#7ec8a0", bold = true },
-- 			["NotifyINFOBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
-- 			["NotifyWARNBorder"] = { fg = "#c8a84a" },
-- 			["NotifyWARNIcon"] = { fg = "#e8c46a" },
-- 			["NotifyWARNTitle"] = { fg = "#e8c46a", bold = true },
-- 			["NotifyWARNBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
-- 			["NotifyERRORBorder"] = { fg = "#a84a4a" },
-- 			["NotifyERRORIcon"] = { fg = "#c86a5a" },
-- 			["NotifyERRORTitle"] = { fg = "#c86a5a", bold = true },
-- 			["NotifyERRORBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
-- 			["NotifyDEBUGBorder"] = { fg = "#4a6a4a" },
-- 			["NotifyDEBUGIcon"] = { fg = "#7a9e78" },
-- 			["NotifyDEBUGTitle"] = { fg = "#7a9e78", bold = true },
-- 			["NotifyDEBUGBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
-- 			["NotifyTRACEBorder"] = { fg = "#5a4a6a" },
-- 			["NotifyTRACEIcon"] = { fg = "#9a7ab8" },
-- 			["NotifyTRACETitle"] = { fg = "#9a7ab8", bold = true },
-- 			["NotifyTRACEBody"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
--
-- 			-- noice mini (mesaje undo/redo/write la bara de jos)
-- 			["NoiceMini"] = { bg = "#0d1a0d", fg = "#d8c9a3" },
-- 			["MsgArea"] = { fg = "#c8c0a0" },
--
-- 			-- gitsigns blame (virtual text "Not Committed yet" si autorul)
-- 			["GitSignsCurrentLineBlame"] = { fg = "#a09060", italic = true },
--
-- 			-- sidekick / Claude terminal
-- 			["SidekickChat"] = { bg = "#0d150d", fg = "#d8c9a3" },
--
-- 			-- noice cmdline popup mai luminos
-- 			["NoiceCmdlinePopup"] = { bg = "NONE", fg = "#e0d4b0" },
-- 			["NoiceCmdlinePopupBorder"] = { bg = "NONE", fg = "#7ab87a" },
-- 			["NoiceCmdlinePopupTitle"] = { bg = "NONE", fg = "#b8e0a0", bold = true },
-- 			["NoiceCmdlineIcon"] = { fg = "#a0e890" },
-- 			["NoiceCmdlineIconSearch"] = { fg = "#e8c46a" },
-- 		}
--
-- 		for group, hl in pairs(warm) do
-- 			vim.api.nvim_set_hl(0, group, hl)
-- 		end
--
-- 		for _, group in ipairs({
-- 			"@lsp.typemod.function.defaultLibrary",
-- 			"@lsp.typemod.method.defaultLibrary",
-- 			"@lsp.typemod.function.defaultLibrary.lua",
-- 			"@lsp.typemod.method.defaultLibrary.lua",
-- 		}) do
-- 			vim.api.nvim_set_hl(0, group, { link = "@function.call" })
-- 		end
-- 	end,
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
-- --
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
-- 	"Mofiqul/vscode.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("vscode").setup({
-- 			style = "dark",
-- 			italic_comments = true,
-- 			disable_nvimtree_bg = true,
-- 			terminal_colors = true,
-- 		})
-- 		vim.cmd.colorscheme("vscode")
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
-- Matrix Soft — muted green, easy on the eyes (matches iTerm2 + yazi flavor)
local _matrix = {
	"luisiacc/the-matrix.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		vim.cmd.colorscheme("thematrix")

		-- Matrix Soft palette
		local c = {
			bg       = "#0b0f0b",
			bg_alt   = "#16221a",
			bg_sel   = "#243528",
			overlay  = "#5e705e",
			subtext  = "#7e907e",
			text     = "#a8c8a8",
			green    = "#6fcf6f",
			bright   = "#87d787",
			teal     = "#5fafaf",
			yellow   = "#bfcf87",
			red      = "#d78787",
			mint     = "#9fd79f",
		}

		local hl = {
			-- Editor UI (transparent: terminal bg shows through)
			Normal       = { fg = c.text, bg = "NONE" },
			NormalNC     = { fg = c.text, bg = "NONE" },
			NormalFloat  = { fg = c.text, bg = c.bg_alt },
			FloatBorder  = { fg = c.overlay, bg = c.bg_alt },
			FloatTitle   = { fg = c.bright, bg = c.bg_alt, bold = true },
			EndOfBuffer  = { fg = c.bg },
			CursorLine   = { bg = c.bg_alt },
			CursorLineNr = { fg = c.bright, bold = true },
			LineNr       = { fg = c.overlay },
			SignColumn   = { bg = "NONE" },
			ColorColumn  = { bg = c.bg_alt },
			Visual       = { bg = c.bg_sel },
			Search       = { fg = c.bg, bg = c.yellow },
			IncSearch    = { fg = c.bg, bg = c.bright },
			CurSearch    = { fg = c.bg, bg = c.bright },
			MatchParen   = { fg = c.bright, bold = true },
			WinSeparator = { fg = c.overlay },
			VertSplit    = { fg = c.overlay },
			Folded       = { fg = c.subtext, bg = c.bg_alt },
			Pmenu        = { fg = c.text, bg = c.bg_alt },
			PmenuSel     = { fg = c.bright, bg = c.bg_sel, bold = true },
			PmenuSbar    = { bg = c.bg_alt },
			PmenuThumb   = { bg = c.overlay },
			StatusLine   = { fg = c.text, bg = c.bg_alt },
			StatusLineNC = { fg = c.overlay, bg = c.bg },
			TabLine      = { fg = c.green, bg = c.bg_alt },
			TabLineSel   = { fg = c.bg, bg = c.green, bold = true },
			TabLineFill  = { bg = c.bg },

			-- Syntax (classic groups)
			Comment      = { fg = c.overlay, italic = true },
			Constant     = { fg = c.mint },
			String       = { fg = c.yellow },
			Character    = { fg = c.yellow },
			Number       = { fg = c.mint },
			Boolean      = { fg = c.mint },
			Float        = { fg = c.mint },
			Identifier   = { fg = c.text },
			Function     = { fg = c.bright },
			Statement    = { fg = c.green },
			Keyword      = { fg = c.green },
			Conditional  = { fg = c.green },
			Repeat       = { fg = c.green },
			Operator     = { fg = c.subtext },
			Label        = { fg = c.teal },
			Exception    = { fg = c.red },
			PreProc      = { fg = c.teal },
			Type         = { fg = c.teal },
			Special      = { fg = c.mint },
			Delimiter    = { fg = c.subtext },
			Todo         = { fg = c.bg, bg = c.yellow, bold = true },
			Error        = { fg = c.red, bold = true },

			-- Treesitter
			["@variable"]          = { fg = c.text },
			["@variable.builtin"]  = { fg = c.mint },
			["@field"]             = { fg = c.text },
			["@property"]          = { fg = c.text },
			["@parameter"]         = { fg = c.text },
			["@keyword"]           = { fg = c.green },
			["@keyword.return"]    = { fg = c.red },
			["@keyword.operator"]  = { fg = c.green },
			["@function"]          = { fg = c.bright },
			["@function.call"]     = { fg = c.bright },
			["@function.builtin"]  = { fg = c.teal },
			["@method"]            = { fg = c.bright },
			["@method.call"]       = { fg = c.bright },
			["@type"]              = { fg = c.teal },
			["@type.builtin"]      = { fg = c.teal },
			["@constant"]          = { fg = c.mint },
			["@constant.builtin"]  = { fg = c.mint },
			["@string"]            = { fg = c.yellow },
			["@string.escape"]     = { fg = c.bright },
			["@number"]            = { fg = c.mint },
			["@boolean"]           = { fg = c.mint },
			["@operator"]          = { fg = c.subtext },
			["@punctuation.bracket"]    = { fg = c.subtext },
			["@punctuation.delimiter"]  = { fg = c.subtext },
			["@comment"]           = { fg = c.overlay, italic = true },
			["@tag"]               = { fg = c.green },
			["@tag.attribute"]     = { fg = c.teal },

			-- Diagnostics
			DiagnosticError = { fg = c.red },
			DiagnosticWarn  = { fg = c.yellow },
			DiagnosticInfo  = { fg = c.teal },
			DiagnosticHint  = { fg = c.green },
			DiagnosticVirtualTextError = { fg = c.red, italic = true },
			DiagnosticVirtualTextWarn  = { fg = c.yellow, italic = true },
			DiagnosticVirtualTextInfo  = { fg = c.teal, italic = true },
			DiagnosticVirtualTextHint  = { fg = c.green, italic = true },

			-- Diff / Git
			DiffAdd    = { fg = c.green, bg = c.bg_alt },
			DiffChange = { fg = c.yellow, bg = c.bg_alt },
			DiffDelete = { fg = c.red, bg = c.bg_alt },
			DiffText   = { fg = c.bright, bg = c.bg_sel },
			GitSignsAdd    = { fg = c.green },
			GitSignsChange = { fg = c.yellow },
			GitSignsDelete = { fg = c.red },
			GitSignsCurrentLineBlame = { fg = c.overlay, italic = true },
		}

		for group, spec in pairs(hl) do
			vim.api.nvim_set_hl(0, group, spec)
		end

		-- Terminal colors (:terminal, lazygit, Claude panel etc.)
		-- Balanced palette: each ANSI color stays recognizable, just muted —
		-- so Claude Code diffs/markdown render correctly (not all-green).
		vim.g.terminal_color_0  = "#1a211a" -- black
		vim.g.terminal_color_8  = "#5e705e" -- bright black
		vim.g.terminal_color_1  = "#e08f8f" -- red
		vim.g.terminal_color_9  = "#f0a0a0" -- bright red
		vim.g.terminal_color_2  = "#6fcf6f" -- green
		vim.g.terminal_color_10 = "#87d787" -- bright green
		vim.g.terminal_color_3  = "#d6b86f" -- yellow / amber
		vim.g.terminal_color_11 = "#e8cf8a" -- bright yellow
		vim.g.terminal_color_4  = "#7fa8d6" -- blue
		vim.g.terminal_color_12 = "#9fc0e0" -- bright blue
		vim.g.terminal_color_5  = "#b58bd6" -- magenta / lavender
		vim.g.terminal_color_13 = "#c9a8e0" -- bright magenta
		vim.g.terminal_color_6  = "#5fbcd3" -- cyan
		vim.g.terminal_color_14 = "#87d0e0" -- bright cyan
		vim.g.terminal_color_7  = "#a8c8a8" -- white
		vim.g.terminal_color_15 = "#d7ffd7" -- bright white
	end,
}
local _ = _matrix

local _south = {
	"arnauKL/south.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.termguicolors = true
		require("south").setup({
			transparent = false,
			darker_floats = false,
			styles = {
				italics = true,
				italic_comments = true,
				italic_linenums = false,
				bold_keywords = false,
			},
		})
		vim.cmd.colorscheme("south")

		-- south maps terminal_color_0 to near-white and 7 to black, which makes
		-- ANSI-black text invisible in :terminal / lazygit / the Claude panel.
		-- Restore the conventional light-theme order (same as the iTerm preset).
		vim.g.terminal_color_0  = "#323b45" -- black
		vim.g.terminal_color_8  = "#9097a6" -- bright black
		vim.g.terminal_color_1  = "#c1293d" -- red
		vim.g.terminal_color_9  = "#c1293d"
		vim.g.terminal_color_2  = "#2b9728" -- green
		vim.g.terminal_color_10 = "#2b9728"
		vim.g.terminal_color_3  = "#d99610" -- yellow
		vim.g.terminal_color_11 = "#f29130" -- orange
		vim.g.terminal_color_4  = "#0850B5" -- blue
		vim.g.terminal_color_12 = "#257fc4"
		vim.g.terminal_color_5  = "#615FB9" -- magenta
		vim.g.terminal_color_13 = "#615FB9"
		vim.g.terminal_color_6  = "#008165" -- cyan
		vim.g.terminal_color_14 = "#0092bf"
		vim.g.terminal_color_7  = "#b5bac4" -- white
		vim.g.terminal_color_15 = "#e4eaf3"
	end,
}
local _ = _south

-- Maple (dark). Colorschema locală: colors/maple-dark.lua. `dir` o expune lazy-ului
-- doar ca să obținem un config hook cu priority 1000, nu ca plugin instalabil.
local _maple = {
	dir = vim.fn.stdpath("config"),
	name = "maple-dark",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.termguicolors = true
		vim.cmd.colorscheme("maple-dark")
	end,
}
local _ = _maple

-- Comutatorul de transparență: vim.g.ui_transparent, în lua/core/options.lua
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.termguicolors = true
		require("catppuccin").setup({
			flavour = "frappe",
			transparent_background = vim.g.ui_transparent == true,
			term_colors = true,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
			integrations = {
				gitsigns = true,
				harpoon = true,
				indent_blankline = { enabled = true },
				mason = true,
				native_lsp = { enabled = true },
				neotree = true,
				noice = true,
				notify = true,
				treesitter = true,
				which_key = true,
				lsp_trouble = true,
				fzf = true,
				dap = true,
				dap_ui = true,
				-- bufferline lipsește intenționat: bufferline_tab.lua își setează
				-- singur highlight-urile, în funcție de modul curent.
			},
			-- transparent_background golește și popup-urile. Peste imaginea de
			-- fundal a terminalului devin ilizibile, deci le ținem opace.
			custom_highlights = function(cp)
				return {
					Pmenu = { bg = cp.mantle },
					PmenuSel = { bg = cp.surface1, bold = true },
					PmenuSbar = { bg = cp.mantle },
					PmenuThumb = { bg = cp.surface2 },
					PmenuKind = { fg = cp.blue, bg = cp.mantle },
					PmenuExtra = { fg = cp.subtext0, bg = cp.mantle },
					NormalFloat = { bg = cp.mantle },
					FloatBorder = { fg = cp.overlay0, bg = cp.mantle },
					WhichKeyFloat = { bg = cp.mantle },
					TelescopeNormal = { bg = cp.mantle },
					TelescopeBorder = { fg = cp.overlay0, bg = cp.mantle },
					FzfLuaNormal = { bg = cp.mantle },
					FzfLuaBorder = { fg = cp.overlay0, bg = cp.mantle },
					NoiceCmdlinePopup = { bg = cp.mantle },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin-frappe")
	end,
}
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
--
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
