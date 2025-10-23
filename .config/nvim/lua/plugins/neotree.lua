-- -----------------------------
-- File Explorer (NvimTree)
-- -----------------------------
require'nvim-tree'.setup {
    view = { side = "left", width = 30 },
    actions = { open_file = { window_picker = { enable = false } } },
}
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})
