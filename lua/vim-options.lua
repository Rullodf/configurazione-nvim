vim.o.expandtab = false
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.g.mapleader = " "
vim.o.laststatus = 3
vim.keymap.set('i', 'kj', '<ESC>', {})
vim.keymap.set('i', 'jk', '<ESC>', {})
vim.keymap.set('n', '<leader>e', '$', {})
vim.keymap.set('n', '<leader>b', '^', {})
vim.keymap.set('n', '<leader>j', 'ddp', {})
vim.keymap.set('n', '<leader>k', 'ddkkp', {})
vim.keymap.set('n', '<leader>p', 'Vyp', {})
vim.keymap.set('n', '<C-q>', ':q<CR>', {})
vim.wo.number = true
vim.opt.wrap = false
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 10
vim.diagnostic.config({
  virtual_text = true,
})
local timer = vim.loop.new_timer()
timer:start(0, 1000, vim.schedule_wrap(function()
  vim.cmd('silent! wa')
end))

