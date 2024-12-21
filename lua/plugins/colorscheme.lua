return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 10000,
		opts = {
			-- Gruvbox settings, see
			-- https://github.com/ellisonleao/gruvbox.nvim#configuration
			terminal_colors = true,
			transparent_mode = true,
		},

		init = function()
			vim.o.background = "dark"
			vim.cmd.colorscheme 'gruvbox'
		end,
	}
}
