-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true
require("line_number_autocommands")

require("config.lazy")
