return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          hidden = true,
          file_ignore_patterns = {
            "^%.git",
          },
          dynamic_preview_title = true, -- show filename in preview title
          results_title = false, -- hide results title
          sorting_strategy = "ascending",
          -- Custom path display: filename first, then path (smaller/dimmed)
          path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            local dir = vim.fn.fnamemodify(path, ":h")
            if dir == "." then
              return tail
            end
            -- Filename bold, path dimmed with smaller appearance
            return string.format("%s  (%s/%s)", tail, dir, tail)
          end,
        },

        extensions = {

          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
        pickers = {

          buffers = {

            layout_strategy = "horizontal",

            previewer = false, -- pastikan preview aktif
            layout_config = {
              width = 0.4,
              height = 0.4,

              prompt_position = "top", -- prompt di atas
              -- height = 0.9,
              --layout_strategyheight = 0.9, -- lebih tinggi
              mirror = false, -- preview di bawah
              -- anchor = "CENTER", -- posisi dari atas (North)
              preview_width = 0.7, -- preview 50% dari tinggi total
              -- results_height = 8, -- hasil search hanya 8 baris (lebih kecil)
            },
            sorting_strategy = "ascending", -- hasil sort dari atas ke bawah
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              -- dd: delete buffer (barbar integration)
              map("n", "dd", function()
                local selected_entry = action_state.get_selected_entry()
                local bufnr = selected_entry.bufnr
                
                -- Close telescope first
                actions.close(prompt_bufnr)
                
                -- Gunakan barbar command untuk close buffer
                vim.cmd("BufferClose " .. bufnr)
              end)

              -- Enter: buka file normal
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
          },
          live_grep = {
            theme = "ivy",
            additional_args = function()
              return { "--hidden" } -- Flag untuk ripgrep
            end,
            file_ignore_patterns = {
              "^%.git",
            },
            hidden = true,
            -- layout_strategy = "horizontal",

            -- layout_config = {
            --
            --   prompt_position = "top",
            --   mirror = false,
            --   preview_width = 0.75,
            --   height = 0.8,
            -- },
            -- Custom display: show matched text first, then path
            entry_maker = function(entry)
              local displayer = require("telescope.pickers.entry_display").create({
                separator = " ",
                items = {
                  { width = 50 }, -- matched text
                  { remaining = true }, -- path and line number
                },
              })

              local make_entry = require("telescope.make_entry")
              local base_entry = make_entry.gen_from_vimgrep({})(entry)

              if not base_entry then
                return nil
              end

              base_entry.display = function(entry_display)
                local filename = require("telescope.utils").path_tail(entry_display.filename)

                local full_path = entry_display.filename or ""
                local text = entry_display.text or ""
                local lnum = entry_display.lnum or ""

                return displayer({
                  text:gsub("^%s+", ""), -- trim leading whitespace
                  { string.format("%s:%s (%s)", filename, lnum, full_path), "TelescopeResultsComment" },
                })
              end

              return base_entry
            end,
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              -- Enter: buka file normal
              map("n", "<CR>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("edit " .. selected_entry.path or selected_entry.filename)
              end)

              -- s: horizontal split
              map("n", "s", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright split " .. (selected_entry.path or selected_entry.filename))
              end)

              -- v: vertical split
              map("n", "v", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. (selected_entry.path or selected_entry.filename))
              end)

              -- Insert mode mappings
              map("i", "<CR>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("edit " .. (selected_entry.path or selected_entry.filename))
              end)

              map("i", "<C-s>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright split " .. (selected_entry.path or selected_entry.filename))
              end)

              map("i", "<C-v>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. (selected_entry.path or selected_entry.filename))
              end)

              return true
            end,
          },
          find_files = {

            file_ignore_patterns = {
              "^%.git",
            },
            hidden = true,
            -- theme = "dropdown",
            layout_strategy = "horizontal",

            previewer = false, -- pastikan preview aktif
            layout_config = {
              width = 0.4,
              height = 0.4,

              prompt_position = "top", -- prompt di atas
              -- height = 0.9,
              --layout_strategyheight = 0.9, -- lebih tinggi
              mirror = false, -- preview di bawah
              -- anchor = "CENTER", -- posisi dari atas (North)
              preview_width = 0.7, -- preview 50% dari tinggi total
              -- results_height = 8, -- hasil search hanya 8 baris (lebih kecil)
            },
            sorting_strategy = "ascending", -- hasil sort dari atas ke bawah
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")

              -- Enter: buka file normal
              map("n", "<CR>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("edit " .. (selected_entry.path or selected_entry[1]))
              end)

              -- s: horizontal split
              map("n", "s", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright split " .. (selected_entry.path or selected_entry[1]))
              end)

              -- v: vertical split
              map("n", "v", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. (selected_entry.path or selected_entry[1]))
              end)

              -- Insert mode mappings
              map("i", "<CR>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("edit " .. (selected_entry.path or selected_entry[1]))
              end)

              map("i", "<C-s>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright split " .. (selected_entry.path or selected_entry[1]))
              end)

              map("i", "<C-v>", function()
                local selected_entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("belowright vsplit " .. (selected_entry.path or selected_entry[1]))
              end)

              return true
            end,
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}
