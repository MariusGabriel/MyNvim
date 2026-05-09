return {
	"nvim-java/nvim-java",
	config = false,
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					jdtls = {
						-- Your custom jdtls settings goes here
					},
				},
				setup = {
					jdtls = function()
						require("java").setup({
							-- Your custom nvim-java configuration goes here

							home = "/Library/Java/JavaVirtualMachines/microsoft-21.jdk/Contents/Home",
							eclipse = {
								downloadSources = true,
							},
							configuration = {
								updateBuildConfiguration = "interactive",
								-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
								-- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
								runtimes = {
									{
										name = "JavaSE-21",
										path = "/Library/Java/JavaVirtualMachines/microsoft-21.jdk/Contents/Home",
									},
								},
							},
							maven = {
								downloadSources = true,
							},
							implementationsCodeLens = {
								enabled = true,
							},
							referencesCodeLens = {
								enabled = true,
							},
							references = {
								includeDecompiledSources = true,
							},
							signatureHelp = { enabled = true },
							format = {
								enabled = true,
								-- Formatting works by default, but you can refer to a specific file/URL if you choose
								-- settings = {
								--   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
								--   profile = "GoogleStyle",
								-- },
							},
							completion = {
								favoriteStaticMembers = {
									"org.hamcrest.MatcherAssert.assertThat",
									"org.hamcrest.Matchers.*",
									"org.hamcrest.CoreMatchers.*",
									"org.junit.jupiter.api.Assertions.*",
									"java.util.Objects.requireNonNull",
									"java.util.Objects.requireNonNullElse",
									"org.mockito.Mockito.*",
								},
								importOrder = {
									"java",
									"javax",
									"com",
									"org",
								},
							},
							sources = {
								organizeImports = {
									starThreshold = 9999,
									staticStarThreshold = 9999,
								},
							},
							codeGeneration = {
								toString = {
									template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
								},
								useBlocks = true,
							},
						})
					end,
				},
			},
		},
	},
}
