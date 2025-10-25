-- ========================================================
-- CORE.LSP.LUA - LSP & Completion Setup
-- ========================================================

-- -----------------------------
-- Completion (nvim-cmp + LuaSnip)
-- -----------------------------
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
  completion = {
    completeopt = "menu,menuone,noselect",
  },
})

-- -----------------------------
-- Diagnostics
-- -----------------------------
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})

-- -----------------------------
-- Mason Setup
-- -----------------------------
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "typescript-language-server", -- ✅ Correct
    "bashls",
    "jsonls",
    "html",
    "cssls",
  },
})

-- -----------------------------
-- LSP Configuration
-- -----------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "<leader>rn", vim.lsp.buf.rename, opts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "]d", vim.diagnostic.goto_next, opts)
end

-- -----------------------------
-- Server Setup
-- -----------------------------
local lspconfig = vim.lsp
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  pyright = {},
  tsserver = {},
  bashls = {},
  jsonls = {},
  html = {},
  cssls = {},
}

for server, config in pairs(servers) do
  lspconfig.config(server, vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, config))
end
