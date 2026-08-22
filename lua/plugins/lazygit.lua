-- kdheepak/lazygit.nvim a fost scos.
--
-- Cauza: lazygit.lua:64-66 apelează `jobstart(cmd, { term = true })` dintr-un
-- `vim.schedule`. `term = true` convertește *bufferul curent în momentul
-- callback-ului*, nu floatul creat cu 30 de linii mai devreme — deci orice fură
-- focusul în tick-ul acela face jobstart să nimerească alt buffer. Dacă acela e
-- modificat: "requires unmodified buffer". Plugin-ul e la HEAD upstream
-- (a04ad0d, dec. 2025), deci nu există update care să repare asta.
--
-- toggleterm creează bufferul și pornește terminalul în același pas, fără
-- deferare, deci cursa nu există.

local function lazygit(args, dir)
	local ok, terminal = pcall(require, "toggleterm.terminal")
	if not ok then
		vim.notify("toggleterm nu e disponibil", vim.log.levels.ERROR)
		return
	end
	terminal.Terminal
		:new({
			cmd = "lazygit" .. (args and (" " .. args) or ""),
			dir = dir or "git_dir",
			direction = "float",
			float_opts = { border = "rounded", width = math.floor(vim.o.columns * 0.9), height = math.floor(vim.o.lines * 0.9) },
			close_on_exit = true,
			on_open = function()
				vim.cmd("startinsert!")
			end,
		})
		:toggle()
end

return {
	"akinsho/toggleterm.nvim",
	-- `keys` singur ar face toggleterm lazy, iar `open_mapping = <c-\>` se setează
	-- în config-ul din toggle-terminal.lua — deci ar fi mort până la prima apăsare.
	lazy = false,
	keys = {
		{ "<leader>gg", function() lazygit() end, desc = "Open LazyGit" },
		{
			-- Nu <leader>gf: acolo e live_grep din fzf-lua (fuzzy_fzf.lua:18).
			"<leader>gc",
			function()
				lazygit(nil, vim.bo.buftype == "terminal" and vim.fn.getcwd() or vim.fn.expand("%:p:h"))
			end,
			desc = "LazyGit current file",
		},
		{ "<leader>gl", function() lazygit("log") end, desc = "LazyGit log" },
	},
}
