-- Maple (dark) — port pentru Neovim al temei VSCode subframe7536/vscode-theme-maple.
-- Culorile vin din themes/maple-dark-color-theme.json; cele cu alfa au fost
-- amestecate peste fundal, fiindcă highlight-urile nvim nu suportă transparență.

vim.cmd.hi("clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd.syntax("reset")
end
vim.o.background = "dark"
vim.g.colors_name = "maple-dark"

local c = {
	bg = "#1e1e1f",
	bg_dark = "#171718",
	bg_alt = "#232a39",
	bg_sel = "#334155",
	bg_hover = "#2d3a4b",
	bg_line = "#282c32",
	bg_visual = "#475569",

	fg = "#cbd5e1",
	fg_dim = "#94a3b8",
	comment = "#999999",
	cursor = "#8d9db4",
	border = "#64748b",

	punct = "#b8d7f9",
	punct_dim = "#99b2cd",
	blue = "#8fc7ff",
	purple = "#d2ccff",
	lilac = "#e3cbeb",
	green = "#a4dfae",
	green_dim = "#7ca583",
	cyan = "#a1e8e5",
	yellow = "#eecfa0",
	orange = "#f0c0a8",
	red = "#edabab",
	lime = "#d5f288",
	prop = "#ded6cf",
	link = "#8dbe74",

	sel_search = "#404e39",
	sel_search_dim = "#343e30",
	indent = "#494c50",
	indent_active = "#a8b0ba",
	scrollbar = "#2e353f",

	git_add = "#97cca0",
	git_change = "#84b6e9",
	git_delete = "#d99d9d",
	diff_add = "#546b58",
	diff_delete = "#715657",
}

-- Cu `vim.g.maple_dark_transparent = true` zonele mari devin transparente, ca să
-- se vadă fundalul terminalului. Popup-urile și floats rămân opace intenționat:
-- peste o imagine de fundal, text pe transparent devine ilizibil.
local transparent = vim.g.maple_dark_transparent == true
local body = transparent and "NONE" or c.bg
local bar = transparent and "NONE" or c.bg_dark

local hl = {
	-- UI
	Normal = { fg = c.fg, bg = body },
	NormalNC = { fg = c.fg, bg = body },
	NormalFloat = { fg = c.fg, bg = c.bg_alt },
	FloatBorder = { fg = c.border, bg = c.bg_alt },
	FloatTitle = { fg = c.blue, bg = c.bg_alt, bold = true },
	Cursor = { fg = c.bg, bg = c.cursor },
	lCursor = { link = "Cursor" },
	TermCursor = { link = "Cursor" },
	CursorLine = { bg = c.bg_line },
	CursorColumn = { bg = c.bg_line },
	ColorColumn = { bg = c.bg_line },
	CursorLineNr = { fg = "#fafafa", bold = true },
	LineNr = { fg = c.indent },
	SignColumn = { bg = body },
	FoldColumn = { fg = c.comment, bg = body },
	Folded = { fg = c.fg_dim, bg = c.bg_alt },
	EndOfBuffer = { fg = c.bg, bg = body },
	NonText = { fg = c.indent },
	Whitespace = { fg = c.indent },
	SpecialKey = { fg = c.indent },
	Conceal = { fg = c.fg_dim },
	Visual = { bg = c.bg_visual },
	VisualNOS = { bg = c.bg_visual },
	Search = { bg = c.sel_search_dim },
	IncSearch = { bg = c.sel_search },
	CurSearch = { bg = c.sel_search },
	MatchParen = { fg = c.lime, bold = true },
	WinSeparator = { fg = c.bg_alt },
	VertSplit = { fg = c.bg_alt },
	Directory = { fg = c.blue },
	Title = { fg = c.purple, bold = true },
	QuickFixLine = { bg = c.bg_sel },
	WildMenu = { bg = c.bg_sel },

	Pmenu = { fg = c.fg, bg = c.bg_alt },
	PmenuSel = { bg = c.bg_sel, bold = true },
	PmenuSbar = { bg = c.bg_alt },
	PmenuThumb = { bg = c.scrollbar },
	PmenuKind = { fg = c.blue, bg = c.bg_alt },
	PmenuExtra = { fg = c.fg_dim, bg = c.bg_alt },

	StatusLine = { fg = c.fg, bg = bar },
	StatusLineNC = { fg = c.fg_dim, bg = bar },
	TabLine = { fg = c.fg_dim, bg = bar },
	TabLineSel = { fg = c.fg, bg = c.bg_alt },
	TabLineFill = { bg = bar },
	WinBar = { fg = c.fg, bg = body },
	WinBarNC = { fg = c.fg_dim, bg = body },

	ErrorMsg = { fg = c.red },
	WarningMsg = { fg = c.yellow },
	MoreMsg = { fg = c.green },
	ModeMsg = { fg = c.fg, bold = true },
	Question = { fg = c.blue },
	MsgArea = { fg = c.fg },

	-- Sintaxă clasică
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.orange },
	String = { fg = c.green },
	Character = { fg = c.green },
	Number = { fg = c.lime },
	Float = { fg = c.lime },
	Boolean = { fg = c.purple },
	Identifier = { fg = c.yellow },
	Function = { fg = c.blue },
	Statement = { fg = c.purple },
	Conditional = { fg = c.purple },
	Repeat = { fg = c.purple },
	Label = { fg = c.purple },
	Operator = { fg = c.punct },
	Keyword = { fg = c.purple },
	Exception = { fg = c.purple },
	PreProc = { fg = c.purple },
	Include = { fg = c.purple },
	Define = { fg = c.purple },
	Macro = { fg = c.purple },
	PreCondit = { fg = c.purple },
	Type = { fg = c.orange },
	StorageClass = { fg = c.purple },
	Structure = { fg = c.orange },
	Typedef = { fg = c.orange },
	Special = { fg = c.cyan },
	SpecialChar = { fg = c.blue },
	Tag = { fg = c.red },
	Delimiter = { fg = c.punct },
	SpecialComment = { fg = c.fg_dim, italic = true },
	Debug = { fg = c.red },
	Underlined = { fg = c.link, underline = true },
	Ignore = { fg = c.comment },
	Error = { fg = c.red },
	Todo = { fg = c.bg, bg = c.yellow, bold = true },

	-- Diff
	DiffAdd = { bg = c.diff_add },
	DiffChange = { bg = c.bg_alt },
	DiffDelete = { bg = c.diff_delete },
	DiffText = { bg = c.bg_sel, bold = true },
	Added = { fg = c.green },
	Changed = { fg = c.yellow },
	Removed = { fg = c.red },

	-- Diagnostice
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.yellow },
	DiagnosticInfo = { fg = c.blue },
	DiagnosticHint = { fg = c.cyan },
	DiagnosticOk = { fg = c.green },
	DiagnosticUnderlineError = { sp = c.red, undercurl = true },
	DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
	DiagnosticUnderlineInfo = { sp = c.blue, undercurl = true },
	DiagnosticUnderlineHint = { sp = c.cyan, undercurl = true },
	DiagnosticVirtualTextError = { fg = c.red, bg = c.bg_line },
	DiagnosticVirtualTextWarn = { fg = c.yellow, bg = c.bg_line },
	DiagnosticVirtualTextInfo = { fg = c.blue, bg = c.bg_line },
	DiagnosticVirtualTextHint = { fg = c.cyan, bg = c.bg_line },

	-- LSP
	LspReferenceText = { bg = c.bg_sel },
	LspReferenceRead = { bg = c.bg_sel },
	LspReferenceWrite = { bg = c.bg_sel, underline = true },
	LspInlayHint = { fg = c.comment, bg = c.bg_line, italic = true },
	LspSignatureActiveParameter = { fg = c.yellow, bold = true },

	-- Treesitter
	["@comment"] = { link = "Comment" },
	["@comment.error"] = { fg = c.red },
	["@comment.warning"] = { fg = c.yellow },
	["@comment.todo"] = { link = "Todo" },
	["@comment.note"] = { fg = c.blue },

	["@variable"] = { fg = c.yellow },
	["@variable.builtin"] = { fg = c.lilac },
	["@variable.parameter"] = { fg = c.yellow, underline = true },
	["@variable.member"] = { fg = c.prop },

	["@constant"] = { fg = c.orange },
	["@constant.builtin"] = { fg = c.purple },
	["@constant.macro"] = { fg = c.purple },

	["@module"] = { fg = c.lilac },
	["@label"] = { fg = c.purple },

	["@string"] = { fg = c.green },
	["@string.documentation"] = { fg = c.green, italic = true },
	["@string.regexp"] = { fg = c.green },
	["@string.escape"] = { fg = c.blue },
	["@string.special"] = { fg = c.cyan },
	["@character"] = { fg = c.green },
	["@character.special"] = { fg = c.blue },

	["@number"] = { fg = c.lime },
	["@number.float"] = { fg = c.lime },
	["@boolean"] = { fg = c.purple },

	["@type"] = { fg = c.orange, bold = true },
	["@type.builtin"] = { fg = c.lime },
	["@type.definition"] = { fg = c.orange },
	["@attribute"] = { fg = c.yellow },
	["@property"] = { fg = c.prop },

	["@function"] = { fg = c.blue },
	["@function.builtin"] = { fg = c.blue },
	["@function.call"] = { fg = c.blue },
	["@function.macro"] = { fg = c.purple },
	["@function.method"] = { fg = c.blue },
	["@function.method.call"] = { fg = c.blue },
	["@constructor"] = { fg = c.orange },

	["@keyword"] = { fg = c.purple },
	["@keyword.function"] = { fg = c.purple },
	["@keyword.operator"] = { fg = c.punct },
	["@keyword.return"] = { fg = c.purple },
	["@keyword.import"] = { fg = c.purple },
	["@keyword.exception"] = { fg = c.purple },
	["@keyword.conditional"] = { fg = c.purple },
	["@keyword.repeat"] = { fg = c.purple },

	["@operator"] = { fg = c.punct },
	["@punctuation.delimiter"] = { fg = c.punct_dim },
	["@punctuation.bracket"] = { fg = c.punct },
	["@punctuation.special"] = { fg = c.cyan },

	["@tag"] = { fg = c.red },
	["@tag.builtin"] = { fg = c.red },
	["@tag.attribute"] = { fg = c.yellow },
	["@tag.delimiter"] = { fg = c.punct },

	["@markup.heading"] = { fg = c.purple, bold = true },
	["@markup.strong"] = { fg = c.orange, bold = true },
	["@markup.italic"] = { fg = c.orange, italic = true },
	["@markup.strikethrough"] = { fg = c.comment, strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.quote"] = { fg = c.cyan },
	["@markup.link"] = { fg = c.link },
	["@markup.link.url"] = { fg = c.link, underline = true },
	["@markup.raw"] = { fg = c.red },
	["@markup.list"] = { fg = c.punct },
	["@markup.list.checked"] = { fg = c.green },
	["@markup.list.unchecked"] = { fg = c.fg_dim },
	["@diff.plus"] = { fg = c.green },
	["@diff.minus"] = { fg = c.red },
	["@diff.delta"] = { fg = c.yellow },

	-- Semantic tokens LSP
	["@lsp.type.parameter"] = { fg = c.yellow, underline = true },
	["@lsp.type.property"] = { fg = c.prop },
	["@lsp.type.interface"] = { fg = c.orange, bold = true, italic = true },
	["@lsp.type.namespace"] = { fg = c.lilac },
	["@lsp.type.type"] = { fg = c.orange, bold = true },
	["@lsp.type.enumMember"] = { fg = c.orange },
	["@lsp.typemod.variable.defaultLibrary"] = { fg = c.lilac },
	["@lsp.typemod.variable.readonly"] = { fg = c.orange },
	["@lsp.typemod.type.defaultLibrary"] = { fg = c.lime },

	-- gitsigns
	GitSignsAdd = { fg = c.git_add },
	GitSignsChange = { fg = c.git_change },
	GitSignsDelete = { fg = c.git_delete },
	GitSignsCurrentLineBlame = { fg = c.comment, italic = true },

	-- indent-blankline
	IblIndent = { fg = c.indent },
	IblScope = { fg = c.indent_active },

	-- fzf-lua / telescope
	TelescopeNormal = { fg = c.fg, bg = c.bg_alt },
	TelescopeBorder = { fg = c.border, bg = c.bg_alt },
	TelescopeTitle = { fg = c.blue, bold = true },
	TelescopeSelection = { bg = c.bg_sel },
	TelescopeMatching = { fg = c.link, bold = true },
	FzfLuaNormal = { fg = c.fg, bg = c.bg_alt },
	FzfLuaBorder = { fg = c.border, bg = c.bg_alt },
	FzfLuaTitle = { fg = c.blue, bold = true },

	-- neo-tree
	NeoTreeNormal = { fg = c.fg, bg = bar },
	NeoTreeNormalNC = { fg = c.fg, bg = bar },
	NeoTreeDirectoryName = { fg = c.blue },
	NeoTreeDirectoryIcon = { fg = c.blue },
	NeoTreeGitModified = { fg = c.git_change },
	NeoTreeGitAdded = { fg = c.git_add },
	NeoTreeGitDeleted = { fg = c.git_delete },
	NeoTreeIndentMarker = { fg = c.indent },

	-- bufferline
	BufferLineFill = { bg = bar },
	BufferLineBackground = { fg = c.fg_dim, bg = bar },
	BufferLineBufferSelected = { fg = c.fg, bg = c.bg_alt, bold = true },

	-- which-key / noice / trouble
	WhichKey = { fg = c.purple },
	WhichKeyGroup = { fg = c.blue },
	WhichKeyDesc = { fg = c.fg },
	WhichKeyFloat = { bg = c.bg_alt },
	NoiceCmdlinePopupBorder = { fg = c.border },
	TroubleNormal = { fg = c.fg, bg = bar },
	TroubleText = { fg = c.fg },
}

for group, spec in pairs(hl) do
	vim.api.nvim_set_hl(0, group, spec)
end

-- Paleta ANSI a temei, ca :terminal / lazygit să arate la fel ca iTerm2.
local ansi = {
	"#333333", "#edabab", "#a4dfae", "#eecfa0", "#8fc7ff", "#d2ccff", "#a1e8e5", "#f3f2f2",
	"#666666", "#ffc4c4", "#bdf8c7", "#ffe8b9", "#a8e0ff", "#ebe5ff", "#bafffe", "#ffffff",
}
for i, color in ipairs(ansi) do
	vim.g["terminal_color_" .. (i - 1)] = color
end
