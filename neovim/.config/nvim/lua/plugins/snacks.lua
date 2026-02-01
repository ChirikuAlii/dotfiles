local function create_ivy_layout(opts)
  opts = opts or {}
  return {
    ivy = {
      layout = {
        box = "vertical",
        backdrop = false,
        row = -1,
        width = 0,
        height = opts.height or 0.55,
        border = "top",
        title = opts.title or "{title} {live} ",
        title_pos = "left",
        { win = "input", height = 1, border = "bottom" },
        {
          box = "horizontal",
          { win = "list",    border = "none" },
          { win = "preview", title = "{preview}", width = 0.6, border = "left" },
        },
      },
    }
  }
end

local function simple_ivy_layout(opts)
  opts = opts or {}
  opts.title = opts.title
  opts.height = opts.height or 0.55
  opts.layouts = create_ivy_layout({ title = opts.title, height = opts.height }) or {}

  return opts
end


local function grep()
  return {
    finder = "grep",
    regex = true,
    format = "file",
    show_empty = true,
    hidden = true,
    live = true, -- live grep by default
    supports_live = true,
    layouts = create_ivy_layout({ height = 0.55, title = " Live grep " }),
  }
end

local function files()
  return {
    finder = "files",
    format = "file",
    show_empty = true,
    hidden = true,
    ignored = false,
    follow = false,
    supports_live = true,
    layouts = create_ivy_layout({ height = 0.55, title = " Find files {live} " }),
    win = {
      input = {
        keys = {
          ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
        }
      },

      list = {
        keys = {
          ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
        }
      }
    }
  }
end

local function buffers()
  return {
    finder = "buffers",
    format = "buffer",
    hidden = false,
    unloaded = true,
    current = true,
    sort_lastused = true,
    layouts = create_ivy_layout({ height = 0.45, title = " Find Buffers {live} " }),
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "bufdelete", mode = { "n", "i" } },
        },
      },
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  }
end

local function recent_files()
  return {

    finder = "recent_files",
    format = "file",
    filter = {
      paths = {
        [vim.fn.stdpath("data")] = false,
        [vim.fn.stdpath("cache")] = false,
        [vim.fn.stdpath("state")] = false,
      },
    },
    hidden = true,
    layouts = create_ivy_layout({ height = 0.45, title = " Find Recent Files {live} " }),
  }
end

local function zoxide()
  return {
    finder = "files_zoxide",
    format = "file",
    confirm = "load_session",
    win = {
      preview = {
        minimal = true,
      },
    },
    layouts = create_ivy_layout({ height = 0.55, title = "Find Files Use Zoxide" })
  }
end
local function git_files()
  return {
    finder = "git_files",
    show_empty = true,
    format = "file",
    untracked = false,
    submodules = false,
    layouts = create_ivy_layout({ height = 0.55, title = "Find Files already in source control" })
  }
end
local function git_branches()
  return {
    all = false,
    finder = "git_branches",
    format = "git_branch",
    preview = "git_log",
    confirm = "git_checkout",
    win = {
      input = {
        keys = {
          ["<c-a>"] = { "git_branch_add", mode = { "n", "i" } },
          ["<c-x>"] = { "git_branch_del", mode = { "n", "i" } },
        },
      },
    },
    ---@param picker snacks.Picker
    on_show = function(picker)
      for i, item in ipairs(picker:items()) do
        if item.current then
          picker.list:view(i)
          Snacks.picker.actions.list_scroll_center(picker)
          break
        end
      end
    end,
    layouts = create_ivy_layout({ height = 0.55, title = "Git Branches" })
  }
end

local function git_log()
  return {
    finder = "git_log",
    format = "git_log",
    preview = "git_show",
    confirm = "git_checkout",
    supports_live = true,
    sort = { fields = { "score:desc", "idx" } },
    layouts = create_ivy_layout({ height = 0.55, title = "Git Log Commit" })
  }
end

local function git_log_file()
  return {
    finder = "git_log",
    format = "git_log",
    preview = "git_show",
    current_file = true,
    follow = true,
    confirm = "git_checkout",
    sort = { fields = { "score:desc", "idx" } },
    layouts = create_ivy_layout({ height = 0.55, title = "Git Log Commit Current Open File/Buffer" })
  }
end

local function git_log_line()
  return {
    finder = "git_log",
    format = "git_log",
    preview = "git_show",
    current_line = true,
    follow = true,
    confirm = "git_checkout",
    sort = { fields = { "score:desc", "idx" } },
    layouts = create_ivy_layout({ height = 0.55, title = "Git Log Commit Selected Line" })
  }
end

local function git_status()
  return {
    finder = "git_status",
    format = "git_status",
    preview = "git_status",
    win = {
      input = {
        keys = {
          ["<Tab>"] = { "git_stage", mode = { "n", "i" } },
          ["<c-r>"] = { "git_restore", mode = { "n", "i" }, nowait = true },

          ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },

        },
      },
      list = {
        keys = {
          ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
        }
      }
    },
    layouts = create_ivy_layout({ height = 0.55, title = "Git Status" })
  }
end

local function git_stash()
  return {
    finder = "git_stash",
    format = "git_stash",
    preview = "git_stash",
    confirm = "git_stash_apply",
    layouts = create_ivy_layout({ height = 0.55, title = "Git Stash" })
  }
end

local function git_diff()
  return {
    group = false,
    finder = "git_diff",
    format = "git_status",
    preview = "diff",
    matcher = { sort_empty = true },
    sort = { fields = { "score:desc", "file", "idx" } },
    win = {
      input = {
        keys = {
          ["<Tab>"] = { "git_stage", mode = { "n", "i" } },
          ["<c-r>"] = { "git_restore", mode = { "n", "i" }, nowait = true },
        },
      },
    },
    layouts = create_ivy_layout({ height = 0.55, title = "Git Diff (Hunks)" })
  }
end

local function lines()
  return {
    finder = "lines",
    format = "lines",
    jump = { match = true },
    -- allow any window to be used as the main window
    main = { current = false },
    ---@param picker snacks.Picker
    -- on_show = function(picker)
    --   local cursor = vim.api.nvim_win_get_cursor(picker.main)
    --   local info = vim.api.nvim_win_call(picker.main, vim.fn.winsaveview)
    --   picker.list:view(cursor[1], info.topline)
    --   picker:show_preview()
    -- end,
    sort = { fields = { "score:desc", "idx" } },
    layout = create_ivy_layout({ height = 0.55, title = "Grep Current Open File/Buffer" })
  }
end
local function grep_buffers()
  return {
    finder = "grep",
    format = "file",
    live = true,
    buffers = true,
    need_search = false,
    supports_live = true,
    layouts = create_ivy_layout({ height = 0.55, title = "Grep Open Buffers" })
  }
end

local function grep_word()
  return {
    finder = "grep",
    regex = false,
    args = { "--word-regexp" },
    format = "file",
    search = function(picker)
      return picker:word()
    end,
    live = false,
    supports_live = true,
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function registers()
  return {
    finder = "vim_registers",
    main = { current = true },
    format = "register",
    preview = "preview",
    confirm = { "copy", "close" },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function jumps()
  return {
    finder = "vim_jumps",
    format = "file",
    main = { current = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function qflist()
  return {
    finder = "qf",
    format = "file",
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function loclist()
  return {
    finder = "qf",
    format = "file",
    qf_win = 0,
    main = { current = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function search_history()
  return {
    finder = "vim_history",
    name = "search",
    format = "text",
    preview = "none",
    main = { current = true },
    layout = { preset = "vscode" },
    confirm = "search",
    formatters = { text = { ft = "regex" } },
    layouts = create_ivy_layout({ height = 0.55 })

  }
end

local function undo()
  return {
    finder = "vim_undo",
    format = "undo",
    preview = "diff",
    confirm = "item_action",
    win = {
      preview = { wo = { number = false, relativenumber = false, signcolumn = "no" } },
      input = {
        keys = {
          ["<c-y>"] = { "yank_add", mode = { "n", "i" } },
          ["<c-s-y>"] = { "yank_del", mode = { "n", "i" } },
        },
      },
    },
    actions = {
      yank_add = { action = "yank", field = "added_lines" },
      yank_del = { action = "yank", field = "removed_lines" },
    },
    icons = { tree = { last = "┌╴" } }, -- the tree is upside down
    diff = {
      ctxlen = 4,
      ignore_cr_at_eol = true,
      ignore_whitespace_change_at_eol = true,
      indent_heuristic = true,
    },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function command_history()
  return {
    finder = "vim_history",
    name = "cmd",
    format = "text",
    preview = "none",
    main = { current = true },
    layout = {
      preset = "vscode",
    },
    confirm = "cmd",
    formatters = { text = { ft = "vim" } },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function diagnostics()
  return {
    finder = "diagnostics",
    format = "diagnostic",
    sort = {
      fields = {
        "is_current",
        "is_cwd",
        "severity",
        "file",
        "lnum",
      },
    },
    matcher = { sort_empty = true },
    -- only show diagnostics from the cwd by default
    filter = { cwd = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function diagnostics_buffer()
  return {
    finder = "diagnostics",
    format = "diagnostic",
    sort = {
      fields = { "severity", "file", "lnum" },
    },
    matcher = { sort_empty = true },
    filter = { buf = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function marks()
  return {
    finder = "vim_marks",
    format = "file",
    global = true,
    ["local"] = true,
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "mark_delete", mode = { "n", "i" } },
        },
      },
    },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function help()
  return {
    finder = "help",
    format = "text",
    previewers = {
      file = { ft = "help" },
    },
    win = { preview = { minimal = true } },
    confirm = "help",
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function man()
  return {
    finder = "system_man",
    format = "man",
    preview = "man",
    confirm = function(picker, item, action)
      ---@cast action snacks.picker.jump.Action
      picker:close()
      if item then
        vim.schedule(function()
          local cmd = "Man " .. item.ref ---@type string
          if action.cmd == "vsplit" then
            cmd = "vert " .. cmd
          elseif action.cmd == "tab" then
            cmd = "tab " .. cmd
          end
          vim.cmd(cmd)
        end)
      end
    end,
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function commands()
  return {
    finder = "vim_commands",
    format = "command",
    preview = "preview",
    confirm = "cmd",
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function keymaps()
  return {
    finder = "vim_keymaps",
    format = "keymap",
    preview = "preview",
    global = true,
    plugs = false,
    ["local"] = true,
    modes = { "n", "v", "x", "s", "o", "i", "c", "t" },
    ---@param picker snacks.Picker
    confirm = function(picker, item)
      picker:norm(function()
        if item then
          picker:close()
          vim.api.nvim_input(item.item.lhs)
        end
      end)
    end,
    actions = {
      toggle_global = function(picker)
        picker.opts.global = not picker.opts.global
        picker:find()
      end,
      toggle_buffer = function(picker)
        picker.opts["local"] = not picker.opts["local"]
        picker:find()
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-g>"] = { "toggle_global", mode = { "n", "i" }, desc = "Toggle Global Keymaps" },
          ["<a-b>"] = { "toggle_buffer", mode = { "n", "i" }, desc = "Toggle Buffer Keymaps" },
        },
      },
    },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function pickers()
  return {
    finder = "meta_pickers",
    format = "text",
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.schedule(function()
          Snacks.picker(item.text)
        end)
      end
    end,
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_definitions()
  return {
    finder = "lsp_definitions",
    format = "file",
    include_current = false,
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_declarations()
  return {
    finder = "lsp_declarations",
    format = "file",
    include_current = false,
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_references()
  return {
    finder = "lsp_references",
    format = "file",
    include_declaration = true,
    include_current = false,
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_implementations()
  return {
    finder = "lsp_implementations",
    format = "file",
    include_current = false,
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_type_definitions()
  return {
    finder = "lsp_type_definitions",
    format = "file",
    include_current = false,
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_incoming_calls()
  return {
    finder = "lsp_incoming_calls",
    format = "lsp_symbol",
    include_current = false,
    workspace = true, -- this ensures the file is included in the formatter
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_outgoing_calls()
  return {
    finder = "lsp_outgoing_calls",
    format = "lsp_symbol",
    include_current = false,
    workspace = true, -- this ensures the file is included in the formatter
    auto_confirm = true,
    jump = { tagstack = true, reuse_win = true },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_symbols()
  return {
    finder = "lsp_symbols",
    format = "lsp_symbol",
    tree = true,
    filter = {
      default = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
      },
      -- set to `true` to include all symbols
      markdown = true,
      help = true,
      -- you can specify a different filter for each filetype
      lua = {
        "Class",
        "Constructor",
        "Enum",
        "Field",
        "Function",
        "Interface",
        "Method",
        "Module",
        "Namespace",
        -- "Package", -- remove package since luals uses it for control flow structures
        "Property",
        "Struct",
        "Trait",
      },
    },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end

local function lsp_workspace_symbols()
  return {

  }
end

local function treesitter()
  return {
    finder = "treesitter_symbols",
    format = "lsp_symbol",
    tree = true,
    filter = {
      default = {
        "Class",
        "Enum",
        "Field",
        "Function",
        "Method",
        "Module",
        "Namespace",
        "Struct",
        "Trait",
      },
      -- set to `true` to include all symbols
      markdown = true,
      help = true,
    },
    layouts = create_ivy_layout({ height = 0.55 })
  }
end




return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("snacks").setup({
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      indent = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
>>===============================================================<<
||                                                               ||
||      ___       _ _     ____            _                      ||
||     |_ _|_ __ (_) |_  / ___| _   _ ___| |_ ___ _ __ ___       ||
||      | || '_ \| | __| \___ \| | | / __| __/ _ \ '_ ` _ \      ||
||      | || | | | | |_   ___) | |_| \__ \ ||  __/ | | | | |     ||
||     |___|_| |_|_|\__| |____/ \__, |___/\__\___|_| |_| |_|     ||
||                              |___/                            ||
||                                                               ||
>>===============================================================<<

          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":Neotree toggle" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua require('telescope.builtin').live_grep()",
            },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      picker = {
        layout = {
          preset = "ivy",
          -- When reaching the bottom of the results in the picker, I don't want
          -- it to cycle and go back to the top
          cycle = false,
        },

      },
      win = {
        input = {
          keys = {
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
          }
        },

        list = {
          keys = {
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
          }
        }
      }
    })
  end,

  keys = {
    -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- FILES --
    {
      "<leader>fg",
      function()
        Snacks.picker.grep(grep())
      end,
      desc = "Live Grep"
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files(files())
      end,
      desc = "Files"
    },
    {
      "<leader>fs",
      function()
        Snacks.picker.buffers(buffers())
      end,
      desc = "Buffers"
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent(recent_files())
      end,
      desc = "Find Recent Files"
    },

    { "<leader>fz", function() Snacks.picker.zoxide(simple_ivy_layout({ title = "Find Files use zoxide" })) end, desc = "Find Files use zoxide" },

    { "<leader>fl", function() Snacks.picker.git_files(simple_ivy_layout({ title = "Find Git Files" })) end,     desc = "Find File already in Git/Source Control" },

    -- GIT --
    { "<leader>gb", function() Snacks.picker.git_branches(git_branches()) end,                                   desc = "Git Branches" },
    { "<leader>gc", function() Snacks.picker.git_log(git_log()) end,                                             desc = "Git Log Commit" },
    { "<leader>gf", function() Snacks.picker.git_log_file(git_log_file()) end,                                   desc = "Git Log Commit Current Open File/Buffer" },
    { "<leader>gl", function() Snacks.picker.git_log_line(git_log_line()) end,                                   desc = "Git Log Commit Selected Line" },
    { "<leader>gs", function() Snacks.picker.git_status(git_status()) end,                                       desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash(git_stash()) end,                                         desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff(simple_ivy_layout({ height = 0.7 })) end,                  desc = "Git Diff (Hunks)" },

    -- Grep --
    { "<leader>sb", function() Snacks.picker.lines(lines()) end,                                                 desc = "Grep Current Open File/Buffer" },
    { "<leader>sB", function() Snacks.picker.grep_buffers(grep_buffers()) end,                                   desc = "Grep Open Buffers" },
    {
      "<leader>sw",
      function() Snacks.picker.grep_word(grep_word()) end,
      desc = "Visual selection or word",
      mode = { "n", "x" }
    },

    --vim v
    -- list vim core feature
    { '<leader>sj',  function() Snacks.picker.registers(registers()) end,                       desc = "Registers" },
    { "<leader>sd",  function() Snacks.picker.jumps(jumps()) end,                               desc = "Jumps" },
    { "<leader>sa",  function() Snacks.picker.qflist(qflist()) end,                             desc = "Quickfix List" },
    { "<leader>sl",  function() Snacks.picker.loclist(loclist()) end,                           desc = "Location List" },

    { '<leader>s/',  function() Snacks.picker.search_history(search_history()) end,             desc = "Search History" },
    { "<leader>su",  function() Snacks.picker.undo(undo()) end,                                 desc = "Undo History" },
    { "<leader>sc",  function() Snacks.picker.command_history(command_history()) end,           desc = "Command History" },

    { "<leader>sq",  function() Snacks.picker.diagnostics(diagnostics()) end,                   desc = "Diagnostics" },
    { "<leader>sQ",  function() Snacks.picker.diagnostics_buffer(diagnostics_buffer()) end,     desc = "Buffer Diagnostics" },
    { "<leader>sm",  function() Snacks.picker.marks(marks()) end,                               desc = "Marks" },

    -- Vim Documentation and Man Pages
    { "<leader>sH",  function() Snacks.picker.help(help()) end,                                 desc = "Help Pages" },
    { "<leader>sM",  function() Snacks.picker.man(man()) end,                                   desc = "Man Pages" },
    { "<leader>sC",  function() Snacks.picker.commands(commands()) end,                         desc = "Commands" },
    { "<leader>sk",  function() Snacks.picker.keymaps(keymaps()) end,                           desc = "Keymaps" },


    { "<leader>sp",  function() Snacks.picker.pickers() end,                                    desc = "See All Pickers" },

    -- lsp l
    { "<leader>ld",  function() Snacks.picker.lsp_definitions(lsp_declarations()) end,          desc = "Goto Definition" },
    { "<leader>lD",  function() Snacks.picker.lsp_declarations(lsp_declarations()) end,         desc = "Goto Declaration" },
    { "<leader>lr",  function() Snacks.picker.lsp_references(lsp_references()) end,             nowait = true,                  desc = "References" },
    { "<leader>lI",  function() Snacks.picker.lsp_implementations(lsp_implementations()) end,   desc = "Goto Implementation" },
    { "<leader>ly",  function() Snacks.picker.lsp_type_definitions(lsp_type_definitions()) end, desc = "Goto T[y]pe Definition" },
    { "<leader>lai", function() Snacks.picker.lsp_incoming_calls(lsp_incoming_calls()) end,     desc = "C[a]lls Incoming" },
    { "<leader>lao", function() Snacks.picker.lsp_outgoing_calls(lsp_outgoing_calls()) end,     desc = "C[a]lls Outgoing" },
    { "<leader>ls",  function() Snacks.picker.lsp_symbols(lsp_symbols()) end,                   desc = "LSP Symbols" },
    { "<leader>lw",  function() Snacks.picker.lsp_workspace_symbols() end,                      desc = "LSP Workspace Symbols" },
    { "<leader>lt",  function() Snacks.picker.treesitter(treesitter()) end,                     desc = "LSP Workspace Symbols" },

    { "<leader>ds",  function() Snacks.dashboard() end,                                         desc = "Dashboard" },
  }
}
