return {
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local function koda_theme()
        local c = package.loaded["koda.palette"] or {}
        local light = vim.o.background == "light"
        local bg     = c.bg_hl or (light and "#e2e2e2" or "#1a1a1a")
        local bg2    = c.bg_alt or (light and "#e8e8e8" or "#141414")
        local fg     = c.fg or "#a6a6a6"
        local dim    = c.g4 or "#707070"
        local bright = c.fg3 or "#d0d0d0"
        local section = function(a_fg)
          return {
            a = { fg = a_fg, bg = bg, gui = "bold" },
            b = { fg = dim, bg = bg2 },
            c = { fg = fg, bg = bg2 },
          }
        end
        return {
          normal   = section(fg),
          insert   = section(bright),
          visual   = section(bright),
          replace  = section(c.red or "#b07a7a"),
          command  = section(bright),
          terminal = section(fg),
          inactive = section(dim),
        }
      end
      local theme = koda_theme()

      require("lualine").setup({
        options = {
          theme = theme,
          globalstatus = true,
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = {} },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = { { "filename", path = 1, symbols = { modified = "[+]", readonly = "[-]" } } },
          lualine_x = { "diagnostics", { "filetype", colored = false } },
          lualine_y = { "progress" },
          lualine_z = { { function() return os.date("%H:%M") end } },
        },
      })

      -- Rebuild colors when switching light/dark
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          require("lualine").setup({ options = { theme = koda_theme() } })
        end,
      })
    end,
  },

  -- Start screen
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
      }

      local button = function(key, label, cmd, shown_key)
        local b = dashboard.button(key, label, cmd)
        b.opts.shortcut = shown_key or key
        b.opts.hl = "AlphaButtons"
        b.opts.hl_shortcut = "AlphaShortcut"
        return b
      end

      dashboard.section.buttons.val = {
        button("e", "  > New File", "<cmd>ene<cr>"),
        button("f", "  > Find file", "<cmd>Telescope find_files<cr>"),
        button("r", "  > Recent files", "<cmd>Telescope oldfiles<cr>"),
        button("<C-n>", "  > Toggle file explorer", "<cmd>NvimTreeToggle<cr>", "CTRL N"),
        button("SPC fw", "  > Find Word", "<cmd>Telescope live_grep<cr>"),
        button("c", "  > Config", "<cmd>e $MYVIMRC | cd %:p:h<cr>"),
        button("q", "  > Quit NVIM", "<cmd>qa<cr>"),
      }

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.config.layout = {
        { type = "padding", val = 6 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      -- Footer with plugin count and startup time
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        once = true,
        callback = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime + 0.5)
          dashboard.section.footer.val = stats.loaded .. " plugins  ·  " .. ms .. " ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- Thin indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
      exclude = { filetypes = { "alpha", "NvimTree", "lazy", "help" } },
    },
  },

  -- Shows pending keybinds after pressing <leader>
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      win = { border = "single" },
      icons = { mappings = false },
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
      },
    },
  },
}
