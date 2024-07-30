return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},

		config = function ()
			local wk = require("which-key")

			wk.add({
				mode = 'n',
				{ "<leader>t", group = "Todo's..." },
				{ "<leader>td", "<CMD>TodoQuickFix<CR>", desc = "QuickFix-list with all Todo's" },
				{ "<leader>tt", "<CMD>TodoTelescope<CR>", desc = "Telescope with all Todo's" },
			})

			require("todo-comments").setup()
		end
	}
}
