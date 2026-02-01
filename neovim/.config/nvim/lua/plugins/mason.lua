return {
  {

    "mason-org/mason.nvim",
    opts = {}
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        "qmlls"
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  }
}
