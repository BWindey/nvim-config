local myAutoCommands = vim.api.nvim_create_augroup("myAutoCommands", { clear = true })

-- Autocommands to only enable relativenumber in a focussed area in normal/insert mode
vim.api.nvim_create_autocmd({ "CmdlineEnter", "WinLeave" }, {
	group = myAutoCommands,
	callback = function()
		if vim.bo.filetype ~= "help" then
			vim.wo.relativenumber = false
			vim.cmd([[ redraw ]])
		end
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave", "WinEnter" }, {
	group = myAutoCommands,
	callback = function()
		local file_name = vim.fn.expand("%")
		if vim.bo.filetype ~= "help" and file_name:find("^DAP") ~= 1 and file_name:find("^%[dap%-") ~= 1 then
			vim.wo.relativenumber = true
			vim.cmd([[ redraw ]])
		end
	end,
})

-- For some reason, Haskell doesn't like tabs...
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = "haskell",
	callback = function ()
		-- Tabs - spaces, the whole jimmiemagick
		vim.opt_local.softtabstop = 4		-- Set the number of spaces when pressing tab
		vim.opt_local.shiftwidth = 4		-- Indentation level 4 spaces
		vim.opt_local.expandtab = true		-- Replace '\t' with spaces
	end
})
