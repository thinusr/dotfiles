-- ========================================================
-- PLUGINS.TREESITTER.LUA - Syntax & Structure Setup
-- ========================================================

local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
  -- -----------------------------
  -- Language Parsers
  -- -----------------------------
  ensure_installed = {
    "bash",
    "lua",
    "python",
    "json",
    "yaml",
    "markdown",
    "toml",
    "html",
    "css",
    "javascript",
    "typescript",
    -- "vim", -- optional: disable to avoid parser errors
  },

  -- -----------------------------
  -- Features
  -- -----------------------------
  highlight = {
    enable = true,
    disable = { "vim" }, -- disables Vim parser to prevent errors
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
  },

  playground = {
    enable = true,
  },
})
