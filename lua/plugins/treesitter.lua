return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"asm",
					"bash",
					"c",
					"cpp",
					"diff",
					"haskell",
					"html",
					"java",
					"javascript",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"ruby",
					"vim",
					"vimdoc",
				},
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
