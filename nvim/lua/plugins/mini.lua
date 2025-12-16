return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      -- require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.ai").setup()

      require("mini.pairs").setup()
      require("mini.move").setup()
      require("mini.bracketed").setup()
      require("mini.snippets").setup()

      --ini jump ke
      -- require("mini.jump").setup()

      -- indent scope bisa select sesuai scope pakai ke visual mode -> ai atau ii
      require("mini.indentscope").setup()
    end,
  },

  {

    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}
