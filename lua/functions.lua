function Discord()
	-- Get file extension based on buffer's filetype
	local extension = vim.fn.expand("%:e")

	-- Save current register contents
	local reg_save = vim.fn.getreg('"')

	-- Copy selected text to register
	vim.api.nvim_command("normal! gvy")

	-- Surround selected text with code block
	local selected_text = vim.fn.getreg('"')
	local code_block = "```" .. extension .. "\n" .. selected_text .. "```\n"

	-- Copy code block to clipboard
	vim.fn.setreg("+", code_block)

	-- Restore original register contents
	vim.fn.setreg('"', reg_save)
end

vim.cmd([[
  command! -range=% Discord :<line1>,<line2>call v:lua.Discord()
]])
