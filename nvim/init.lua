-- Leader must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")

vim.cmd.colorscheme("koda")

-- Re-apply koda when the terminal switches between light and dark
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == "koda" then vim.cmd.colorscheme("koda") end
  end,
})
