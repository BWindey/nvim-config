return {
	{
		"williamboman/mason.nvim",

		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"clangd",				-- C and C++
					"html",
					"hls",					-- Haskell
					"java_language_server",
					"tsserver",				-- JS
					"ltex",					-- Latex
					"markdown_oxide",
					"ruff",					-- Python
				}
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.hls.setup({ capabilities = capabilities })
			lspconfig.java_language_server.setup({ capabilities = capabilities })
			lspconfig.tsserver.setup({ capabilities = capabilities })
			lspconfig.ltex.setup({
				filetypes = { 'tex' },
 				capabilities = capabilities,
			})
			lspconfig.markdown_oxide.setup({ capabilities = capabilities })
			lspconfig.ruff.setup({ capabilities = capabilities })

			-- Add a border to the hover-window
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
				vim.lsp.handlers.hover, { border = "rounded" }
			)

			-- Keymaps using Which-key
			local wk = require("which-key")
			wk.add({
				mode = { 'n' },
				{ "<leader>l", group = "Lsp..." },
				{ "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
				{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
				{ "<leader>ld", vim.lsp.buf.definition, desc = "Jump to definition" },
				{ "<leader>la", vim.lsp.buf.code_action, desc = "Code actions" },
				{
					"<leader>le",
					function() vim.diagnostic.open_float({
						scope = "line", border = "rounded"
					}) end,
					desc = "Show diagnostic info",
				},
			})
		end,
	},
}
