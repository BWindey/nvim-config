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


vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "json", "c3" },
	callback = function ()
		vim.opt_local.commentstring = "// %s"
	end
})

local function determine_c3_root()
	-- Try project.json
	local pr_json = vim.fs.root(0, "project.json")
	if pr_json ~= nil then
		return pr_json
	end
	-- Try git root
	local git_root = vim.fs.root(0, ".git")
	if git_root ~= nil then
		return git_root
	end
	-- Nothing found, assume standalone C3 file
	return vim.fn.getcwd()
end

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "c3", "c3i" },
	callback = function ()
		vim.lsp.start({
			name = "c3_lsp",
			cmd = {
				os.getenv("HOME") .. "/Programming/Go/c3-lsp/server/bin/c3lsp"
			},
			root_dir = determine_c3_root(),
		})
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "c", "h" },
	callback = function ()
		vim.opt_local.commentstring = "/* %s */"
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "dart", "html" },
	callback = function ()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = { "dart" },
	callback = function ()
		vim.opt_local.softtabstop = 2
		vim.opt.expandtab = true
	end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = myAutoCommands,
	pattern = "typst",
	callback = function ()
		vim.cmd("TypstPreview")
	end
})

-- HACK: until telescope updates
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopeFindPre",
	callback = function()
		vim.opt_local.winborder = "none"
		vim.api.nvim_create_autocmd("WinLeave", {
			once = true,
			callback = function()
				vim.opt_local.winborder = "rounded"
			end,
		})
	end,
})
