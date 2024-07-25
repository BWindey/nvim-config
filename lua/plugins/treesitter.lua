return {
	{
		"nvim-treesitter/nvim-treesitter",

		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,

		opts = {
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
				"latex",
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

			-- Only for the ensure_installed
			sync_install = true,

			auto_install = true,
		},
	},
}
