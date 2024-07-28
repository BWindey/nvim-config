return {
	{
		"numToStr/Comment.nvim",

		init = function ()
			local wk = require("which-key")
			local com = require("Comment.api")
			wk.add({
				{ "<leader>c", com.toggle.linewise.current, desc = "Toggle comment", mode = 'n' },
				{
					"<leader>cb",
					"<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
					desc = "Toggle blockcomment", mode = 'v'
				},
			})
		end,

		config = function ()
			require("Comment").setup({
				ignore = "^ *$",		-- Ignore empty lines'			
			})
		end
	}
}
