return {
  { 'nvim-telescope/telescope.nvim', 
    tag = 'v0.1.9',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = "flex",  -- auto-switch horizontal/vertical
          layout_config = {
            flex = {
              horizontal = {
                preview_width = 0.6,
                preview_cutoff = 120,  -- switch ke vertical kalau < 120 width
              },
              vertical = {
                height = 0.9
              }
            }
          }
        }
      })
    end
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup ({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            -- even more opts
            }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
  
}
