return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dc", dap.continue)
		vim.keymap.set("n", "<leader>do", dap.step_over)
		vim.keymap.set("n", "<leader>di", dap.step_into)
		vim.keymap.set("n", "<leader>de", dap.step_out)
		vim.keymap.set("n", "<leader>ds", dap.terminate)

		vim.fn.sign_define("DapBreakpoint", {
			text = "", -- simbolo del breakpoint (Font Awesome / Nerd Font)
			texthl = "DiagnosticError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "", -- simbolo del breakpoint (Font Awesome / Nerd Font)
			texthl = "DiagnosticWarn",
			linehl = "DapStoppedLine",
			numhl = "",
		})

		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}

		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}

		vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#3c3836" })

		local dapui = require("dapui")
		require("dapui").setup({
			layouts = {
				{
					elements = {
						"scopes",
						"watches",
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						"repl", -- puoi lasciare il REPL se ti serve
						-- "console", <-- basta non metterla qui
					},
					size = 10,
					position = "bottom",
				},
			},
		})
		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close

		-- Debbugger C e C++
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on", "--quiet" },
		}
		dap.configurations.c = {
			{
				name = "Build & Debug",
				type = "gdb",
				request = "launch",
				program = function()
					-- Compila il file prima di eseguire
					local file = vim.fn.expand("%:r") -- nome senza estensione
					local compile_cmd = string.format("gcc -g %s.c -o %s", file, file)
					vim.fn.system(compile_cmd)

					-- Ritorna il path dell'eseguibile
					return vim.fn.getcwd() .. "/" .. file
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
				console = "integratedTerminal",
			},
		}
		dap.configurations.cpp = dap.configurations.c

		-- Debugger C# e F#
		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}
	end,
}
