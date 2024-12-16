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

-- Quickfix navigation
map('n', '<M-j>', '<cmd>cnext<CR>')
map('n', '<M-k>', '<cmd>cprev<CR>')

local function do_vertical()
	local hor_space = vim.api.nvim_win_get_width(0)
	local ver_space = vim.api.nvim_win_get_height(0)
	return hor_space > ver_space * 3
end

local function resize_buffer_vertical()
	local lines_in_file = vim.fn.line("$") -- last line in buffer
	vim.cmd.resize(lines_in_file)
end

local function resize_buffer_horizontal()
	local longest_line_length = 0
	local first_visible_line = vim.fn.line("w0")
	local last_visible_line = vim.fn.line("w$")
	local num_column_width = vim.opt.numberwidth:get()

	for i=first_visible_line,last_visible_line do
		local line_length = vim.fn.strdisplaywidth(vim.fn.getline(i))
		if line_length > longest_line_length then
			longest_line_length = line_length
		end
	end

	longest_line_length = longest_line_length + num_column_width + 1

	vim.cmd(string.format("vertical resize %d", longest_line_length))
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
	{ "<leader>qc", vim.cmd.cclose, desc = "Close quickfix list" },
	{ "<leader>qn", vim.cmd.cnext, desc = "Go to next quickfix item, alias of <M-j>" },
	{ "<leader>qp", vim.cmd.cprevious, desc = "Go to previous quickfix item, alias of <M-k>" },

	{ "<leader>s", vim.cmd.write, desc = "Save file" },

	{ "<leader>rv", resize_buffer_vertical, desc = "Resize buffer to amount of rows in file" },
	{ "<leader>rh", resize_buffer_horizontal, desc = "Resize buffer to longest line in file" },
})
wk.add({
	mode = { 'n', 'v' },
	{ "<leader>y", "\"+y", desc = "Yank to global clipboard" },
	{ "<leader>p", "\"+p", desc = "Paste from global clipboard" },
})
