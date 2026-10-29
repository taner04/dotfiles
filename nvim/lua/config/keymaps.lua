local map = vim.keymap.set

-- Basics
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Move between splits with Ctrl + h/j/k/l
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move selected lines up/down
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Run the current script (sh, zsh, bash, python, lua, node) in a split terminal
map("n", "<leader>r", function()
  vim.cmd("w")
  local runners = {
    sh = "sh", zsh = "zsh", bash = "bash",
    python = "python3", lua = "lua", javascript = "node",
  }
  local cmd = runners[vim.bo.filetype]
  if not cmd then
    vim.notify("No runner for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
    return
  end
  vim.cmd("botright 12split | terminal " .. cmd .. " " .. vim.fn.shellescape(vim.fn.expand("%:p")))
end, { desc = "Run current script" })

-- Leave terminal mode with Esc
map("t", "<Esc>", [[<C-\><C-n>]])
