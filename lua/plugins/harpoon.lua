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

local function select_harpoon(index)
	require("harpoon"):list():select(index)
end

local function menu_harpoon()
	require("harpoon").ui:toggle_quick_menu(
		require("harpoon"):list(),
		{
			border = "rounded",
			title = " Harpoon "
		}
	)
end

local function add_harpoon()
	require("harpoon"):list():add()
end

local function clear_harpoon()
	require("harpoon"):list():clear()
end

local function next_harpoon()
	require("harpoon"):list():next()
end

local function prev_harpoon()
	require("harpoon"):list():prev()
end

return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		keys = {
			{ "<leader>ha", add_harpoon, desc = "Add buffer to Harpoon" },
			{ "<leader>hc", clear_harpoon, desc = "Clear Harpoon list" },
			{ "<leader>hl", menu_harpoon, desc = "Toggle quick menu" },
			{ "<leader>hn", next_harpoon, desc = "Go to next buffer in Harpoon" },
			{ "<leader>hp", prev_harpoon, desc = "Go to previous buffer in Harpoon" },
			{ "<C-1>", function() select_harpoon(1) end },
			{ "<C-2>", function() select_harpoon(2) end },
			{ "<C-3>", function() select_harpoon(3) end },
			{ "<C-4>", function() select_harpoon(4) end },
			{ "<C-5>", function() select_harpoon(5) end },
			{ "<C-6>", function() select_harpoon(6) end },
			{ "<C-7>", function() select_harpoon(7) end },
			{ "<C-8>", function() select_harpoon(8) end },
			{ "<C-9>", function() select_harpoon(9) end },
		},
		config = function()
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
