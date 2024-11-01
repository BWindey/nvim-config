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
				{ "<leader>ft", ts.treesitter,	desc = "Search treesitter tokens" },
				{ "<leader>fa", ts.current_buffer_fuzzy_find, desc = "Search anything in buffer" },
				{ "<leader>fd", ts.diagnostics,	desc = "Search LSP diagnostics" },

				{
					"<leader>fF",
					function() ts.find_files({
						hidden = true,
						no_ignore = true,
					})
					end,
					desc = "Find hidden files"
				},
				{
					"<leader>fm",
					function()
						ts.man_pages({
							sections = { "ALL" }
						})
					end,
					desc = "Search man-pages"
				},
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
