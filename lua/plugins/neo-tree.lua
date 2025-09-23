return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left toggle<CR>', {})
    vim.keymap.set('n', '<C-l>', '<C-w>h', {})
    require("neo-tree").setup({
      window = {
        width = 40
      }
    })
  end
}

