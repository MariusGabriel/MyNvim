-- Inlocuieste `workspace.library` static din servers.lua_ls (lsp.lua). Acela
-- indexa tot ce returna nvim_get_runtime_file("", true) la pornirea serverului
-- — ~2300 fisiere — si, de cand lspconfig e pe BufReadPre, continutul varia in
-- functie de ce pluginuri apucasera sa se incarce. lazydev incarca bibliotecile
-- la cerere, pe masura ce apar `require`-uri, deci e stabil si porneste instant.
return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- tipurile luvit, doar cand apare `vim.uv` in buffer
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
