-- set leader key to space

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

local keymap = vim.keymap -- for conciseness

-- init.lua
---------------------
-- General Keymaps -------------------
-- keymap.set("n", "<leader>rn", ":IncRename ")
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')
keymap.set("x", "p", function()
	if not vim.bo.modifiable then return end
	vim.cmd('normal! p')
	vim.fn.setreg("+", vim.fn.getreg("0"))
	vim.fn.setreg('"', vim.fn.getreg("0"))
end, { desc = "Paste without overwriting yank register" })

keymap.set(
	"t",
	"<C-x>",
	vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
	{ desc = "Escape terminal mode" }
)

keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })


-- keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Move the next Tab" })

-- keymap.set("n", "<Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Move the Prrv Tab" })

-- keymap.set("n", "<Tab>", "<cmd><C-S><CR>", { desc = "Move Tab left/right" })
--keymap.set("n", "<leader>gw", function()
--	vim.cmd("windo diffthis")
--end, { noremap = true, desc = "Git diff (w)indows" })

-- increment/decrement numbers

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

keymap.set("n", "<A-j>", "<Esc>:m+<CR>==", { desc = "Move line up" }) -- decrement
keymap.set("n", "<A-k>", "<Esc>:m-2<CR>==", { desc = "Move line down" }) -- decrement

-- toggle relative numbers
keymap.set("n", "<C-n>", "<cmd> set norelativenumber<CR>", { desc = "Set NoRelativenumber" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" }) -- close current split window
--keymap.set("n", "", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" }) -- close current split window

keymap.set("v", "<", "<gv", { desc = "indent left in visual mode" })
keymap.set("v", ">", ">gv", { desc = "indent right in visual mode" })

keymap.set("n", "<leader>cw", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "[F]ormat [C]urrent file" }) --- format file

keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = " Open Diagnostics in Float" })
keymap.set("n", "mm", "<cmd> Minimap<CR>", { desc = "Minimaps Left" })
