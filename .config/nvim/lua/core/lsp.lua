-- -----------------------------
-- LSP & Autocompletion
-- -----------------------------
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),

    completion = {
        completeopt = 'menu,menuone,noselect',
    },
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- -----------------------------
-- Mason + LSP Setup (fixed for Neovim 0.11+)
-- -----------------------------
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

-- Servers to install
local servers = { "lua_ls", "pyright", "ts_ls", "bashls", "jsonls", "html", "cssls" }

mason_lspconfig.setup({
    ensure_installed = servers,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- Configure servers with vim.lsp.config() (new interface)
for _, server in ipairs(servers) do
    if server == "lua_ls" then
        vim.lsp.config(server, {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })
    else
        vim.lsp.config(server, {
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

