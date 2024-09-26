-- Move window mappings
local function map(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Map Ctrl + arrow keys for window movement
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')
map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')

require("which-key").add({
	mode = 'n',
	{ "<leader>o", group = "Open..." },
	{ "<leader>ot", function ()
		local hor_space = vim.api.nvim_win_get_width(0)
		local ver_space = vim.api.nvim_win_get_height(0)
		if hor_space < ver_space * 3 then
			vim.cmd("botright split +terminal")
		else
			vim.cmd("botright vsplit +terminal")
		end
		vim.cmd.startinsert()
	end, desc = "Open terminal where there is most space" }
})
