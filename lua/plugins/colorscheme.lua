return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 10000,
		config = function()
			-- Gruvbox settings, see 
			-- https://github.com/ellisonleao/gruvbox.nvim#configuration
			require("gruvbox").setup({
				terminal_colors = true,
				transparent_mode = true,
			})

			vim.o.background = "dark"
			vim.cmd.colorscheme 'gruvbox'
		end,
	}
}
