return {
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["<C-v>"] = {
					"actions.select",
					opts = { vertical = true, split = "botright" },
				},
				["<C-x>"] = {
					"actions.select",
					opts = { horizontal = true, split = "botright" },
				},
			}
		},
		dependencies = { "echasnovski/mini.icons" },
		lazy = false,
	}
}
