-- For `plugins/markview.lua` users.
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- Completion for `blink.cmp`
    dependencies = { "saghen/blink.cmp" },
    config = function()
      require("markview").setup({

        block_quotes = {
          enable = true,
          wrap = false,
        },

        enable = true,
        code_blocks = {
          style = "block",
          label_direction = "left",
          sign = true

        },
        preview = {
          enable = true,
          icon_provider = "devicons", -- "mini" or "devicons",
        }
      })

      vim.keymap.set("n", "<leader>mr", "<cmd>Markview<CR>", { desc = "MarkdownPreview" })
      vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<CR>", { desc = "MarkdownPreview" })
      vim.g.markview_alpha = 0.05
    end
  },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      -- You can choose one of the following pickers
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      vim.keymap.set("n", "<leader>me", "<cmd>LivePreview start<CR>", { desc = "MarkdownPreview" })
      vim.keymap.set("n", "<leader>mx", "<cmd>LivePreview close<CR>", { desc = "MarkdownPreview" })
    end
  }

};
