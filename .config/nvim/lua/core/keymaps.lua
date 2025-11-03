-- ========================================================
-- CORE.KEYMAPS.LUA - Neovim Keybindings
-- ========================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- -----------------------------
-- Leader Key
-- -----------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -----------------------------
-- Minimal Which-Key Popup
-- -----------------------------
local wk = {}

wk.leader_mappings = {
  f = { name = "Files", ff = "Find files", fg = "Live grep", fb = "Buffers", fh = "Help tags" },
  e = "Toggle Explorer",
  g = { name = "Git", gs = "Status", gc = "Commit", gp = "Push" },
  d = { name = "DAP", b = "Breakpoint", c = "Continue", t = "Terminate" },
  l = { name = "LSP", rn = "Rename", ca = "Code Action" },
  w = { name = "Windows", s = "Split", v = "VSplit", h = "Move Left", j = "Move Down", k = "Move Up", l = "Move Right" },
}

vim.cmd([[
  highlight WkKey guifg=#88c0d0 gui=bold
]])

local function build_lines(tbl, prefix)
  local lines, highlights = {}, {}
  prefix = prefix or ""
  for k, v in pairs(tbl) do
    if type(v) == "table" and v.name then
      local line = string.format("%s%s → %s", prefix, k, v.name)
      table.insert(lines, line)
      table.insert(highlights, { line = #lines, col_start = #prefix, col_end = #prefix + #k, group = "WkKey" })
      local sub_lines, sub_hl = build_lines(v, prefix .. k .. " ")
      vim.list_extend(lines, sub_lines)
      vim.list_extend(highlights, sub_hl)
    elseif type(v) == "string" then
      local line = string.format("%s%s → %s", prefix, k, v)
      table.insert(lines, line)
      table.insert(highlights, { line = #lines, col_start = #prefix, col_end = #prefix + #k, group = "WkKey" })
    end
  end
  return lines, highlights
end

function wk.show_popup(tbl)
  local lines, highlights = build_lines(tbl)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local max_line_length = 0
    for _, line in ipairs(lines) do
        max_line_length = math.max(max_line_length, #line)
    end
    local width = math.max(30, max_line_length) + 4
    local opts = {
    relative = "editor",
    width = width,
    height = #lines,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - #lines) / 2),
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  for _, hl in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, hl.group, hl.line - 1, hl.col_start, hl.col_end)
  end

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    once = true,
    callback = function() vim.api.nvim_win_close(win, true) end,
  })

  map("n", "<Esc>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true, silent = true })
  map("n", "<CR>", function() vim.api.nvim_win_close(win, true) end, { buffer = buf, nowait = true, silent = true })
end

map("n", "<leader>w", function() wk.show_popup(wk.leader_mappings) end, opts)

-- -----------------------------
-- Leader Mappings
-- -----------------------------

-- Files
map("n", "<leader>ff", require("telescope.builtin").find_files, opts)
map("n", "<leader>fg", require("telescope.builtin").live_grep, opts)
map("n", "<leader>fb", require("telescope.builtin").buffers, opts)
map("n", "<leader>fh", require("telescope.builtin").help_tags, opts)

-- Explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Git
map("n", "<leader>gs", ":G<CR>", opts)
map("n", "<leader>gc", ":G commit<CR>", opts)
map("n", "<leader>gp", ":G push<CR>", opts)

-- LSP
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)
map("n", "K", vim.lsp.buf.hover, opts)

-- DAP
map("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts)
map("n", "<leader>dc", ":DapContinue<CR>", opts)
map("n", "<leader>dt", ":DapTerminate<CR>", opts)

-- Window Navigation
map("n", "<leader>ws", ":split<CR>", opts)
map("n", "<leader>wv", ":vsplit<CR>", opts)
map("n", "<leader>wh", "<C-w>h", opts)
map("n", "<leader>wj", "<C-w>j", opts)
map("n", "<leader>wk", "<C-w>k", opts)
map("n", "<leader>wl", "<C-w>l", opts)

-- Vimwiki
vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<CR>", { desc = "Open Vimwiki index" })
vim.keymap.set("n", "<leader>wd", "<cmd>VimwikiMakeDiaryNote<CR>", { desc = "Create today's diary note" })
vim.keymap.set("n", "<leader>wi", "<cmd>VimwikiDiaryIndex<CR>", { desc = "Open diary index" })
vim.keymap.set("n", "<leader>ws", "<cmd>VimwikiSearch<CR>", { desc = "Search Vimwiki" })

-- Vimwiki Telescope
vim.keymap.set("n", "<leader>wf", function()
  require("telescope.builtin").find_files({ cwd = "~/vimwiki" })
end, { desc = "Find Vimwiki files" })

-- Search Cheatsheets
vim.keymap.set("n", "<leader>cs", function()
  require("telescope.builtin").find_files({
    prompt_title = "Cheatsheets",
    cwd = "~/projects/cheatsheets",
  })
end, { desc = "Open Cheatsheets" })

-- Search Notebook
vim.keymap.set("n", "<leader>ns", function()
  require("telescope.builtin").find_files({
    prompt_title = "Notes",
    cwd = "~/Notebook",
  })
end, { desc = "Open Notes" })










