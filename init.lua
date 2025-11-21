--buat relative number
--vim.opt.nu = true
--vim.opt.number = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "
vim.g.mapleader = ";"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")

vim.cmd("set softtabstop=2")

vim.cmd("set shiftwidth=2")

-- Enable select mode untuk snippet placeholders
vim.opt.selection = "inclusive"
vim.opt.selectmode = "mouse,key" -- Gunakan visual mode, bukan select mode default
--clipboard 1 buffer untuk semua
vim.opt.clipboard = "unnamedplus"

--exit inser mode dgn jj
vim.keymap.set("i", "jj", "<Esc>", { silent = true })

-- di init.lua
vim.o.timeoutlen = 400 -- 300 ms (0.3 detik), silakan sesuaikan
vim.o.ttimeoutlen = 10

require("config.lazy")

-- Setup snippet behavior (LazyVim style)
-- Insert mode: Tab/Shift-Tab untuk jump antar placeholder
vim.keymap.set("i", "<Tab>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.schedule(function()
			vim.snippet.jump(1)
		end)
		return ""
	else
		return "<Tab>"
	end
end, { expr = true, desc = "Jump to next snippet placeholder" })

vim.keymap.set("i", "<S-Tab>", function()
	if vim.snippet.active({ direction = -1 }) then
		vim.schedule(function()
			vim.snippet.jump(-1)
		end)
		return ""
	else
		return "<S-Tab>"
	end
end, { expr = true, desc = "Jump to previous snippet placeholder" })

-- Select mode: Tab/Shift-Tab untuk jump, backspace untuk delete
vim.keymap.set("s", "<Tab>", function()
	vim.snippet.jump(1)
end, { desc = "Jump to next snippet placeholder" })

vim.keymap.set("s", "<S-Tab>", function()
	vim.snippet.jump(-1)
end, { desc = "Jump to previous snippet placeholder" })

-- mapping telescope key
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- mapping neotree key
--vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree (Cmd)", silent = true })
