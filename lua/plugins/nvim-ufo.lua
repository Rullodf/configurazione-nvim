return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      lazy = true,
    },
    config = function()
      vim.o.foldcolumn = "auto:1" -- '0' is not bad
      vim.o.foldlevel = 99     -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- Using ufo
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.)
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
      --
      -- Option 4: disable all providers for all buffers
      -- Not recommend, AFAIK, the ufo's providers are the best performance in Neovim
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return ""
        end,
      })
    end,
  },
}
