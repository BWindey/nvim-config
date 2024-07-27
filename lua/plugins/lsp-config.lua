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
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})
			lspconfig.bashls.setup({})
			lspconfig.clangd.setup({})
			lspconfig.html.setup({})
			lspconfig.hls.setup({})
			lspconfig.java_language_server.setup({})
			lspconfig.tsserver.setup({})
			lspconfig.ltex.setup({})
			lspconfig.markdown_oxide.setup({})
			lspconfig.ruff.setup({})

			-- Keymaps
			vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {})
			vim.keymap.set('n', '<leader>lgd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', '<leader>lca', vim.lsp.buf.code_action, {})
		end,
	},
}
