local colors = {
	bg0 = "#1d2021", -- background gelap
	bg1 = "#282828", -- background sedikit lebih terang
	bg2 = "#32302f", -- background untuk menu
	bg_red = "#F9B529", -- merah/salmon untuk selection (seperti di gambar)
	fg = "#d4be98", -- foreground text
	red = "#F9B529", -- merah
	--red = "#ea6962", -- merah
	orange = "#e78a4e", -- orange untuk Function
	yellow = "#d8a657", -- yellow
	green = "#a9b665", -- green
	aqua = "#89b482", -- aqua untuk Variable
	blue = "#7daea3", -- blue
	purple = "#d3869b", -- purple
	grey0 = "#7c6f64", -- grey untuk border
	grey1 = "#928374", -- grey terang
	grey2 = "#a89984", -- grey lebih terang
}
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "
vim.g.mapleader = ";"

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")

vim.cmd("set softtabstop=2")

vim.cmd("set shiftwidth=2")
vim.cmd("set laststatus=3")

vim.keymap.set("n", "<leader>wv", "<Cmd>vsplit<CR>", {
	noremap = true,
	silent = true,
	desc = "V Split",
})

vim.keymap.set("n", "<leader>ws", "<Cmd>split<CR>", {
	noremap = true,
	silent = true,
	desc = "Split",
})

-- 1. Ganti <C-e> (Scroll Bawah) menjadi <C-k> dan scroll 1 baris
vim.keymap.set("n", "<C-d>", "3<C-e>", {
	noremap = true,
	silent = true,
	desc = "Scroll Jendela ke Bawah 1 Baris",
})

-- 2. Ganti <C-y> (Scroll Atas) menjadi <C-j> dan scroll 1 baris
vim.keymap.set("n", "<C-u>", "3<C-y>", {
	noremap = true,
	silent = true,
	desc = "Scroll Jendela ke Atas 1 Baris",
})

-- Scroll banyak baris ke atas dan kebawah
vim.keymap.set("n", "<C-f>", "<C-d>", {
	noremap = true,
	silent = true,
	desc = "Scroll Jendela ke Bawah 1 Baris",
})

vim.keymap.set("n", "<C-y>", "<C-u>", {
	noremap = true,
	silent = true,
	desc = "Scroll Jendela ke Atas 1 Baris",
})
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

local theme_live_grep = function()
	-- Set Telescope colors after colorscheme loads
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = colors.red, bold = true })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.red })

	vim.api.nvim_set_hl(0, "TelescopePromptBorder", {})

	vim.api.nvim_set_hl(0, "TelescopePromptTitle", {})
	builtin.live_grep()
end

local theme_find_files = function()
	-- Set Telescope colors after colorscheme loads
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = colors.red, bold = true })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.red })
	builtin.find_files()
end

local theme_find_buffers = function()
	require("telescope.builtin").buffers({
		initial_mode = "normal",
		attach_mappings = function(prompt_bufnr, map)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			-- Tab: toggle selection (multi-select)
			map("n", "<Tab>", function()
				actions.toggle_selection(prompt_bufnr)
				actions.move_selection_next(prompt_bufnr)
			end)

			map("n", "<S-Tab>", function()
				actions.toggle_selection(prompt_bufnr)
				actions.move_selection_previous(prompt_bufnr)
			end)

			-- dd: delete buffer(s) - single or multi-select
			map("n", "dd", function()
				local picker = action_state.get_current_picker(prompt_bufnr)
				local multi_selections = picker:get_multi_selection()

				-- Close telescope first
				actions.close(prompt_bufnr)

				-- Jika ada multi selection, delete semua yang dipilih
				if #multi_selections > 0 then
					for _, entry in ipairs(multi_selections) do
						local bufnr = entry.bufnr
						if vim.api.nvim_buf_is_valid(bufnr) then
							pcall(function()
								vim.api.nvim_buf_delete(bufnr, { force = false })
							end)
						end
					end
				else
					-- Jika tidak ada multi selection, delete buffer yang sedang dipilih
					local selected_entry = action_state.get_selected_entry()
					if selected_entry then
						local bufnr = selected_entry.bufnr
						if vim.api.nvim_buf_is_valid(bufnr) then
							pcall(function()
								vim.api.nvim_buf_delete(bufnr, { force = false })
							end)
						end
					end
				end
			end)

			-- Enter: buka buffer normal
			map("n", "<CR>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("buffer " .. selected_entry.bufnr)
			end)

			-- s: horizontal split
			map("n", "s", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright split | buffer " .. selected_entry.bufnr)
			end)

			-- v: vertical split
			map("n", "v", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright vsplit | buffer " .. selected_entry.bufnr)
			end)

			-- Insert mode mappings
			map("i", "<CR>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("buffer " .. selected_entry.bufnr)
			end)

			map("i", "<C-s>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright split | buffer " .. selected_entry.bufnr)
			end)

			map("i", "<C-v>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright vsplit | buffer " .. selected_entry.bufnr)
			end)

			return true
		end,
	})
end

local theme_treesitter = function()
	require("telescope.builtin").treesitter({
		attach_mappings = function(prompt_bufnr, map)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			-- Enter: buka file normal
			map("n", "<CR>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			-- s: horizontal split
			map("n", "s", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright split")
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			-- v: vertical split
			map("n", "v", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright vsplit")
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			-- Insert mode mappings
			map("i", "<CR>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			map("i", "<C-s>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright split")
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			map("i", "<C-v>", function()
				local selected_entry = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("belowright vsplit")
				vim.api.nvim_win_set_cursor(0, { selected_entry.lnum, selected_entry.col })
			end)

			return true
		end,
	})
end

vim.keymap.set("n", "<leader>ff", theme_find_files, { desc = "find files" })
vim.keymap.set("n", "<leader>fg", theme_live_grep, { desc = "live grep" })
vim.keymap.set("n", "<C-s>", theme_find_buffers, { desc = "buffer list" })

--vim.keymap.set("n", "<leader>x", theme_treesitter, { desc = "treesitter list" })
-- mapping neotree key
vim.keymap.set("n", "<Leader>fe", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree (Cmd)", silent = true })

-- Update path tmux pane setiap kali Neovim ganti directory
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	callback = function()
		-- Ambil CWD saat ini
		local cwd = vim.fn.getcwd()
		-- Jalankan command tmux untuk set path pane saat ini (-c)
		vim.fn.system("tmux select-pane -c " .. vim.fn.shellescape(cwd))
	end,
})

-- Menu completion
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = colors.bg2, fg = colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = colors.bg2, fg = colors.yellow })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = colors.yellow, fg = colors.bg0, bold = true })

-- Documentation window
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = colors.bg2, fg = colors.fg })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = colors.bg2, fg = colors.yellow })

vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = colors.bg2, fg = colors.yellow })

-- Label dan description
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { bg = "NONE", fg = colors.fg })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { bg = "NONE", fg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { bg = "NONE", fg = colors.grey1 })

-- Kind highlights (icon colors seperti di gambar)
vim.api.nvim_set_hl(0, "BlinkCmpKind", { bg = "NONE", fg = colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { bg = "NONE", fg = colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { bg = "NONE", fg = colors.orange })
vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { bg = "NONE", fg = colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindField", { bg = "NONE", fg = colors.aqua })
vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { bg = "NONE", fg = colors.red })
vim.api.nvim_set_hl(0, "BlinkCmpKindText", { bg = "NONE", fg = colors.green })

-- Source name (LSP, Buffer, etc)
vim.api.nvim_set_hl(0, "BlinkCmpSource", { bg = "NONE", fg = colors.grey1 })
-- Scrollbar
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = colors.grey1 })
vim.api.nvim_set_hl(0, "BlinkCmpScrollBarGutter", { bg = colors.bg2 })

-- Ghost text
vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = colors.grey0, italic = true })

-- Signature help window (parameter guide)
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = colors.bg2, fg = colors.fg })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "NONE", fg = colors.yellow })

vim.api.nvim_set_hl(0, "FloatBorder", { bg = colors.grey0, fg = colors.yellow })

vim.api.nvim_set_hl(
	0,
	"BlinkCmpSignatureHelpActiveParameter",
	{ background = colors.yellow, fg = colors.bg0, bold = true }
)

-- Trigger untuk set highlight setelah lazy load

-- PASTE KONFIGURASI DIAGNOSTIC DI SINI
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- PASTE KONFIGURASI IKON DI SINI
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
