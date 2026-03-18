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

      dev_tools = {
        autostart = false,
        auto_open_browser = true
      },

      dev_log = {
        enabled = true,
        -- open_cmd = "enew", -- command to use to open the log buffer
      },

      lsp = {
        color = {
          enabled = true,
          background = true


        },
        on_attach = {
          vim.keymap.set("n", "<leader>lo", ":FlutterOutlineToggle<CR>", {
            noremap = true,
            silent = true,
            desc = "Show Flutter Outline Toogle",
          })
        }
      }
    }) -- use defaults
  end,
}
