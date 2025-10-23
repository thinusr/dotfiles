-- ========================================================
-- INIT.LUA - NEOVIM CONFIG
-- ========================================================

-- -----------------------------
-- 1. Bootstrap Packer
-- -----------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd [[packadd packer.nvim]]

-- -----------------------------
-- 2. VSCode check
-- -----------------------------
if vim.g.vscode then
    -- VSCode extension mode
else
    -- ordinary Neovim
end

-- -----------------------------
-- 3. Load LuaRocks if available
-- -----------------------------
pcall(require, "luarocks.loader")

-- -----------------------------
-- 4. Core settings
-- -----------------------------
require("core.options")    -- Vim options
require("core.keymaps")    -- Leader keys & general keymaps
require("core.autocmds")   -- Autocommands (e.g., Python autoformat)

-- -----------------------------
-- 5. Plugin management
-- -----------------------------
require("core.plugins")    -- Packer setup & plugin installation

-- -----------------------------
-- 6. Plugin configurations
-- -----------------------------
require("plugins.neotree")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.dap")
require("plugins.autopairs")

-- -----------------------------
-- 7. LSP & Autocompletion
-- -----------------------------
require("core.lsp")        -- Mason, LSP servers, cmp




