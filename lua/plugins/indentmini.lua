return {
	"nvimdev/indentmini.nvim",
  event = "VeryLazy",
  minlevel = 2,
	config = function()
		vim.cmd.highlight("IndentLine guifg=#555555")
		require("indentmini").setup() -- use default config
	end,
}
