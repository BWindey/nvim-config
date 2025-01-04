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

function Discord(line1, line2)
	-- Get file extension based on buffer's filetype
	local extension = vim.fn.expand("%:e")

	-- Save current register contents
	local reg_save = vim.fn.getreg('"')

	-- Get selected lines, and remove common leading whitespace
	local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
	lines = gobble(lines)
	local selected_text = table.concat(lines, "\n")

	-- Surround the text in a Markdown code-block
	local code_block = "```" .. extension .. "\n" .. selected_text .. "\n```\n"

	-- Copy code block to clipboard
	vim.fn.setreg("+", code_block)

	-- Restore original register contents
	vim.fn.setreg('"', reg_save)
end

vim.api.nvim_create_user_command("Discord", function(opts)
	opts = opts or {}
	local line1 = opts.line1 or -1
	local line2 = opts.line2 or -1

	if line1 < 0 or line2 < 0 then
		print("Invalid range, aborting.")
		return
	end
	Discord(line1, line2)
end, { range = true })


vim.api.nvim_create_user_command("PinTop", function (opts)
	opts = opts or {}
	local line1 = opts.line1 or -1
	local line2 = opts.line2 or -1

	if line1 < 0 or line2 < 0 then
		print("Invalid range, aborting.")
		return
	end

	-- Split current buffer, and make top buffer only show the selection
	vim.cmd.split()
	vim.opt_local.scrolloff = 0
	vim.cmd.resize(line2 - line1 + 1)
	vim.cmd("normal! " .. line2 .. "G")
	vim.cmd.wincmd('j')

end, { range = true })
