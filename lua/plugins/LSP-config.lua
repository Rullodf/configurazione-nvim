return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				-- Web
				"html", -- HTML
				"cssls", -- CSS
				"jsonls", -- JSON

				-- Backend / scripting
				"pyright", -- Python
				"lua_ls", -- Lua
				"jdtls", -- Java
				"ts_ls",

				-- Sistemi / compilati
				"clangd",    -- C / C++
				"rust_analyzer", -- Rust

				-- Altro utile
				"yamlls", -- YAML
				"marksman", -- Markdown
			},
			automatic_enable = true,
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			vim.diagnostic.config({
				severity_sort = true, -- oppure false se vuoi invertire
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("html-lsp")
			vim.lsp.enable("css-lsp")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("eslint")
			vim.lsp.enable("emmet-lsp")
			vim.lsp.enable("dockerls")
			vim.lsp.enable("terraform-ls")
			vim.lsp.enable("docker_compose_language_service")
			vim.lsp.enable("asm-lsp")
			vim.lsp.enable("gdtoolkit")

			--------------------------------------------------------
			---configurazioni
			require("lspconfig")["gdscript"].setup({
				name = "godot",
				cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- così non ti segna 'vim' come variabile non definita
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true), -- aggiunge le API di nvim
							checkThirdParty = false,                    -- evita richieste noiose
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.lsp.config("ts_ls", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			--------------------------------------------------------
			local noice = require("noice.lsp")
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
			vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })
			vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Refactor" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			vim.keymap.set("n", "K", noice.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "Restart LSP" })
		end,
	},
}
