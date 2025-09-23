return {
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>gg",
				function()
					vim.cmd("LazyGit")
				end,
				desc = "Open Lazygit",
			},
		},
	},
}
