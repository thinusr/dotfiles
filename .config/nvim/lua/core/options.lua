-- ========================================================
-- CORE.OPTIONS.LUA - Neovim Settings
-- ========================================================

-- -----------------------------
-- General Settings
-- -----------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable unused language providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- UI & behavior
vim.opt.relativenumber = true
vim.opt.number = true               -- Show absolute line number alongside relative
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard
vim.opt.autochdir = true           -- Auto change directory to current file

-- -----------------------------
-- Indentation
-- -----------------------------
vim.opt.tabstop = 4        -- Display width of a tab character
vim.opt.shiftwidth = 4     -- Indent width when using >> or <<
vim.opt.softtabstop = 4    -- Spaces inserted when pressing <Tab>
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Auto-indent new lines

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
-- Performance & UX
-- -----------------------------
vim.opt.updatetime = 300       -- Faster CursorHold events
vim.opt.timeoutlen = 500       -- Faster mapped key sequences
vim.opt.termguicolors = true   -- Enable true color
vim.opt.scrolloff = 8          -- Keep cursor centered vertically
vim.opt.sidescrolloff = 8      -- Keep cursor centered horizontally
vim.opt.signcolumn = "yes"     -- Always show sign column
vim.opt.splitright = true      -- Vertical splits to the right
vim.opt.splitbelow = true      -- Horizontal splits below
