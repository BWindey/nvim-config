-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.mouse = ""

-- When in doubt about some option, use `:help <option>`
--
-- Tabs - spaces, the whole jimmiemagick
vim.opt.tabstop = 4			-- Render '\t' as 4 spaces
vim.opt.softtabstop = 0		-- Set the number of spaces when pressing tab
vim.opt.shiftwidth = 4		-- Indentation level 4 spaces
vim.opt.expandtab = false	-- Replace '\t' with spaces
vim.smartindent = true		-- Auto-indentation for programming

vim.opt.wrap = false
vim.opt.hlsearch = false 	-- Highlight all matching patterns from search
vim.opt.incsearch = true	-- Highlight while typing search-pattern

vim.opt.swapfile = true		-- False if file is confidential
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.scrolloff = 8		-- Keep 8 lines above/below cursor visible
vim.opt.signcolumn = "number"
vim.opt.colorcolumn = "80"	-- Visual guide to keep lines shorter then 80 chars

-- Escape terminal mode easily
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Load the plugins first so I can use them (which-key) in the next steps
require("config.lazy")

-- Some of my very beautiful extra configs
require("autocommands")
require("functions")
require("folds")
require("keybinds")
