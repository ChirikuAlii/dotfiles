return {

'sainnhe/gruvbox-material',

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

  

-- dark / light variant

vim.o.background = "dark"
-- apply colorscheme

vim.cmd.colorscheme('gruvbox-material')

end

}
