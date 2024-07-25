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


-- Command to paste content of global clipboard to the bottom of the file inside a comment
-- Will be used for the doctests of the JavaScript exercises
function PasteClipboardAndComment()
	-- Get the contents of the clipboard
	local clipboard_contents = vim.fn.getreg("+")

	-- Move to the end of the file
	vim.cmd("normal! G")

	-- Variable to store expected output-lines in when they consist of multiple lines
	local multi_output_lines = ""

	-- Insert each line of the clipboard contents at the end of the file
	for line in clipboard_contents:gmatch("[^\r\n]+") do
		line = line:gsub("\\U00A0", " ")
		if not line:find("^s*>") then
			multi_output_lines = multi_output_lines .. line .. "\\n"
		else
			-- If multi_output_lines is actually just 1 line, replace the Error with ! Error
			-- Else, treat it as a multi-line output
			-- And remove the last newline, as we don't want that one
			if multi_output_lines ~= "" then
				multi_output_lines = multi_output_lines:gsub("%\\n$", "")
				if not multi_output_lines:find("\\n") then
					multi_output_lines = multi_output_lines:gsub("(%S*Error%S*)", "! %1")
				else
					multi_output_lines = '"' .. multi_output_lines .. '"'
				end
				multi_output_lines = "// " .. multi_output_lines
				vim.fn.append("$", multi_output_lines)
				multi_output_lines = ""
			end

			-- Remove console.log(...)
			if line:find("console%.log%(") then
				line = line:gsub("console.log%(", "")
				line = line:gsub("%) *$", "")
			end
			line = line:gsub("(%S*Error%S*)", "! %1")
			line = line:gsub(">+", ">")
			line = "// " .. line
			vim.fn.append("$", line)
		end
	end
	-- De multi_output_lines kan nog content bevatten
	if multi_output_lines ~= "" then
		multi_output_lines = multi_output_lines:gsub("%\\n$", "")
		if not multi_output_lines:find("\\n") then
			multi_output_lines = multi_output_lines:gsub("(%S*Error%S*)", "! %1")
		else
			multi_output_lines = '"' .. multi_output_lines .. '"'
		end
		multi_output_lines = "// " .. multi_output_lines
		vim.fn.append("$", multi_output_lines)
		multi_output_lines = ""
	end

	-- Move the cursor back to the previous position
	vim.cmd("normal! ``")
end

-- Create mappings for functions
vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua PasteClipboardAndComment()<cr>", { noremap = true, silent = true })

vim.cmd([[
  command! -range=% Discord :<line1>,<line2>call v:lua.Discord()
]])
