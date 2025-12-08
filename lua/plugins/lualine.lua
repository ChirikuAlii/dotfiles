return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({

      -- options = {
      -- always_show_tabline = true,
      -- },

      sections = {
        lualine_x = { "lsp_status", "encoding", "filetype" },
        lualine_a = { "mode" },
        lualine_b = {
          { "tabs", tab_max_length = 500, path = 3, mode = 1, use_mode_colors = true },
          "diff",
          "diagnostics",
        },
        lualine_c = {

          function()
            return require("screenkey").get_keys()
          end,
        },
      },

      -- hanya aktif ketika buffer aktif dan satu tempat saja
      -- tabline = {
      --   lualine_a = { "filename" },
      -- },

      -- hanya aktif ketika buffer selalu aktif keduanya diatas buffer
      winbar = {
        lualine_a = { "filename" },
        -- lualine_a = { { "tabs", tab_max_length = 500, path = 1, mode = 1, use_mode_colors = true } },
      },

      inactive_winbar = {
        lualine_a = { "filename" },
      },
    })
  end,
}
