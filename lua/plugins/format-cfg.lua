return {

	"stevearc/conform.nvim",
	opts = {

		formatters_by_ft = {
			yaml = { "prettier" },

			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			--- python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettierd", "prettierd", stop_after_first = true },
			sql = { "sqlfmt" },
			java = { "google-java-format", lsp_format = "fallback" },
			json = { "prettier", "prettierd", lsp_format = "fallback" },
			python = { "isort", "black" },
		},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 3000,
			lsp_format = "fallback",
		},
	},
}
