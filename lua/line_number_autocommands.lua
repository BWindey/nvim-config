-- Autocommands to only enable relativenumber in a focussed area in normal/insert mode
vim.api.nvim_create_autocmd({ "CmdlineEnter", "WinLeave" }, {
	group = vim.api.nvim_create_augroup("cmd-line-relnum-toggle-on", { clear = true }),
	callback = function()
		if vim.bo.filetype ~= "help" then
			vim.wo.relativenumber = false
			vim.cmd([[ redraw ]])
		end
	end,
})

vim.api.nvim_create_autocmd({ "CmdlineLeave", "WinEnter" }, {
	group = vim.api.nvim_create_augroup("cmd-line-relnum-toggle-off", { clear = true }),
	callback = function()
		if vim.bo.filetype ~= "help" then
			vim.wo.relativenumber = true
			vim.cmd([[ redraw ]])
		end
	end,
})
