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
				{ "<leader>di", dap.step_into, desc = "Step into" },
				{ "<leader>do", dap.step_over, desc = "Step over" },
				{ "<leader>dc", dap.continue, desc = "Continue/start" },
			})

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
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function ()
			require("dapui").setup({})
		end
	},
}
