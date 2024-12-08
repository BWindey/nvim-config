return {
	{
		"mfussenegger/nvim-dap",

		config = function ()
			-- Keymaps
			local wk = require("which-key")
			local dap = require("dap")

			wk.add({
				mode = 'n',
				{ "<leader>d", group = "Debugging..." },
				{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
				{ "<leader>dc", dap.continue, desc = "Continue/start" },
				{ "<leader>du", dap.continue, desc = "Go up in call stack" },
				{ "<leader>dd", dap.continue, desc = "Go down in call stack" },
			})
			-- Keys lay logically for me this way, F5 in middle, F8 above, F2 below
			vim.keymap.set('n', '<F5>', function() require('dap').step_over() end)
			vim.keymap.set('n', '<F2>', function() require('dap').step_into() end)
			vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
			-- And duplicates for on my laptop keyboard
			vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
			vim.keymap.set('n', '<F9>', function() require('dap').step_into() end)
			vim.keymap.set('n', '<F11>', function() require('dap').step_out() end)

			-- DapUI stuffs
			local dapui = require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				vim.o.mouse = "a"
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				vim.o.mouse = ""
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			-- Separate adapters
			local dap_adapters_dir = vim.fn.stdpath('config') .. '/lua/plugins/adapters/'
			for _, file in ipairs(vim.fn.readdir(dap_adapters_dir)) do
				local adapter_path = dap_adapters_dir .. file
				if adapter_path:match('%.lua$') then
					dofile(adapter_path)
				end
			end

		end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function ()
			require("dapui").setup({
				expand_lines = false,
				layouts = {
					{
						elements = {
							"console",
							"watches",
							"scopes",
						},
						size = 0.3,
						position = "right"
					},
					{
						elements = {
							"repl",
							"stacks",
						},
						size = 0.3,
						position = "bottom",
					},
				},
				floating = {
					border = "rounded",
				},
			})
		end
	},
	{
		"MunifTanjim/nui.nvim"
	}
}
