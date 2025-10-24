-- ========================================================
-- INIT.LUA - NEOVIM CONFIG
-- ========================================================

-- -----------------------------
-- 0. LuaRocks Path Setup
-- -----------------------------
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.luarocks/share/lua/5.1/?.lua;" .. home .. "/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";" .. home .. "/.luarocks/lib/lua/5.1/?.so"

-- Optional: preload jsregexp to silence LuaSnip health warning
pcall(require, "jsregexp")

-- -----------------------------
-- 1. Bootstrap Packer
-- -----------------------------
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end
vim.cmd("packadd packer.nvim")

-- -----------------------------
-- 2. VSCode Check
-- -----------------------------
if vim.g.vscode then
  return -- Exit early if running inside VSCode
end

-- -----------------------------
-- 3. Plugin Management
-- -----------------------------
require("core.plugins") -- Packer setup & plugin installation

-- -----------------------------
-- 4. Core Settings
-- -----------------------------
require("core.options")   -- Vim options
require("core.keymaps")   -- Leader keys & general keymaps
require("core.autocmds")  -- Autocommands (e.g., Python autoformat)

-- -----------------------------
-- 5. Plugin Configurations
-- -----------------------------
require("plugins.neotree")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.dap")
require("plugins.autopairs")
require("plugins.ibl")

-- -----------------------------
-- 6. LSP & Autocompletion
-- -----------------------------
require("core.lsp") -- Mason, LSP servers, cmp

-- -----------------------------
-- 7. Colorscheme
-- -----------------------------
vim.cmd("colorscheme nord")
