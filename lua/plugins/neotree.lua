return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
      -- options here
          
      filesystem = {
        follow_current_file = true,
        filtered_items = {
          visilbe = true,
          show_hidden_count = true,
          hide_gitignored = false,
          hide_dotfiles = false
        }
      }
    },
--    config = function ()
--      local builtin = require("neo-tree.builtin")

  }

}
