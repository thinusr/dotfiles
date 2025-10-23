-- -----------------------------
-- Debugging (DAP)
-- -----------------------------
require("dapui").setup()
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', {})
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', {})
vim.keymap.set('n', '<leader>dt', ':DapTerminate<CR>', {})
