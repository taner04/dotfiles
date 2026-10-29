local o = vim.opt

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.termguicolors = true
o.showmode = false        -- lualine shows the mode
o.laststatus = 3          -- one statusline for all splits
o.cmdheight = 1
o.scrolloff = 8
o.wrap = false
o.fillchars = { eob = " ", vert = "│" }

o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.splitright = true
o.splitbelow = true

o.clipboard = "unnamedplus"   -- share clipboard with macOS
o.mouse = "a"
o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 400

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})
