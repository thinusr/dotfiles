-- ========================================================
-- CORE.LSP.LUA - Native LSP & Completion Setup
-- ========================================================

-- Completion (nvim-cmp + LuaSnip)
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

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
})

-- Mason Setup
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "pyright",
    "ts_ls", -- ✅ updated from tsserver
    "bashls",
    "jsonls",
    "html",
    "cssls",
  },
})

-- Shared LSP Config
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

-- Server Configurations
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
  ts_ls = {},
  bashls = {},
  jsonls = {},
  html = {},
  cssls = {},
}

-- Register and Enable Servers
for server, config in pairs(servers) do
  vim.lsp.config(server, vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, config))
  vim.lsp.enable({ server })
end

