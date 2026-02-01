return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
    opts = {
      -- options here

      filesystem = {
        follow_current_file = true,
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_gitignored = false,
          hide_dotfiles = false,
        },
      },

      window = {
        mappings = {
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
              -- use_image_nvim = true,
              use_snacks_image = true,
              title = "Neo-tree Preview",
            },
          },
        },
      },

      sources = { "filesystem" },
      source_selector = {
        winbar = false,
        statusline = false,
        sources = {
          { source = "filesystem" },
          -- { source = "buffers" },
          -- { source = "git_status" },
          -- { source = "document_symbols" },
        },
      },

      document_symbols = {
        follow_cursor = true,
        client_filters = "first",
        renderers = {
          root = {
            { "indent" },
            { "icon",  default = "C" },
            { "name",  zindex = 10 },
          },
          symbol = {
            { "indent",    with_expanders = true },
            { "kind_icon", default = "?" },
            {
              "container",
              content = {
                { "name",      zindex = 10 },
                { "kind_name", zindex = 20, align = "right" },
              },
            },
          },
        },
        window = {
          mappings = {
            ["<cr>"] = "jump_to_symbol",
            ["o"] = "jump_to_symbol",
            ["/"] = "filter",
            ["f"] = "filter_on_submit",
          },
        },
      },
    },
    --    config = function ()
    --      local builtin = require("neo-tree.builtin")
  },
}
