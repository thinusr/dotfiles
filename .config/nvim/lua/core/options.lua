-- -----------------------------
-- General Settings
-- -----------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autochdir = true

-- -----------------------------
-- Transparent Background
-- -----------------------------
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE
  highlight VertSplit guibg=NONE
  highlight EndOfBuffer guibg=NONE
]]

-- -----------------------------
-- Colorscheme
-- -----------------------------
vim.cmd [[colorscheme nord]]
