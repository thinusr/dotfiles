-- ========================================================
-- CORE.AUTOCMDS.LUA - Autocommand Setup
-- ========================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- -----------------------------
-- Autoformat Python on Save
-- -----------------------------
autocmd("BufWritePre", {
  pattern = "*.py",
  group = augroup("AutoFormatPython", { clear = true }),
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
