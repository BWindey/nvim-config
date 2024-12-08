return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harp = require("harpoon")
			local wk = require("which-key")

			harp.setup()

			wk.add({
				mode = 'n',
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>ha", function() harp:list():add() end, desc = "Add buffer to Harpoon" },
				{
					"<leader>hl",
					function()
						harp.ui:toggle_quick_menu(
							harp:list(),
							{
								border = "rounded",
								title = " Harpoon "
							}
						)
					end,
					desc = "Toggle quick menu"
				},
				{ "<leader>hn", function() harp:list():next() end, desc = "Go to next buffer in Harpoon" },
				{ "<leader>hp", function() harp:list():prev() end, desc = "Go to previous buffer in Harpoon" },
			})
			vim.keymap.set("n", "<C-1>", function() harp:list():select(1) end)
			vim.keymap.set("n", "<C-2>", function() harp:list():select(2) end)
			vim.keymap.set("n", "<C-3>", function() harp:list():select(3) end)
			vim.keymap.set("n", "<C-4>", function() harp:list():select(4) end)
			vim.keymap.set("n", "<C-5>", function() harp:list():select(5) end)
			vim.keymap.set("n", "<C-6>", function() harp:list():select(6) end)
			vim.keymap.set("n", "<C-7>", function() harp:list():select(7) end)
			vim.keymap.set("n", "<C-8>", function() harp:list():select(8) end)
			vim.keymap.set("n", "<C-9>", function() harp:list():select(9) end)
		end,
	}
}
