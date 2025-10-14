-- ========================================================
-- INIT.LUA - NEOVIM CONFIG
-- ========================================================

-- -----------------------------
-- 1. Bootstrap Packer
-- -----------------------------
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd [[packadd packer.nvim]]

-- Load LuaRocks if installed
pcall(require, "luarocks.loader")

-- -----------------------------
-- 2. General Settings
-- -----------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autochdir = true

-- Transparent background
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE
  highlight VertSplit guibg=NONE
  highlight EndOfBuffer guibg=NONE
]]

-- -----------------------------
-- 3. Plugin Management
-- -----------------------------
require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    -- LSP & Completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Telescope & dependencies
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- UI Enhancements
    use 'morhetz/gruvbox'
    use 'shaunsingh/nord.nvim'
    use 'nvim-lualine/lualine.nvim'
    use { "NvChad/nvim-colorizer.lua", config = function()
        require("colorizer").setup({"*"}, {
            names = true, RGB = true, RRGGBB = true, RRGGBBAA = true,
            rgb_fn = true, hsl_fn = true, css = true, css_fn = true,
            mode = "background",
        })
    end }

    -- Git
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    -- File Explorer
    use 'nvim-tree/nvim-tree.lua'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'nvim-neotest/nvim-nio'

    -- Misc
    use 'windwp/nvim-autopairs'

end)

-- -----------------------------
-- 4. LSP & Autocompletion
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
-- 4.1 Mason + LSP Setup (fixed for Neovim 0.11+)
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

-- -----------------------------
-- 5. Treesitter
-- -----------------------------
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "lua" },
    highlight = { enable = true },
}

-- -----------------------------
-- 6. Colorscheme
-- -----------------------------
vim.cmd [[colorscheme nord]]

-- -----------------------------
-- 7. Telescope
-- -----------------------------
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('telescope').setup {
    defaults = {
        layout_config = { horizontal = { width = 0.9 } },
        file_ignore_patterns = { "node_modules", ".git/" },
        mappings = {
            i = {
                ["<C-o>"] = function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if entry.path then
                        vim.fn.jobstart({ "xdg-open", entry.path }, { detach = true })
                    else
                        print("No path to open")
                    end
                end
            }
        },
    },
    pickers = { find_files = { hidden = true } }
}
pcall(require('telescope').load_extension, 'fzf')

-- -----------------------------
-- 8. Lualine
-- -----------------------------
require('lualine').setup({
    options = { theme = 'nord', section_separators = {'',''}, component_separators = {'|','|'} },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch','diff'},
        lualine_c = {'filename'},
        lualine_x = {'encoding','fileformat','filetype', function() return os.date("%H:%M") end },
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    inactive_sections = { lualine_c={'filename'}, lualine_x={'location'} },
})

-- -----------------------------
-- 9. Git Signs
-- -----------------------------
require('gitsigns').setup {}

-- -----------------------------
-- 10. File Explorer (NvimTree)
-- -----------------------------
require'nvim-tree'.setup {
    view = { side = "left", width = 30 },
    actions = { open_file = { window_picker = { enable = false } } },
}
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})

-- -----------------------------
-- 11. Debugging (DAP)
-- -----------------------------
require("dapui").setup()
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', {})
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', {})
vim.keymap.set('n', '<leader>dt', ':DapTerminate<CR>', {})

-- -----------------------------
-- 12. Auto Pairs
-- -----------------------------
require("nvim-autopairs").setup{}

-- -----------------------------
-- 13. Autoformat Python
-- -----------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- -----------------------------
-- 14. VSCode check
-- -----------------------------
if vim.g.vscode then
  -- VSCode extension
else
  -- ordinary Neovim
end

-- -----------------------------
-- 15. Minimal Which-Key Popup + Leader Key Mappings
-- -----------------------------
local wk = {}

-- Define leader key mappings for popup and keybinds
wk.leader_mappings = {
    f = { name = "Files",
        ff = "Find files",
        fg = "Live grep",
        fb = "Buffers",
        fh = "Help tags",
    },
    e = "Toggle Explorer",
    g = { name = "Git",
        gs = "Status",
        gc = "Commit",
        gp = "Push",
    },
    d = { name = "DAP",
        b = "Breakpoint",
        c = "Continue",
        t = "Terminate",
    },
    l = { name = "LSP",
        rn = "Rename",
        ca = "Code Action",
    },
    w = { name = "Windows",
        s = "Split",
        v = "VSplit",
        h = "Move Left",
        j = "Move Down",
        k = "Move Up",
        l = "Move Right",
    },
}

-- Create highlight groups
vim.cmd("highlight WkKey guifg=#88c0d0 gui=bold")
vim.cmd("highlight WkGroup guifg=#81a1c1 gui=bold")

-- Build popup lines recursively
local function build_lines(tbl, prefix)
    local lines = {}
    local highlights = {}
    prefix = prefix or ""
    for k, v in pairs(tbl) do
        if type(v) == "table" and v.name then
            local line = string.format("%s%s → %s", prefix, k, v.name)
            table.insert(lines, line)
            table.insert(highlights, {line=#lines, col_start=#prefix, col_end=#prefix+#k, group="WkKey"})
            local sub_lines, sub_hl = build_lines(v, prefix .. k .. " ")
            for _, l in ipairs(sub_lines) do table.insert(lines, l) end
            for _, h in ipairs(sub_hl) do table.insert(highlights, h) end
        elseif type(v) == "string" then
            local line = string.format("%s%s → %s", prefix, k, v)
            table.insert(lines, line)
            table.insert(highlights, {line=#lines, col_start=#prefix, col_end=#prefix+#k, group="WkKey"})
        end
    end
    return lines, highlights
end

-- Show popup function
function wk.show_popup(tbl)
    local lines, highlights = build_lines(tbl)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = 0
    for _, l in ipairs(lines) do
        if #l > width then width = #l end
    end
    width = width + 2

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
        vim.api.nvim_buf_add_highlight(buf, -1, hl.group, hl.line-1, hl.col_start, hl.col_end)
    end

    vim.cmd(string.format([[
      autocmd! BufLeave <buffer=%d> ++once lua vim.api.nvim_win_close(%d, true)
    ]], buf, win))

    vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(win, true) end, {buffer=buf, nowait=true, noremap=true, silent=true})
    vim.keymap.set('n', '<CR>', function() vim.api.nvim_win_close(win, true) end, {buffer=buf, nowait=true, noremap=true, silent=true})
end

-- Popup key
vim.keymap.set('n', '<leader>w', function()
    wk.show_popup(wk.leader_mappings)
end, { noremap=true, silent=true })

-- -----------------------------
-- Bind actual leader mappings
-- -----------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Files
map('n', '<leader>ff', require('telescope.builtin').find_files, opts)
map('n', '<leader>fg', require('telescope.builtin').live_grep, opts)
map('n', '<leader>fb', require('telescope.builtin').buffers, opts)
map('n', '<leader>fh', require('telescope.builtin').help_tags, opts)

-- Explorer
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- Git
map('n', '<leader>gs', ':G<CR>', opts)
map('n', '<leader>gc', ':G commit<CR>', opts)
map('n', '<leader>gp', ':G push<CR>', opts)

-- LSP
map('n', '<leader>rn', vim.lsp.buf.rename, opts)
map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
map('n', 'gd', vim.lsp.buf.definition, opts)
map('n', 'gi', vim.lsp.buf.implementation, opts)
map('n', 'K', vim.lsp.buf.hover, opts)

-- DAP
map('n', '<leader>db', ':DapToggleBreakpoint<CR>', opts)
map('n', '<leader>dc', ':DapContinue<CR>', opts)
map('n', '<leader>dt', ':DapTerminate<CR>', opts)

-- Windows
map('n', '<leader>ws', ':split<CR>', opts)
map('n', '<leader>wv', ':vsplit<CR>', opts)
map('n', '<leader>wh', '<C-w>h', opts)
map('n', '<leader>wj', '<C-w>j', opts)
map('n', '<leader>wk', '<C-w>k', opts)
map('n', '<leader>wl', '<C-w>l', opts)

