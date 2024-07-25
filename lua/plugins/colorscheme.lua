return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 10000,
		config = function()
			-- Change between light and dark depending on the hour
			-- Is an experiment to see if I can like light-mode
			local hour = tonumber(os.date("%H"))
			if hour >= 8 and hour < 19 then
				vim.o.background = "light"
			else
				vim.o.background = "dark"
			end

			-- Gruvbox settings, see 
			-- https://github.com/ellisonleao/gruvbox.nvim#configuration
			require("gruvbox").setup({
				terminal_colors = true,
				transparent_mode = true,
			})

			vim.cmd.colorscheme 'gruvbox'
		end,
	}
}
