-- ========================================================
-- PLUGINS.DAP.LUA - Debug Adapter Protocol Setup
-- ========================================================

local dap = require("dap")
local dapui = require("dapui")

-- -----------------------------
-- UI Setup
-- -----------------------------
dapui.setup()

-- -----------------------------
-- Keymaps
-- -----------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts)
map("n", "<leader>dc", ":DapContinue<CR>", opts)
map("n", "<leader>dt", ":DapTerminate<CR>", opts)

-- -----------------------------
-- UI Auto-Open/Close
-- -----------------------------
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
