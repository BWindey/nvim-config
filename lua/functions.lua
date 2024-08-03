local function gobble(lines)
	-- Taken from "michealrommel/nvim-silicon/lua/nvim-silicon/utils.lua"
	local shortest_whitespace = nil
	local whitespace = ""
	for _,v in pairs(lines) do
		_,_, whitespace = string.find(v, "^(%s*)")
		if type(whitespace) ~= "nil" then
			if shortest_whitespace == nil or (#whitespace < #shortest_whitespace and v ~= "") then
				shortest_whitespace = whitespace
			end
		end
	end

	if #shortest_whitespace > 0 then
		local newlines = {}
		for _,v in pairs(lines) do
			local newline = string.gsub(v, "^" .. shortest_whitespace, "", 1)
			table.insert(newlines, newline)
		end
		return newlines
	else
		return lines
	end
end

function Discord()
	-- Get file extension based on buffer's filetype
	local extension = vim.fn.expand("%:e")

	-- Save current register contents
	local reg_save = vim.fn.getreg('"')

	-- Copy selected text to register
	vim.api.nvim_command("normal! gvy")

	-- Surround selected text with code block
	local selected_text = vim.fn.getreg('"')

	-- Gobble longest common whitespace
	local lines = {}
	for line in string.gmatch(selected_text .. '\n',  "(.-)\n") do
		table.insert(lines, line)
	end
	lines = gobble(lines)
	selected_text = table.concat(lines, "\n")

	local code_block = "```" .. extension .. "\n" .. selected_text .. "```\n"

	-- Copy code block to clipboard
	vim.fn.setreg("+", code_block)

	-- Restore original register contents
	vim.fn.setreg('"', reg_save)
end

vim.cmd("command! -range=% Discord :<line1>,<line2>call v:lua.Discord()")
