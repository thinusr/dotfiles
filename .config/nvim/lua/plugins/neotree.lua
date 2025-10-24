-- ========================================================
-- PLUGINS.NEOTREE.LUA - File Explorer Setup (NvimTree)
-- ========================================================

local tree = require("nvim-tree")

-- -----------------------------
-- Setup
-- -----------------------------
tree.setup({
  view = {
    side = "left",
    width = 30,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})

-- -----------------------------
-- Keymap
-- -----------------------------
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
