return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      modules = {}, -- puoi anche ometterlo se non ti serve
      ensure_installed = { "lua", "python", "javascript" },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      highlight = { enable = true },
    })
  end,
}
