-- ========================================================
-- PLUGINS.IBL.LUA - Indent Guides Setup
-- ========================================================

local ibl = require("ibl")

ibl.setup({
  indent = {
    char = "│",
    highlight = "IblIndent",
  },
  scope = {
    show_start = false,
    show_end = false,
    highlight = "IblScope",
  },
})

-- -----------------------------
-- Highlight Groups (Nordic-darker-v40)
-- -----------------------------
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3a3e44" })     -- subtle gray
vim.api.nvim_set_hl(0, "IblScope",  { fg = "#88c0d0", bold = true }) -- cyan accent
