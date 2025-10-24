-- -----------------------------
-- Treesitter
-- -----------------------------
require('nvim-treesitter.configs').setup {
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
    -- "vim",  -- optional: remove to avoid errors
  },
  highlight = {
    enable = true,
    disable = { "vim" },  -- disables Vim parser to prevent errors
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = { enable = true },
  playground = { enable = true },
}


