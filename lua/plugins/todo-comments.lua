return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,

		keys = {
			{ "<leader>td", "<CMD>TodoQuickFix<CR>", desc = "QuickFix-list with all Todo's" },
			{ "<leader>tt", "<CMD>TodoTelescope<CR>", desc = "Telescope with all Todo's" },
		},

		config = function ()
			require("todo-comments").setup({
				keywords = {
					ASK = { icon = "?", color = "hint", alt = { "QUESTION" } },
					IDEA = { icon = "\u{f400}", color = "#D79921" },
					STEPS = { icon = "\u{f0117}", color = "#B8BB26" },
				},
			})
		end
	}
}
