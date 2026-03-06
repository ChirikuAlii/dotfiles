return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({

      decorations = {
        statuslinew = {
          device = true,
          app_version = true
        }
      },
      widget_guides = {
        enabled = true
      },

      lsp = {
        color = {
          enabled = true,
          background = true
        }
      }
    }) -- use defaults
  end,
}
