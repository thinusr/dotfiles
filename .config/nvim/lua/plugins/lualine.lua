
-- ========================================================
-- PLUGINS.LUALINE.LUA - Statusline Setup
-- ========================================================

local lualine = require("lualine")

-- -----------------------------
-- Setup
-- -----------------------------
lualine.setup({
  options = {
    theme = "nord",
    section_separators = { "", "" },
    component_separators = { "|", "|" },
    globalstatus = true, -- optional: enables single statusline across splits
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      function() return os.date("%H:%M") end,
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
})

-- -----------------------------
-- Transparent Background
-- -----------------------------
vim.api.nvim_set_hl(0, "StatusLine",   { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE" })

