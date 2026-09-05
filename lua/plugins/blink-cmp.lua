return {
	{
		"saghen/blink.compat",
		-- use v2.* for blink.cmp v1.*
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},

	{
		"saghen/blink.cmp",
		-- in practica se incarca odata cu nvim-lspconfig, care cere
		-- require("blink.cmp").get_lsp_capabilities() in config-ul lui
		event = { "InsertEnter", "CmdlineEnter" },
		-- optional: provides snippets for the snippet source

		dependencies = {
			"rafamadriz/friendly-snippets",
			"ray-x/cmp-sql",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (c-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- all presets have the following mappings:
			-- c-space: open menu or open docs if already open
			-- c-n/c-p or up/down: select next/previous item
			-- c-e: hide menu
			-- c-k: toggle signature help (if signature.enabled = true)
			--
			-- see :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "default", ["<c-l>"] = { "accept", "fallback" } },

			appearance = {
				-- 'mono' (default) for 'nerd font mono' or 'normal' for 'nerd font'
				-- adjusts spacing to ensure icons are aligned
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "nerd font mono",
			},

			-- (default) only show the documentation popup when manually triggered
			completion = {
				menu = {
					border = "rounded",
				},
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "sql" },

				providers = {
					-- completare pe require-uri si pe API-ul pluginurilor in fisiere lua;
					-- score_offset ridicat ca sa treaca inaintea sugestiilor lsp
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},

					sql = {
						-- IMPORTANT: use the same name as you would for nvim-cmp
						name = "sql",
						module = "blink.compat.source",

						-- all blink.cmp source config options work as normal:
						score_offset = -3,

						-- this table is passed directly to the proxied completion source
						-- as the `option` field in nvim-cmp's source config
						--
						-- this is NOT the same as the opts in a plugin's lazy.nvim spec
						opts = {},
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "sql" },
								vim.o.filetype
							)
						end,
					},
				},
			},
			signature = { enabled = true },

			-- (default) rust fuzzy matcher for typo resistance and significantly better performance
			-- you may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- see the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
