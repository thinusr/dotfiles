local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ============================
-- Load ASCII logo from file
-- ============================
local logo_path = vim.fn.expand("/home/thinus/dotfiles/.config/nvim/logo.txt")
local logo_file = io.open(logo_path, "r")
local logo_lines = {}

if logo_file then
  for line in logo_file:lines() do
    table.insert(logo_lines, line)
  end
  logo_file:close()
end

dashboard.section.header.val = logo_lines

-- ============================
-- Buttons with section headers
-- ============================
dashboard.section.buttons.val = {
  -- Main Dashboard header (harmless key "h")
  dashboard.button("h", "──────────────────── Main Dashboard ────────────────────", ":echo ''<CR>"),

  -- Main dashboard buttons
  dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("g", "  Live Grep", ":Telescope live_grep<CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("e", "  Open Filetree", ":NvimTreeToggle<CR>"),
  dashboard.button("c", "  New File", ":ene <BAR> startinsert<CR>"),
  dashboard.button("n", "  Open Notebook", ":lua require('telescope.builtin').find_files({cwd = vim.fn.expand('~/Notebook'), hidden = true, follow = true})<CR>"),

  -- Obsidian header (harmless key "v")
  dashboard.button("v", "──────────────────── Obsidian Vault ────────────────────", ":echo ''<CR>"),

  -- Obsidian buttons
  dashboard.button("o", "󱓧  Open Obsidian Vault", ":lua require('telescope.builtin').find_files({cwd = vim.fn.expand('~/Dropbox/Obsidian'), hidden = true, follow = true})<CR>"),
  dashboard.button("s", "󰱼  Search Notes", ":lua require('telescope.builtin').live_grep({cwd = vim.fn.expand('~/Dropbox/Obsidian')})<CR>"),
  dashboard.button("d", "󰃭  Daily Notes", ":lua require('telescope.builtin').find_files({cwd = vim.fn.expand('~/Dropbox/Obsidian/Daily Notes'), hidden = true, follow = true})<CR>"),

  -- Quit
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- ============================
-- Footer
-- ============================
dashboard.section.footer.val = {
  "",
  "Thinus-mode engaged. Your dashboard is now powered by alpha-nvim.",
  "",
}

-- ============================
-- Setup Alpha
-- ============================
alpha.setup(dashboard.config)

