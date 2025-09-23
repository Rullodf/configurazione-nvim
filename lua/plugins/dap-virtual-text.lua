return {
  "theHamsta/nvim-dap-virtual-text",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("nvim-dap-virtual-text").setup {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = false,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
    }
  end,
}

