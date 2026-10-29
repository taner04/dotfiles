return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>",  desc = "Find word" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Recent files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top", width = 0.85, height = 0.8, preview_width = 0.55 },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        file_ignore_patterns = { "%.git/", "node_modules/", "bin/", "obj/" },
      },
    },
  },

  -- File explorer (Ctrl + n)
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Reveal file in explorer" },
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      view = { width = 32 },
      renderer = {
        root_folder_label = ":~:s?$?/..?",
        indent_markers = { enable = true },
        icons = { git_placement = "after" },
      },
      filters = { dotfiles = false, custom = { "^.git$", ".DS_Store" } },
      actions = { open_file = { quit_on_open = false } },
    },
  },

  -- Better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "lua", "vim", "vimdoc", "python", "json", "yaml", "toml",
          "markdown", "markdown_inline", "c", "cpp", "c_sharp", "javascript",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Git changes in the sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" }, change = { text = "│" }, delete = { text = "_" },
        topdelete = { text = "‾" }, changedelete = { text = "~" }, untracked = { text = "┆" },
      },
    },
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview change" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>",   desc = "Blame line" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",   desc = "Reset change" },
    },
  },

  -- Auto-close brackets and quotes
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Surround: ys, cs, ds (e.g. cs"' changes "x" to 'x')
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
}
