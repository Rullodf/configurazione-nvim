vim.o.expandtab = false
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
vim.o.laststatus = 3
vim.keymap.set("i", "kj", "<ESC>", {})
vim.keymap.set("i", "jk", "<ESC>", {})
vim.keymap.set("n", "<leader>e", "$", {})
vim.keymap.set("n", "<leader>b", "^", {})
vim.keymap.set("n", "<leader>j", "ddp", {})
vim.keymap.set("n", "<leader>k", "ddkkp", {})
vim.keymap.set("n", "<leader>p", "Vyp", {})
vim.keymap.set("n", "<C-q>", ":q<CR>", {})
vim.wo.number = true
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 10
vim.diagnostic.config({
	virtual_text = true,
})
local timer = vim.loop.new_timer()
timer:start(
	0,
	1000,
	vim.schedule_wrap(function()
		local filename = vim.api.nvim_buf_get_name(0)
		local ext = filename:match("^.+(%..+)$")
		if ext ~= ".gd" then
			vim.cmd("silent! w")
		end
	end)
)
vim.diagnostic.config({
	float = {
		border = "rounded", -- Tipo di bordo
		focusable = false,
		header = "",      -- Nessuna intestazione
		prefix = "",      -- Nessun prefisso
	},
})
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        -- salva tutti i buffer modificati senza chiedere conferma
        vim.cmd("wa")
    end
})
