-- Get a Telescope entry and convert it to a Harpoon entry.
-- Mostly stolen from Telescopes code (entry to quickfix-item)
local entry_to_harpoon_item = function(entry)
	local text = entry.text

	if not text then
		if type(entry.value) == "table" then
			text = entry.value.text
		else
			text = entry.value
		end
	end

	local file_path = require("telescope.from_entry").path(entry, false, false)

	return {
		value = file_path,
		context = { row = 1, col = 1 },
	}
end

-- The 2 functions below were for a part copied from Telescopes code that
-- adds entries to the quickfix list.

local function send_selected_to_harpoon(prompt_bufnr)
	local harpoon = require("harpoon")
	local actions = require "telescope.actions"
	local action_state = require "telescope.actions.state"
	local picker = action_state.get_current_picker(prompt_bufnr)

	for _, entry in ipairs(picker:get_multi_selection()) do
		harpoon:list():add(entry_to_harpoon_item(entry))
	end

	actions.file_edit(prompt_bufnr)
end

local function send_all_to_harpoon(prompt_bufnr)
	local harpoon = require("harpoon")
	local actions = require "telescope.actions"
	local action_state = require "telescope.actions.state"
	local picker = action_state.get_current_picker(prompt_bufnr)
	local manager = picker.manager

	for entry in manager:iter() do
		harpoon:list():add(entry_to_harpoon_item(entry))
	end

	actions.file_edit(prompt_bufnr)
end

return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harp = require("harpoon")
			local wk = require("which-key")

			harp.setup()

			wk.add({
				mode = 'n',
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>ha", function() harp:list():add() end, desc = "Add buffer to Harpoon" },
				{ "<leader>hc", function() harp:list():clear() end, desc = "Clear Harpoon list" },
				{
					"<leader>hl",
					function()
						harp.ui:toggle_quick_menu(
							harp:list(),
							{
								border = "rounded",
								title = " Harpoon "
							}
						)
					end,
					desc = "Toggle quick menu"
				},
				{ "<leader>hn", function() harp:list():next() end, desc = "Go to next buffer in Harpoon" },
				{ "<leader>hp", function() harp:list():prev() end, desc = "Go to previous buffer in Harpoon" },
			})
			vim.keymap.set("n", "<C-1>", function() harp:list():select(1) end)
			vim.keymap.set("n", "<C-2>", function() harp:list():select(2) end)
			vim.keymap.set("n", "<C-3>", function() harp:list():select(3) end)
			vim.keymap.set("n", "<C-4>", function() harp:list():select(4) end)
			vim.keymap.set("n", "<C-5>", function() harp:list():select(5) end)
			vim.keymap.set("n", "<C-6>", function() harp:list():select(6) end)
			vim.keymap.set("n", "<C-7>", function() harp:list():select(7) end)
			vim.keymap.set("n", "<C-8>", function() harp:list():select(8) end)
			vim.keymap.set("n", "<C-9>", function() harp:list():select(9) end)

			-- Add mappings to Telescope to send things to Harpoon
			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["<C-s>"] = send_selected_to_harpoon,
							["<C-a>"] = send_all_to_harpoon,
						},
						i = {
							["<C-a>"] = send_all_to_harpoon,
						},
					},
				},
			})
		end,
	},
}
