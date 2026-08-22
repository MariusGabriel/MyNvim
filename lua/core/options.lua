-- Transparență globală pentru UI (colorschemă + bufferline + lualine).
-- Setat aici, nu în lua/plugins/color.lua, fiindcă `require("core")` rulează
-- înaintea lui lazy — altfel plugin-urile ar putea citi flag-ul încă nesetat.
-- `false` = fundal opac.
vim.g.ui_transparent = false

vim.cmd("let g:netrw_liststyle = 3")
local opt = vim.opt -- for conciseness

-- Don't show the mode, since it's already in the status line
opt.showmode = true
--test4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_perl_provider = 0

vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
	},
	pattern = {
		["docker%-compose%..*%.ya?ml"] = "yaml.docker-compose",
		[".*/%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
		[".*helm.*values.*%.ya?ml"] = "yaml.helm-values",
	},
})

---vim.loader.enable
vim.loader.enable()

-- line numbers
opt.relativenumber = false -- show relative line numbers

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFD700" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD700", bold = true })
	end,
})

opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 2 -- set width of line number column
opt.sidescrolloff = 8 -- number of columns to keep to the left/right of cursor

opt.fillchars = { eob = " " } -- remove tilda

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Prevent mouse scroll from falling through to terminal scrollback
vim.keymap.set({ "n", "v" }, "<ScrollWheelUp>", "3<C-Y>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<ScrollWheelDown>", "3<C-E>", { noremap = true })
vim.keymap.set("i", "<ScrollWheelUp>", "<C-O>3<C-Y>", { noremap = true })
vim.keymap.set("i", "<ScrollWheelDown>", "<C-O>3<C-E>", { noremap = true })

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.softtabstop = 4 -- number of space inserted for <Tab> key

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.smartindent = true -- enable smart identation
opt.breakindent = true --  enable line breaking indentation
opt.hlsearch = true -- highlight all matches in search

-- Save undo history
opt.undofile = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- (contează la <leader>e, <leader>h, <leader>gg — taste care sunt și prefix
-- pentru altele, deci nvim așteaptă atâta înainte să le declanșeze)
opt.timeoutlen = 300

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
-- opt.termguicolors = true
-- opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
--opt.clipboard:append("unnamedplus") -- use system clipboard as default register
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
