return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.surround").setup()
    require("mini.comment").setup()
    require("mini.ai").setup()

    require("mini.pairs").setup()
    require("mini.move").setup()
    require("mini.bracketed").setup()
    require("mini.snippets").setup()

    --ini jump ke
    require("mini.jump").setup()

    -- indent scope bisa select sesuai scope pakai ke visual mode -> ai atau ii
    require("mini.indentscope").setup()
  end,
}
