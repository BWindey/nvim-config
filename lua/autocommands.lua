local myAutoCommands = vim.api.nvim_create_augroup("myAutoCommands", { clear = true })

-- Autocommands to only enable relativenumber in a focussed area in normal/insert mode
-- No numbers should ever be displayed in the help-pages and debugging windows
vim.api.nvim_create_autocmd({ "CmdlineEnter", "WinLeave" }, {
	group = myAutoCommands,
	callback = function()
		vim.wo.relativenumber = false
		vim.cmd([[ redraw ]])
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave", "WinEnter" }, {
	group = myAutoCommands,
	callback = function()
		local file_name = vim.fn.expand("%")
		if vim.bo.filetype ~= "help"
			and file_name:find("^DAP") ~= 1
			and file_name:find("^%[dap%-") ~= 1
			and file_name ~= ""
			and file_name:find("^man") ~= 1
		then
			vim.wo.relativenumber = true
			vim.cmd([[ redraw ]])

		-- While we're at it, might as well set some extra settings for debugging
		elseif file_name:find("^DAP") == 1 or file_name:find("^%[dap%-") == 1 then
			vim.opt_local.scrolloff = 1
		end
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
	group = myAutoCommands,
	callback = function ()
		local current_pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[ silent! %s/\s\+$// ]])
		vim.api.nvim_win_set_cursor(0, current_pos)
	end
})


-- For some reason, Haskell doesn't like tabs...
-- So this autocommand changes the tab-behaviour locally for haskell
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

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	group = myAutoCommands,
	callback = function()
		-- Visual guide to keep lines shorter then 80 chars
		vim.opt.colorcolumn = "80"
	end
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	group = myAutoCommands,
	callback = function()
		-- Visual guide to keep lines shorter then 80 chars
		vim.opt.colorcolumn = ""
	end
})
