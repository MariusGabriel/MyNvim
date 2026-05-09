return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"saifulapm/neotree-file-nesting-config",
		"stevearc/dressing.nvim",
		"esmuellert/codediff.nvim",
	},
	config = function()
		local nesting = require("neotree-file-nesting-config")

		-- ─────────────────────────────────────────────
		-- SAFE REVEAL
		-- ─────────────────────────────────────────────
		local function safe_reveal()
			local buftype = vim.bo.buftype
			local bufname = vim.api.nvim_buf_get_name(0)
			if buftype == "" and bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
				vim.cmd("Neotree reveal")
			else
				vim.cmd("Neotree show")
			end
		end

		-- ─────────────────────────────────────────────
		-- WORKSPACE MANAGEMENT
		-- ─────────────────────────────────────────────
		local workspaces = {}
		local current_workspace = nil

		local function save_workspace(name)
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			if state and state.path then
				workspaces[name] = state.path
				current_workspace = name
				vim.notify("✓ Workspace salvat: " .. name, vim.log.levels.INFO)
			end
		end

		local function load_workspace(name)
			if workspaces[name] then
				require("neo-tree.command").execute({
					action = "set_root",
					dir = workspaces[name],
					source = "filesystem",
				})
				current_workspace = name
				vim.notify("✓ Workspace încărcat: " .. name, vim.log.levels.INFO)
			end
		end

		-- ─────────────────────────────────────────────
		-- NAVIGARE CU SĂGEȚI
		-- ─────────────────────────────────────────────
		-- Mergi la directorul părinte (săgeata stânga)
		local function navigate_to_parent()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			if state and state.path then
				local parent = vim.fn.fnamemodify(state.path, ":h")
				if parent and parent ~= state.path then
					require("neo-tree.command").execute({
						action = "set_root",
						dir = parent,
						source = "filesystem",
					})
					vim.notify("📁 Navigat la: " .. parent, vim.log.levels.INFO)
				else
					vim.notify("Deja la rădăcină!", vim.log.levels.WARN)
				end
			end
		end

		-- Mergi în folderul selectat (săgeata dreapta)
		local function navigate_into_folder()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if node and node.type == "directory" then
				require("neo-tree.command").execute({
					action = "set_root",
					dir = node.path,
					source = "filesystem",
				})
				vim.notify("📁 Intrat în: " .. node.path, vim.log.levels.INFO)
			elseif node and node.type == "file" then
				-- Deschide fișierul
				vim.cmd("edit " .. vim.fn.fnameescape(node.path))
			else
				vim.notify("Selectează un folder!", vim.log.levels.WARN)
			end
		end

		-- ─────────────────────────────────────────────
		-- BOOKMARKS
		-- ─────────────────────────────────────────────
		local bookmarks = {}

		local function add_bookmark()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if not node then
				vim.notify("Niciun nod selectat", vim.log.levels.WARN)
				return
			end
			local name = vim.fn.input("Bookmark name: ", vim.fn.fnamemodify(node.path, ":t"))
			if name ~= "" then
				bookmarks[name] = node.path
				vim.notify("✓ Bookmark adăugat: " .. name, vim.log.levels.INFO)
			end
		end

		local function show_bookmarks()
			local items = {}
			for name, path in pairs(bookmarks) do
				table.insert(items, name .. " → " .. path)
			end

			if #items == 0 then
				vim.notify("Niciun bookmark", vim.log.levels.WARN)
				return
			end

			vim.ui.select(items, {
				prompt = "📑 Selectează bookmark",
				format_item = function(item)
					return item
				end,
			}, function(choice)
				if choice then
					local name = choice:match("^(.-) →")
					if name and bookmarks[name] then
						require("neo-tree.command").execute({
							action = "set_root",
							dir = bookmarks[name],
							source = "filesystem",
						})
					end
				end
			end)
		end

		-- ─────────────────────────────────────────────
		-- QUICK MARKS
		-- ─────────────────────────────────────────────
		local quick_marks = {}
		local mark_index = 1

		local function add_quick_mark()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if node and node.type == "file" then
				quick_marks[mark_index] = node.path
				vim.notify(
					"✓ Fișier marcat #" .. mark_index .. ": " .. vim.fn.fnamemodify(node.path, ":t"),
					vim.log.levels.INFO
				)
				mark_index = mark_index + 1
				if mark_index > 9 then
					mark_index = 1
				end
			else
				vim.notify("Selectează un fișier!", vim.log.levels.WARN)
			end
		end

		local function goto_quick_mark(idx)
			if quick_marks[idx] then
				vim.cmd("edit " .. vim.fn.fnameescape(quick_marks[idx]))
				vim.notify("→ Deschis marcaj #" .. idx, vim.log.levels.INFO)
			else
				vim.notify("Niciun marcaj la #" .. idx, vim.log.levels.WARN)
			end
		end

		-- ─────────────────────────────────────────────
		-- FILE ACTIONS
		-- ─────────────────────────────────────────────
		local function smart_copy()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if not node then
				vim.notify("Niciun fișier selectat", vim.log.levels.WARN)
				return
			end

			local dest = vim.fn.input("Copy to: ", node.path)
			if dest ~= "" and dest ~= node.path then
				vim.notify("📋 Se copiază: " .. vim.fn.fnamemodify(node.path, ":t"), vim.log.levels.INFO)
				vim.schedule(function()
					vim.fn.system(string.format("cp -r %s %s", vim.fn.shellescape(node.path), vim.fn.shellescape(dest)))
					require("neo-tree.command").execute({ action = "refresh" })
					vim.notify("✅ Copiat cu succes!", vim.log.levels.INFO)
				end)
			end
		end

		local function smart_move()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if not node then
				vim.notify("Niciun fișier selectat", vim.log.levels.WARN)
				return
			end

			local dest = vim.fn.input("Move to: ", node.path)
			if dest ~= "" and dest ~= node.path then
				vim.notify("🚚 Se mută: " .. vim.fn.fnamemodify(node.path, ":t"), vim.log.levels.INFO)
				vim.schedule(function()
					vim.fn.system(string.format("mv %s %s", vim.fn.shellescape(node.path), vim.fn.shellescape(dest)))
					require("neo-tree.command").execute({ action = "refresh" })
					vim.notify("✅ Mutat cu succes!", vim.log.levels.INFO)
				end)
			end
		end

		-- ─────────────────────────────────────────────
		-- GIT FEATURES
		-- ─────────────────────────────────────────────
		local function git_blame()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if node and node.type == "file" then
				vim.cmd("tabnew")
				vim.cmd("edit " .. vim.fn.fnameescape(node.path))
				local has_fugitive = pcall(vim.cmd, "Git")
				if has_fugitive then
					vim.cmd("Git blame")
				else
					vim.notify("Instalează vim-fugitive pentru git blame", vim.log.levels.WARN)
				end
			end
		end

		local function git_diff_preview()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if node and node.type == "file" then
				vim.cmd("tabnew " .. vim.fn.fnameescape(node.path))
				vim.cmd("CodeDiff file HEAD")
			end
		end

		local function git_diff_revision()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if node and node.type == "file" then
				local rev = vim.fn.input("Compare vs (HEAD, branch, hash): ", "HEAD")
				if rev ~= "" then
					vim.cmd("tabnew " .. vim.fn.fnameescape(node.path))
					vim.cmd("CodeDiff file " .. rev)
				end
			end
		end

		local function git_history()
			vim.cmd("CodeDiff history")
		end

		local function codediff_status()
			vim.cmd("CodeDiff")
		end

		-- ─────────────────────────────────────────────
		-- TERMINAL
		-- ─────────────────────────────────────────────
		local function open_terminal_here()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			local path = node and node.path or vim.fn.getcwd()
			if node and node.type == "file" then
				path = vim.fn.fnamemodify(path, ":h")
			end
			vim.cmd("tabnew")
			vim.cmd("term")
			vim.cmd("cd " .. vim.fn.fnameescape(path))
			vim.cmd("startinsert")
		end

		-- ─────────────────────────────────────────────
		-- FZF-LUA
		-- ─────────────────────────────────────────────
		local function fuzzy_search()
			local has_fzf = pcall(require, "fzf-lua")
			if not has_fzf then
				vim.notify("fzf-lua nu e instalat! Rulează :Lazy install fzf-lua", vim.log.levels.WARN)
				return
			end

			local fzf = require("fzf-lua")
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			local cwd = node and node.path or vim.fn.getcwd()
			if node and node.type == "file" then
				cwd = vim.fn.fnamemodify(cwd, ":h")
			end

			vim.ui.select({
				"📁 Find Files",
				"🔍 Live Grep",
				"📦 Git Files",
				"📄 Buffers",
				"📜 Recent Files",
			}, {
				prompt = "🔍 Search in: " .. vim.fn.fnamemodify(cwd, ":t"),
			}, function(choice)
				if not choice then
					return
				end

				local opts = { cwd = cwd }

				if choice:match("Find Files") then
					fzf.files(opts)
				elseif choice:match("Live Grep") then
					fzf.live_grep(opts)
				elseif choice:match("Git Files") then
					fzf.git_files(opts)
				elseif choice:match("Buffers") then
					fzf.buffers()
				elseif choice:match("Recent Files") then
					fzf.oldfiles()
				end
			end)
		end

		-- ─────────────────────────────────────────────
		-- FILTER
		-- ─────────────────────────────────────────────
		local filter_active = false

		local function open_filter_popup()
			local Input = require("nui.input")
			local event = require("nui.utils.autocmd").event

			local input = Input({
				position = "50%",
				size = { width = 50 },
				border = {
					style = "rounded",
					text = {
						top = " 🔍 Filter Files ",
						top_align = "center",
					},
				},
			}, {
				prompt = " Pattern: ",
				default_value = "",
				on_submit = function(value)
					if value and value ~= "" then
						filter_active = true
						safe_reveal()
						vim.schedule(function()
							local state = require("neo-tree.sources.manager").get_state("filesystem")
							if state then
								require("neo-tree.sources.filesystem").navigate(state, state.path, nil, function()
									vim.api.nvim_feedkeys("/" .. value .. "\r", "n", false)
								end)
							end
						end)
					end
				end,
			})

			input:mount()
			input:on(event.BufLeave, function()
				input:unmount()
			end)
		end

		local function clear_filter()
			filter_active = false
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			if state then
				require("neo-tree.sources.filesystem").navigate(state, state.path, nil, function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", false)
					vim.cmd("Neotree refresh")
				end)
			end
			vim.notify("✓ Filter cleared", vim.log.levels.INFO)
		end

		-- ─────────────────────────────────────────────
		-- DIFF
		-- ─────────────────────────────────────────────
		local diff_state = { file1 = nil }

		local function diff_pick_file()
			local state = require("neo-tree.sources.manager").get_state("filesystem")
			local node = state and state.tree:get_node()
			if not node or node.type ~= "file" then
				vim.notify("Selectează un fișier!", vim.log.levels.WARN)
				return
			end
			if not diff_state.file1 then
				diff_state.file1 = node.path
				vim.notify(
					"📄 Primul: " .. vim.fn.fnamemodify(node.path, ":t") .. " — selectează al doilea",
					vim.log.levels.INFO
				)
			else
				local file2 = node.path
				vim.cmd(string.format(
					"CodeDiff file %s %s",
					vim.fn.fnameescape(diff_state.file1),
					vim.fn.fnameescape(file2)
				))
				diff_state.file1 = nil
				vim.notify("✅ CodeDiff activ! Folosește ]c și [c", vim.log.levels.INFO)
			end
		end

		-- ─────────────────────────────────────────────
		-- QUICK MENU
		-- ─────────────────────────────────────────────
		local function show_quick_menu()
			vim.ui.select({
				"📁 Toggle Explorer",
				"📍 Reveal Current File",
				"🔍 Fuzzy Search (fzf-lua)",
				"💻 Open Terminal Here",
				"🔖 Add Bookmark",
				"📑 Show Bookmarks",
				"💾 Save Workspace",
				"📂 Load Workspace",
				"⚡ Add Quick Mark",
				"🔄 Git Blame",
				"📊 Git Diff vs HEAD",
				"🕐 Git Diff vs Revision",
				"📜 Git History",
				"🔀 CodeDiff Status",
				"🎨 Toggle Hidden Files",
				"🧹 Clear Filter",
				"⬆️ Navigate to Parent",
			}, {
				prompt = "🚀 NeoTree Actions",
			}, function(choice)
				if not choice then
					return
				end

				if choice:match("Toggle Explorer") then
					vim.cmd("Neotree toggle")
				elseif choice:match("Reveal Current") then
					safe_reveal()
				elseif choice:match("Fuzzy Search") then
					fuzzy_search()
				elseif choice:match("Open Terminal") then
					open_terminal_here()
				elseif choice:match("Add Bookmark") then
					add_bookmark()
				elseif choice:match("Show Bookmarks") then
					show_bookmarks()
				elseif choice:match("Save Workspace") then
					local name = vim.fn.input("Workspace name: ")
					if name ~= "" then
						save_workspace(name)
					end
				elseif choice:match("Load Workspace") then
					local items = vim.tbl_keys(workspaces)
					if #items == 0 then
						vim.notify("Niciun workspace", vim.log.levels.WARN)
						return
					end
					vim.ui.select(items, { prompt = "Select workspace" }, function(choice)
						if choice then
							load_workspace(choice)
						end
					end)
				elseif choice:match("Quick Mark") then
					add_quick_mark()
				elseif choice:match("Git Blame") then
					git_blame()
				elseif choice:match("Git Diff vs HEAD") then
					git_diff_preview()
				elseif choice:match("Git Diff vs Revision") then
					git_diff_revision()
				elseif choice:match("Git History") then
					git_history()
				elseif choice:match("CodeDiff Status") then
					codediff_status()
				elseif choice:match("Toggle Hidden") then
					vim.cmd("Neotree toggle_hidden")
				elseif choice:match("Clear Filter") then
					clear_filter()
				elseif choice:match("Navigate to Parent") then
					navigate_to_parent()
				end
			end)
		end

		-- ─────────────────────────────────────────────
		-- CODEDIFF SETUP
		-- ─────────────────────────────────────────────
		require("codediff").setup({
			diff = {
				layout = "side-by-side",
				jump_to_first_change = true,
				compute_moves = true,
			},
			explorer = {
				position = "left",
				width = 40,
				view_mode = "tree",
			},
		})

		-- ─────────────────────────────────────────────
		-- NEO-TREE SETUP (CU SĂGEȚI ȘI LINII)
		-- ─────────────────────────────────────────────
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},

			nesting_rules = nesting.nesting_rules,
			hide_root_node = false,
			retain_hidden_root_indent = true,
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = false,
			git_status_async = true,
			git_status_async_options = {
				batch_size = 1000,
				batch_delay = 10, -- adaugă asta
			},

			sort_case_insensitive = true,

			use_default_mappings = false,

			default_component_configs = {
				container = { enable_character_fade = true },

				-- LINII DE INDENTARE (IERARHIE)
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					with_expanders = true,
					expander_collapsed = "📁",
					expander_expanded = "📂",
					expander_highlight = "NeoTreeExpander",
				},

				icon = {
					folder_closed = "📁",
					folder_open = "📂",
					folder_empty = "📁",
					folder_empty_open = "📂",
					default = "📄",
					highlight = "NeoTreeFileIcon",
				},

				modified = {
					symbol = "●",
					highlight = "NeoTreeModified",
				},

				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},

				git_status = {
					symbols = {
						added = "✨",
						modified = "📝",
						deleted = "❌",
						renamed = "🔄",
						untracked = "❓",
						ignored = "🙈",
						unstaged = "✏️",
						staged = "✅",
						unmerged = "⚠️",
					},
				},
			},

			window = {
				position = "left",
				width = 40,
				mapping_options = { noremap = true, nowait = true },
				mappings = {
					["<space>"] = {
						function(state)
							if state and state.tree then
								require("neo-tree.sources.common.commands").toggle_node(state)
							end
						end,
						nowait = false,
					},
					["<2-LeftMouse>"] = "open",

					-- SĂGEȚI PENTRU NAVIGARE
					["<Left>"] = function()
						navigate_to_parent()
					end,
					["<Right>"] = function()
						navigate_into_folder()
					end,

					["<cr>"] = "open",
					["<esc>"] = "cancel",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "focus_preview",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					["Z"] = "expand_all_nodes",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<Tab>"] = "next_source",
					["<S-Tab>"] = "prev_source",

					-- Diff
					["<leader>d"] = function()
						diff_pick_file()
					end,
					["<leader>D"] = function()
						diff_state.file1 = nil
						vim.notify("Diff resetat", vim.log.levels.INFO)
					end,

					-- Workspace
					["<leader>ws"] = function()
						local name = vim.fn.input("Workspace name: ")
						if name ~= "" then
							save_workspace(name)
						end
					end,
					["<leader>wl"] = function()
						local items = vim.tbl_keys(workspaces)
						if #items == 0 then
							vim.notify("Niciun workspace", vim.log.levels.WARN)
							return
						end
						vim.ui.select(items, { prompt = "Select workspace" }, function(choice)
							if choice then
								load_workspace(choice)
							end
						end)
					end,

					-- Bookmarks
					["<leader>b"] = function()
						add_bookmark()
					end,
					["<leader>B"] = function()
						show_bookmarks()
					end,

					-- File actions
					["<leader>c"] = function()
						smart_copy()
					end,
					["<leader>m"] = function()
						smart_move()
					end,

					-- Git
					["<leader>gb"] = function()
						git_blame()
					end,
					["<leader>gd"] = function()
						git_diff_preview()
					end,
					["<leader>gr"] = function()
						git_diff_revision()
					end,
					["<leader>gh"] = function()
						git_history()
					end,
					["<leader>gS"] = function()
						codediff_status()
					end,

					-- Terminal
					["<leader>t"] = function()
						open_terminal_here()
					end,

					-- Search
					["<leader>f"] = function()
						fuzzy_search()
					end,

					-- Quick menu
					["<leader>."] = function()
						show_quick_menu()
					end,

					-- Filter
					["<c-f>"] = function()
						open_filter_popup()
					end,
					["<c-x>"] = function()
						clear_filter()
					end,
				},
			},

			filesystem = {
				bind_to_cwd = true,
				follow_current_file = { enabled = true, leave_dirs_open = true },
				group_empty_dirs = false,
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = false,
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = false,
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						"node_modules",
						"__pycache__",
						".venv",
						"venv",
						"env",
						".pytest_cache",
						".mypy_cache",
						".ruff_cache",
						"target",
						"logs",
						"dist",
						"build",
						".next",
					},
					never_show = { ".DS_Store", "thumbs.db" },
				},
				window = {
					mappings = {
						-- Săgeți și în filesystem
						["<Left>"] = function()
							navigate_to_parent()
						end,
						["<Right>"] = function()
							navigate_into_folder()
						end,
						["<bs>"] = function()
							navigate_to_parent()
						end,
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["f"] = "filter_on_submit",
						["<c-f>"] = function()
							open_filter_popup()
						end,
						["<c-x>"] = function()
							clear_filter()
						end,
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
						["a"] = { "add", config = { show_path = "relative" } },
						["A"] = "add_directory",
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
					},
				},
			},

			buffers = {
				follow_current_file = { enabled = true, leave_dirs_open = false },
				group_empty_dirs = true,
				show_unloaded = true,
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["bd"] = "buffer_delete",
						["r"] = "rename",
						["s"] = "open_vsplit",
						["S"] = "open_split",
					},
				},
			},

			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},

			document_symbols = {
				follow_cursor = true,
				window = {
					mappings = {
						["o"] = "jump_to_symbol",
						["<cr>"] = "jump_to_symbol",
					},
				},
			},

			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{ source = "filesystem", display_name = " 📁 Files " },
					{ source = "buffers", display_name = " 📄 Buffers " },
					{ source = "git_status", display_name = " 🔀 Git " },
					{ source = "document_symbols", display_name = " 🏷️ Symbols " },
				},
			},
		})

		-- Patch get_state to guard against nil source_name (nui WinClosed race)
		local manager = require("neo-tree.sources.manager")
		local _orig_get_state = manager.get_state
		manager.get_state = function(source_name, tabnr, winid)
			if not source_name then
				return nil
			end
			return _orig_get_state(source_name, tabnr, winid)
		end

		-- ─────────────────────────────────────────────
		-- KEYMAPS GLOBALE
		-- ─────────────────────────────────────────────
		vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle explorer" })
		vim.keymap.set("n", "<leader>E", "<cmd>Neotree close<CR>", { desc = "Close explorer" })
		vim.keymap.set("n", "<leader>ef", safe_reveal, { desc = "Reveal current file" })
		vim.keymap.set("n", "<leader>eg", "<cmd>Neotree git_status<CR>", { desc = "Git status" })
		vim.keymap.set("n", "<leader>eb", "<cmd>Neotree buffers<CR>", { desc = "Buffers" })
		vim.keymap.set("n", "<leader>es", "<cmd>Neotree document_symbols<CR>", { desc = "Symbols" })
		vim.keymap.set("n", "<leader>er", "<cmd>Neotree refresh<CR>", { desc = "Refresh" })

		-- Quick menu
		vim.keymap.set("n", "<leader>mf", function()
			show_quick_menu()
		end, { desc = "NeoTree Menu" })

		-- CodeDiff global keymaps
		vim.keymap.set("n", "<leader>gd", "<cmd>CodeDiff file HEAD<CR>", { desc = "CodeDiff vs HEAD" })
		vim.keymap.set("n", "<leader>gh", "<cmd>CodeDiff history<CR>", { desc = "CodeDiff history" })
		vim.keymap.set("n", "<leader>gS", "<cmd>CodeDiff<CR>", { desc = "CodeDiff git status" })
		vim.keymap.set("n", "<leader>gr", function()
			local rev = vim.fn.input("Compare vs (HEAD, branch, hash): ", "HEAD")
			if rev ~= "" then
				vim.cmd("CodeDiff file " .. rev)
			end
		end, { desc = "CodeDiff vs revision" })

		-- Help
		vim.keymap.set("n", "<leader>eh", function()
			vim.notify(
				[[
╔════════════════════════════════════════════════════════════╗
║              🌲 NEO-TREE ENHANCED v3                      ║
╠════════════════════════════════════════════════════════════╣
║  NAVIGARE CU SĂGEȚI:                                      ║
║    ← (Left)   - Mergi la directorul părinte               ║
║    → (Right)  - Intră în folderul selectat                ║
║    ↑ (Up)     - Mergi la elementul de sus                 ║
║    ↓ (Down)   - Mergi la elementul de jos                 ║
║                                                           ║
║  COMENZI RAPIDE:                                          ║
║    <leader>e   - Toggle explorer                          ║
║    <leader>ef  - Reveal current file                      ║
║    <leader>d   - CodeDiff între 2 fișiere                 ║
║    <leader>b   - Add bookmark                             ║
║    <leader>B   - Show bookmarks                           ║
║    <leader>f   - Fuzzy search                             ║
║    <leader>t   - Open terminal here                       ║
║    <leader>c   - Smart copy                               ║
║    <leader>m   - Smart move                               ║
║                                                           ║
║  CODEDIFF (VSCode-style):                                 ║
║    <leader>gd  - Diff fișier vs HEAD                      ║
║    <leader>gr  - Diff fișier vs orice revision            ║
║    <leader>gh  - Git history (50 commits)                 ║
║    <leader>gS  - CodeDiff git status explorer             ║
║    <leader>gb  - Git blame (vim-fugitive)                 ║
║    ]c / [c     - Next/prev change în diff                 ║
║    ]f / [f     - Next/prev fișier în diff                 ║
║    t           - Toggle layout (side-by-side/inline)      ║
║    q           - Close diff / NeoTree                     ║
║                                                           ║
║  FILTER:                                                  ║
║    <C-f>       - Filter files                             ║
║    <C-x>       - Clear filter                             ║
╚════════════════════════════════════════════════════════════╝
			]],
				vim.log.levels.INFO,
				{ title = "NeoTree Help", timeout = 8000 }
			)
		end, { desc = "Help" })
	end,
}
