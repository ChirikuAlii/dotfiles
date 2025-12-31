return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*", -- or branch = "main", to use the latest commit
  config = function()
    vim.keymap.set("n", "<leader>ts", function()
      require("screenkey").toggle_statusline_component()
    end, { desc = "Toggle screenkey statusline component" })
  end,
}
