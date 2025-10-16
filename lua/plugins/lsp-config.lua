return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",				-- C and C++
				"html",
				"lua_ls",
				"tinymist",             -- Typst
				"markdown_oxide",
				"pylsp",				-- Python
				"ts_ls",				-- JS
			}
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
			{
				"neovim/nvim-lspconfig",
				keys = {
					{ "<leader>lh", vim.lsp.buf.hover, desc = "Hover" },
					{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
					{ "<leader>ld", vim.lsp.buf.definition, desc = "Jump to definition" },
					{ "<leader>lu", vim.lsp.buf.references, desc = "List all uses in quickfix" },
					{ "<leader>la", vim.lsp.buf.code_action, desc = "Code actions" },
					{ "<leader>lf", vim.lsp.buf.format, desc = "Format buffer" },
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
				}
			}
		},
	},
}
