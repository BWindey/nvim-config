return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim',
		},

		config = function()
			-- Keymap using which-key
			local wk = require("which-key")
			local ts = require("telescope.builtin")

			wk.add({
				mode = { 'n' },
				{ "<leader>f", group = "Search for..." },
				{ "<leader>ff", ts.find_files,	desc = "Find files" },
				{ "<leader>fg", ts.live_grep,	desc = "Live grep" },
				{ "<leader>fb", ts.buffers,		desc = "Search buffers" },
				{ "<leader>fh", ts.help_tags,	desc = "Search help-tags" },
			})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",

		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({})
					}
				}
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
