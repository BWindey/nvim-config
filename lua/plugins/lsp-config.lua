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
					"bashls",
					"clangd",				-- C and C++
					"hls",					-- Haskell
					"html",
					"ltex",					-- Latex
					"lua_ls",
					"markdown_oxide",
					"ruff",					-- Python
					"ts_ls",				-- JS
				}
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.hls.setup({ capabilities = capabilities })
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.ltex.setup({
				filetypes = { 'tex' },
 				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.markdown_oxide.setup({ capabilities = capabilities })
			lspconfig.ruff.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })

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
				{ "<leader>lu", vim.lsp.buf.references, desc = "List all uses in quickfix" },
				{ "<leader>la", vim.lsp.buf.code_action, desc = "Code actions" },
				{ "<leader>lj", group = "Jump to ... diagnostic" },
				{
					"<leader>ljn",
					function() vim.diagnostic.goto_next({ float = false }) end,
					desc = "Jump to next diagnostic"
				},
				{
					"<leader>ljp",
					function() vim.diagnostic.goto_prev({ float = false }) end,
					desc = "Jump to previous diagnostic"
				},
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
