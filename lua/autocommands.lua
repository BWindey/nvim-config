local myAutoCommands = vim.api.nvim_create_augroup("myAutoCommands", { clear = true })

local excluded_filetypes = {
	"help",
	"man",
	"dap-repl",
	"dapui_watches",
	"dapui_console",
	"dapui_stacks",
	"dapui_scopes",
	"dapui_breakpoints",
	"netrw",
}

local excluded_buftypes = {
	"terminal",
	"prompt",
	"quickfix",
	"nofile"
}

local function should_have_relnum()
	local filetype = vim.bo.filetype or ""
	local buftype = vim.bo.buftype or ""

	if vim.list_contains(excluded_filetypes, filetype) then
		return false
	elseif vim.list_contains(excluded_buftypes, buftype) then
		return false
	end

    -- Check for floating windows
    local config = vim.api.nvim_win_get_config(0)
    if config.relative ~= "" then
        return false
    end

	return true
end

-- Autocommands to only enable relativenumber in a focussed window in normal/insert mode
-- No numbers should ever be displayed in the help-
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
		if should_have_relnum() then
			vim.wo.relativenumber = true
			vim.cmd([[ redraw ]])
		end
	end,
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = myAutoCommands,
	callback = function ()
		local current_pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[ silent! %s/\s\+$// ]])
		vim.api.nvim_win_set_cursor(0, current_pos)
	end
})


-- For some reason, Haskell doesn't like tabs...
-- So this autocommand changes the tab-behaviour locally for Haskell
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "haskell", "cabal" },
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

vim.api.nvim_create_autocmd({ "TermOpen" }, {
	group = myAutoCommands,
	callback = function ()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "json", "c3" },
	callback = function ()
		vim.opt_local.commentstring = "// %s"
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "c", "h" },
	callback = function ()
		vim.opt_local.commentstring = "/* %s */"
	end
})
