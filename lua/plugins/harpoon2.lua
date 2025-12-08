return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- Setup Harpoon dengan konfigurasi custom
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    -- ========================================
    -- GRUVBOX COLOR SCHEME
    -- ========================================
    local colors = {
      bg0 = "#1d2021",
      bg1 = "#282828",
      bg2 = "#32302f",
      fg = "#d4be98",
      red = "#F9B529",
      orange = "#e78a4e",
      yellow = "#d8a657",
      green = "#a9b665",
      aqua = "#89b482",
      blue = "#7daea3",
      purple = "#d3869b",
      grey0 = "#7c6f64",
      grey1 = "#928374",
      grey2 = "#a89984",
    }

    -- Set Harpoon colors
    vim.api.nvim_set_hl(0, "HarpoonWindow", { bg = colors.bg0, fg = colors.fg })
    vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = colors.orange, bg = colors.bg0 })
    vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = colors.red, bg = colors.bg0, bold = true })

    -- Normal mode highlight
    vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = colors.red, bg = colors.bg0, bold = true })
    vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = colors.grey1, bg = colors.bg0 })

    -- File path colors
    vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = colors.grey2, bg = colors.bg0 })
    vim.api.nvim_set_hl(0, "HarpoonActive", { fg = colors.fg, bg = colors.bg0, bold = true })

    -- Additional highlights for better visibility
    vim.api.nvim_set_hl(0, "HarpoonCurrent", { fg = colors.red, bg = colors.bg2, bold = true })
    -- ========================================
    -- TELESCOPE IVY INTEGRATION
    -- ========================================

    local function toggle_telescope_ivy()
      local harpoon_files = harpoon:list()
      local file_paths = {}

      -- Buat entry dengan index
      for idx, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, {
          index = idx,
          value = item.value,
          display = string.format("[%d] %s", idx, item.value),
        })
      end

      require("telescope.pickers")
        .new(
          require("telescope.themes").get_ivy({
            layout_config = {
              height = 0.4,
            },
            initial_mode = "normal",
          }),
          {
            prompt_title = "🎯 Harpoon Files",
            finder = require("telescope.finders").new_table({
              results = file_paths,
              entry_maker = function(entry)
                return {
                  value = entry.value,
                  display = entry.display,
                  ordinal = entry.value,
                  index = entry.index,
                }
              end,
            }),
            previewer = require("telescope.config").values.file_previewer({}),
            sorter = require("telescope.config").values.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              -- NORMAL MODE mappings
              -- Enter: buka file normal
              map("n", "<CR>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("edit " .. selected_entry.value)
              end)

              -- s: horizontal split
              map("n", "s", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("belowright split " .. selected_entry.value)
              end)

              -- v: vertical split
              map("n", "v", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. selected_entry.value)
              end)

              -- d: hapus dari list
              map("n", "d", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                -- Hapus dari harpoon
                local idx = selected_entry.index
                harpoon_files:remove_at(idx)
                vim.notify("Removed: " .. selected_entry.value, vim.log.levels.WARN)

                -- Refresh picker
                local updated_files = {}
                for i, item in ipairs(harpoon:list().items) do
                  table.insert(updated_files, {
                    index = i,
                    value = item.value,
                    display = string.format("[%d] %s", i, item.value),
                  })
                end

                current_picker:refresh(require("telescope.finders").new_table({
                  results = updated_files,
                  entry_maker = function(entry)
                    return {
                      value = entry.value,
                      display = entry.display,
                      ordinal = entry.value,
                      index = entry.index,
                    }
                  end,
                }))
              end)

              -- INSERT MODE mappings (jika user tekan i)
              map("i", "<CR>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("edit " .. selected_entry.value)
              end)

              map("i", "<C-f>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)

                vim.cmd("belowright split " .. selected_entry.value)
              end)

              map("i", "<C-v>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                require("telescope.actions").close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. selected_entry.value)
              end)

              map("i", "<C-d>", function()
                local state = require("telescope.actions.state")
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(prompt_bufnr)

                -- Hapus berdasarkan index
                local idx = selected_entry.index
                harpoon_files:remove_at(idx)
                vim.notify("Removed: " .. selected_entry.value, vim.log.levels.WARN)

                local updated_files = {}

                for i, item in ipairs(harpoon:list().items) do
                  table.insert(updated_files, {
                    index = i,
                    value = item.value,
                    display = string.format("[%d] %s", i, item.value),
                  })
                end

                current_picker:refresh(require("telescope.finders").new_table({
                  results = updated_files,
                  entry_maker = function(entry)
                    return {
                      value = entry.value,
                      display = entry.display,
                      ordinal = entry.value,
                      index = entry.index,
                    }
                  end,
                }))
              end)

              return true
            end,
          }
        )
        :find()
    end

    -- ========================================
    -- BASIC OPERATIONS
    -- ========================================

    -- Add file ke harpoon list
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
      vim.notify("Added to Harpoon", vim.log.levels.INFO)
    end, { desc = "Harpoon: Add file" })

    -- ========================================
    -- TELESCOPE IVY MENU (Ctrl+E)
    -- ========================================

    -- Toggle Telescope Ivy
    vim.keymap.set("n", "<C-e>", toggle_telescope_ivy, { desc = "Harpoon: Telescope Ivy" })

    -- ========================================
    -- FILE MANAGEMENT
    -- ========================================

    -- Hapus file saat ini dari harpoon
    vim.keymap.set("n", "<leader>hr", function()
      local current_file = vim.fn.expand("%:p")
      local list = harpoon:list()

      for i, item in ipairs(list.items) do
        if item.value == current_file then
          list:remove_at(i)
          vim.notify("Removed from Harpoon", vim.log.levels.WARN)
          return
        end
      end

      vim.notify("File not in Harpoon list", vim.log.levels.ERROR)
    end, { desc = "Harpoon: Remove current file" })

    -- Clear semua harpoon list
    vim.keymap.set("n", "<leader>hc", function()
      harpoon:list():clear()
      vim.notify("Harpoon list cleared", vim.log.levels.WARN)
    end, { desc = "Harpoon: Clear all" })

    -- ========================================
    -- QUICK SELECT (1-4)
    -- ========================================

    -- Menggunakan angka langsung untuk quick select
    vim.keymap.set("n", " 1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon: Select 1" })

    vim.keymap.set("n", " 2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon: Select 2" })

    vim.keymap.set("n", " 3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon: Select 3" })

    vim.keymap.set("n", " 4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon: Select 4" })

    -- ========================================
    -- NAVIGATION
    -- ========================================

    -- Previous & Next dalam harpoon list
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end, { desc = "Harpoon: Previous" })

    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end, { desc = "Harpoon: Next" })

    -- ========================================
    -- HARPOON MENU BAWAAN (Ctrl+S)
    -- ========================================

    -- Toggle Harpoon menu bawaan
    vim.keymap.set("n", "<C-f>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = "rounded",
        title_pos = "center",
        ui_width_ratio = 0.4,
      })
    end, { desc = "Harpoon: Toggle native menu" })

    -- Custom keymaps untuk Harpoon menu bawaan
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- s: horizontal split (bawah)
        vim.keymap.set("n", "s", function()
          local line = vim.api.nvim_get_current_line()
          local file_path = line:match("^%d+%s+(.+)$") or line
          if file_path and file_path ~= "" then
            vim.cmd("close")
            vim.cmd("belowright split " .. file_path)
          end
        end, { buffer = bufnr, desc = "Open in horizontal split" })

        -- v: vertical split (kanan)
        vim.keymap.set("n", "v", function()
          local line = vim.api.nvim_get_current_line()
          local file_path = line:match("^%d+%s+(.+)$") or line
          if file_path and file_path ~= "" then
            vim.cmd("close")
            vim.cmd("belowright vsplit " .. file_path)
          end
        end, { buffer = bufnr, desc = "Open in vertical split" })

        -- dd: hapus file dari list
        vim.keymap.set("n", "dd", function()
          local line_num = vim.fn.line(".")
          harpoon:list():remove_at(line_num)
          vim.cmd("close")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { buffer = bufnr, desc = "Remove from Harpoon" })
      end,
    })
  end,
}
