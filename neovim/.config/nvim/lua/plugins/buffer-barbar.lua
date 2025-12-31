return {

  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  -- vim.keymap.set("n", "", "<Cmd>BufferPrevious", {
  --   noremap = true,
  --   silent = true,
  --   desc = "Scroll Jendela ke Bawah 1 Baris",
  -- }),
  init = function()
    vim.g.barbar_auto_setup = false
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    -- BufferPrevious and BufferNext
    map("n", "H", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "L", "<Cmd>BufferNext<CR>", opts)
    vim.keymap.set("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", { silent = true })
    vim.keymap.set("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", { silent = true })
    vim.keymap.set("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", { silent = true })
    vim.keymap.set("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", { silent = true })
    vim.keymap.set("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", { silent = true })
    vim.keymap.set("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", { silent = true })
    vim.keymap.set("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", { silent = true })
    vim.keymap.set("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", { silent = true })
    vim.keymap.set("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", { silent = true })

    vim.keymap.set("n", "<leader>bq", "<Cmd>BufferMovePrevious<CR>", { silent = true })
    vim.keymap.set("n", "<leader>be", "<Cmd>BufferMoveNext<CR>", { silent = true })

    vim.keymap.set("n", "<leader>bb", "<Cmd>BufferPick<CR>", { silent = true })
    vim.keymap.set("n", "<leader>bd", "<Cmd>BufferPickDelete<CR>", { silent = true })

    vim.keymap.set("n", "<leader>bd", "<Cmd>BufferPickDelete<CR>", { silent = true })

    vim.keymap.set("n", "<leader>bp", "<Cmd>BufferPin<CR>", { silent = true })

    vim.keymap.set("n", "<leader>bdd", "<Cmd>BufferWipeout<CR>", { silent = true })
    vim.keymap.set("n", "<leader>bda", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", { silent = true })
    vim.keymap.set("n", "<leader>bdq", "<Cmd>BufferCloseBuffersLeft<CR>", { silent = true })
    vim.keymap.set("n", "<leader>bde", "<Cmd>BufferCloseBuffersRight<CR>", { silent = true })

    -- map("n", "<leader>1", "<Cmd>BufferGoTo 1<CR>", opts),
    -- map("n", "<leader>2", "<Cmd>BufferGoTo 2<CR>", opts),
    -- map("n", "<leader>3", "<Cmd>BufferGoTo 3<CR>", opts),
    -- map("n", "<leader>4", "<Cmd>BufferGoTo 4<CR>", opts),
    -- map("n", "<leader>5", "<Cmd>BufferGoTo 5<CR>", opts),
    -- map("n", "<leader>6", "<Cmd>BufferGoTo 6<CR>", opts),
    -- map("n", "<leader>7", "<Cmd>BufferGoTo 7<CR>", opts),
    -- map("n", "<leader>8", "<Cmd>BufferGoTo 8<CR>", opts),
    -- map("n", "<leader>9", "<Cmd>BufferGoTo 9<CR>", opts),
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
    animation = true,
    maximum_length = 15,
    minimum_padding = 1,
    maximum_padding = 1,
    highlight_alternate = false,
    filetype = {
      -- Sets the icon's highlight group.
      -- If false, will use nvim-web-devicons colors
      custom_colors = false,

      -- Requires `nvim-web-devicons` if `true`
      enabled = true,
    },
    insert_at_end = true,
    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout" },
    },
    icons = {
      buffer_index = true,
      pinned = { button = "󰐃", filename = true },
    },
    no_name_title = "unamed",
    visible = { modified = { buffer_number = true } },
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
