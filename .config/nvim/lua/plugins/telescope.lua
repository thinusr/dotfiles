-- ========================================================
-- PLUGINS.TELESCOPE.LUA - Fuzzy Finder Setup
-- ========================================================

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- -----------------------------
-- Keymaps
-- -----------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)

-- -----------------------------
-- Setup
-- -----------------------------
telescope.setup({
  defaults = {
    layout_config = {
      horizontal = { width = 0.9 },
    },
    file_ignore_patterns = { "node_modules", ".git/" },
    mappings = {
      i = {
        ["<C-o>"] = function(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry.path then
            vim.fn.jobstart({ "xdg-open", entry.path }, { detach = true })
          else
            print("No path to open")
          end
        end,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- -----------------------------
-- Extensions
-- -----------------------------
pcall(telescope.load_extension, "fzf")
