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
map('i', '<C-f>', '<C-x><C-f>')

-- Escape terminal mode easily
map('t', '<Esc>', [[<C-\><C-n>]])

local function do_vertical()
	local hor_space = vim.api.nvim_win_get_width(0)
	local ver_space = vim.api.nvim_win_get_height(0)
	return hor_space > ver_space * 3
end

local wk = require("which-key")
wk.add({
	mode = 'n',
	{ "<leader>o", group = "Open..." },
	{
		"<leader>ot", function ()
			if do_vertical() then
				vim.cmd("botright vsplit +terminal")
			else
				vim.cmd("botright split +terminal")
			end
			vim.cmd.startinsert()
		end, desc = "Open terminal where there is most space"
	},
	{ "<leader>oq", vim.cmd.copen, desc = "Open quickfix list" },

	{ "<leader>q", group = "Quickfix-list" },
	{ "<leader>qo", vim.cmd.copen, desc = "Open quickfix list" },
	{ "<leader>qc", vim.cmd.cclose, desc = "Open quickfix list" },
	{ "<leader>qn", vim.cmd.cnext, desc = "Go to next quickfix item" },
	{ "<leader>qp", vim.cmd.cprevious, desc = "Go to previous quickfix item" },
})
