return {
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true },
				},
				["<C-x>"] = {
					"actions.select",
					opts = { horizontal = true },
				},
			},
			skip_confirm_for_simple_edits = true,
		},
		dependencies = { "echasnovski/mini.icons" },
		lazy = false,
	}
}
