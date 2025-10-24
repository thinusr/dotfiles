-- ========================================================
-- PLUGINS.GITSIGNS.LUA - Git Signs Setup
-- ========================================================

require("gitsigns").setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "󰍵" },
    topdelete    = { text = "󰍵" },
    changedelete = { text = "│" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false,
  update_debounce = 200,
  max_file_length = 40000,
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})
