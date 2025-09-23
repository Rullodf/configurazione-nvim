return {
	"uga-rosa/ccc.nvim",
	config = function()
		local ccc = require("ccc")
		require("ccc").setup({
			highlighter = {
				auto_enable = true, -- abilita l'highlight automatico
				lsp = true, -- usa l'LSP se disponibile
				update_insert = true, -- aggiorna durante l'insert mode
				filetypes = {}, -- vuoto = tutti i file
				excludes = {}, -- puoi escludere filetype specifici
			},
			recognize ={
				output = true;
				input = true;
			},
		})
		vim.opt.termguicolors = true
		vim.keymap.set({ "i", "n" }, "<C-c>", function()
			vim.cmd(":CccPick")
		end, { desc = "Color Picker" })
	end,
}
