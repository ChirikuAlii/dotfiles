return {

  "sainnhe/gruvbox-material",

  lazy = false,

  priority = 1000,

  config = function()
    -- Optionally configure and load the colorscheme

    -- directly inside the plugin declaration.

    vim.g.gruvbox_material_enable_italic = false

    -- pilih palette: pakai warna original gruvbox

    vim.g.gruvbox_material_foreground = "original"

    -- optional: level kontras background

    -- hard | medium | soft (default: medium)

    vim.g.gruvbox_material_background = "soft"

    vim.g.gruvbox_material_float_style = "dim"
    vim.g.gruvbox_transparent_background = 2

    -- dark / light variant

    vim.o.background = "dark"
    -- apply colorscheme

    vim.cmd.colorscheme("gruvbox-material")
    -- Jalankan ini setelah setup colorscheme

    local config = vim.fn['gruvbox_material#get_configuration']()
    local p = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground, config.colors_override)

    -- 2. Fungsi pembantu untuk set highlight (agar lebih rapi)
    local function hl(group, options)
      vim.api.nvim_set_hl(0, group, options)
    end

    -- --- SNACKS PICKER HIGHLIGHTS ---
    -- hl("SnacksPicker", { bg = p.bg0[1], fg = p.fg0[1] })
    -- hl("SnacksPickerBorder", { bg = p.bg0[1], fg = p.grey0[1] })
    -- hl("SnacksPickerTitle", { bg = p.bg0[1], fg = p.yellow[1], bold = true })
    -- hl("SnacksPickerInputTitle", { bg = p.bg0[1], fg = p.orange[1], bold = true })
    -- hl("SnacksPickerList", { bg = p.bg0[1] })
    -- hl("SnacksPickerPreview", { bg = p.bg1[1] }) -- Pakai bg1 agar kontras dengan list
    -- hl("SnacksPickerSelected", { bg = p.bg3[1], bold = true })
    -- hl("SnacksPickerMatch", { fg = p.yellow[1], bold = true })

    -- --- BARBAR (BUFFERLINE) HIGHLIGHTS ---
    hl("BufferCurrent", { bg = p.bg1[1], fg = p.fg0[1], bold = true })
    hl("BufferCurrentIndex", { bg = p.bg1[1], fg = p.grey1[1] })
    hl("BufferCurrentSign", { bg = p.bg0[1], fg = p.bg0[1] })

    hl("BufferVisible", { bg = p.bg0[1], fg = p.grey1[1] })
    hl("BufferVisibleIndex", { bg = p.bg0[1], fg = p.grey1[1] })
    hl("BufferVisibleSign", { bg = p.bg0[1], fg = p.bg0[1] })

    hl("BufferInactive", { bg = p.bg0[1], fg = p.grey1[1] })
    hl("BufferInactiveIndex", { bg = p.bg0[1], fg = p.grey1[1] })
    hl("BufferInactiveSign", { bg = p.bg0[1], fg = p.bg0[1] })

    hl("BufferTabpageFill", { bg = p.bg0[1], fg = p.bg0[1] })


    -- --- NEO-TREE HIGHLIGHTS ---
    -- Background sidebar (menggunakan bg_status agar sedikit lebih gelap/kontras dari editor)
    hl("NeoTreeNormal", { bg = p.bg0[1], fg = p.fg0[1] })
    hl("NeoTreeNormalNC", { bg = p.bg0[1], fg = p.fg0[1] })
    hl("NeoTreeEndOfBuffer", { bg = p.bg0[1], fg = p.bg0[1] })
    -- hl("NeoTreeNormal", { bg = p.bg0[1], fg = p.fg0[1] })
    -- hl("NeoTreeNormalNC", { bg = p.bg0[1], fg = p.fg0[1] })
    -- hl("NeoTreeEndOfBuffer", { bg = p.bg0[1], fg = p.bg0[1] })

    -- Folder & File
    -- hl("NeoTreeDirectoryName", { fg = p.fg0[1] })
    -- hl("NeoTreeDirectoryIcon", { fg = p.orange[1] }) -- Ikon folder biar stand out
    -- hl("NeoTreeFileName", { fg = p.fg1[1] })
    -- hl("NeoTreeRootName", { fg = p.purple[1], bold = true })
    -- hl("NeoTreeExpander", { fg = p.grey1[1] })

    -- Cursor & Selection
    -- hl("NeoTreeCursorLine", { bg = p.bg3[1] })
    --
    -- -- Git Status di Neo-tree
    -- hl("NeoTreeGitAdded", { fg = p.green[1] })
    -- hl("NeoTreeGitModified", { fg = p.yellow[1] })
    -- hl("NeoTreeGitDeleted", { fg = p.red[1] })
    -- hl("NeoTreeGitUntracked", { fg = p.orange[1] })
    -- hl("NeoTreeGitConflict", { fg = p.red[1], bold = true })
    --
    -- -- WinSeparator (Garis pemisah antara Neo-tree dan editor)
    -- hl("NeoTreeWinSeparator", { fg = p.bg0[1], bg = p.bg0[1] })
    --
    -- local colors = {
    --   bg_soft   = "#32302F",
    --   -- bg_medium = "#282828",
    --   bg_medium = "#32302F",
    --   bg_bright = "#3c3836",
    --   fg        = "#ebdbb2",
    --   gray      = "#928374",
    --   yellow    = "#fabd2f",
    --   orange    = "#fe8019",
    --   selection = "#504945",
    -- }
    --
    -- -- --- SNACKS PICKER (Agar Senada dengan Gruvbox Soft) ---
    -- local snacks_hl = {
    --   SnacksPicker           = { bg = colors.bg_soft, fg = colors.fg },
    --   SnacksPickerBorder     = { bg = colors.bg_soft, fg = colors.gray },
    --   SnacksPickerTitle      = { bg = colors.bg_soft, fg = colors.yellow, bold = true },
    --   SnacksPickerInputTitle = { bg = colors.bg_soft, fg = colors.orange, bold = true },
    --   SnacksPickerList       = { bg = colors.bg_soft },
    --   SnacksPickerPreview    = { bg = colors.bg_medium }, -- Preview sedikit lebih gelap
    --   SnacksPickerSelected   = { bg = colors.selection, bold = true },
    --   SnacksPickerMatch      = { fg = colors.yellow, bold = true },
    -- }
    --
    -- -- --- BARBAR (Bufferline) ---
    -- local barbar_hl = {
    --   -- Buffer yang sedang aktif
    --   BufferCurrent       = { bg = colors.bg_soft, fg = colors.fg, bold = true },
    --   BufferCurrentIndex  = { bg = colors.bg_soft, fg = colors.yellow },
    --   BufferCurrentSign   = { bg = colors.bg_soft, fg = colors.yellow },
    --
    --   -- Buffer yang terlihat di split lain tapi tidak difokuskan
    --   BufferVisible       = { bg = colors.bg_soft, fg = colors.gray },
    --   BufferVisibleIndex  = { bg = colors.bg_soft, fg = colors.gray },
    --   BufferVisibleSign   = { bg = colors.bg_soft, fg = colors.gray },
    --
    --   -- Buffer yang tidak aktif (background)
    --   BufferInactive      = { bg = colors.bg_medium, fg = colors.gray },
    --   BufferInactiveIndex = { bg = colors.bg_medium, fg = colors.gray },
    --   BufferInactiveSign  = { bg = colors.bg_medium, fg = colors.gray },
    --
    --   -- Area kosong di belakang tab
    --   BufferTabpageFill   = { bg = "#32302F", fg = "#32302F" },
    -- }
    -- for group, opts in pairs(barbar_hl) do
    --   vim.api.nvim_set_hl(0, group, opts)
    -- end
    --    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    --    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    -- local highlights = {
    --   -- BufferCurrent     = { fg = '#ffffff', bg = '#000000', bold = true },
    --   -- BufferVisible     = { fg = '#aaaaaa', bg = '#222222' },
    --   -- BufferInactive    = { fg = '#555555', bg = '#111111' },
    --   BufferTabpageFill = { bg = '#32302F', fg = '#32302F' },
    --
    --   -- Jika kamu pakai plugin bufferline.nvim (bukan barbar), gunakan ini:
    --   -- BufferLineFill              = { bg = '#32302F' },
    --   -- BufferLineBackground        = { fg = '#555555', bg = '#111111' },
    -- }
    --
    -- for group, opts in pairs(highlights) do
    --   vim.api.nvim_set_hl(0, group, opts)
    -- end
  end,
}
