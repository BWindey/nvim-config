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
