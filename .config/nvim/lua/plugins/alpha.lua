local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ============================
-- Load ASCII logo from file
-- ============================
local logo_path = vim.fn.expand("/home/thinus/dotfiles/.config/nvim/logo.txt")  -- <- your logo file
local logo_file = io.open(logo_path, "r")
local logo_lines = {}

if logo_file then
  for line in logo_file:lines() do
    table.insert(logo_lines, line)
  end
  logo_file:close()
end

dashboard.section.header.val = logo_lines  -- <- sets the logo

-- ============================
-- Dashboard buttons
-- ============================
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("g", "  Live Grep", ":Telescope live_grep<CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("e", "  Open Filetree", ":NvimTreeToggle<CR>"),
  dashboard.button("c", "  New File", ":ene <BAR> startinsert<CR>"),
  dashboard.button("n", "  Open Notebook", ":lua require('telescope.builtin').find_files({cwd = vim.fn.expand('~/Notebook'), hidden = true, follow = true})<CR>"),
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

alpha.setup(dashboard.config)

