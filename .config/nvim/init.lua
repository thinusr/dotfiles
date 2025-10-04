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
        ['<C-Space>'] = cmp.mapping.complete(),         -- manually trigger popup
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- confirm selection
        ['<Tab>'] = cmp.mapping.select_next_item(),     -- tab cycles forward
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),   -- shift+tab cycles back
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),

    -- this controls when and how completion pops up
    completion = {
        completeopt = 'menu,menuone,noselect',
    },
})


require("lsp_migrate")  -- your custom LSP migration

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- -----------------------------
-- 4.1 LSP Setup (Mason + LSPConfig)
-- -----------------------------
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "pyright",
        "lua_ls",
        "bashls",
        "arduino_language_server",
        "marksman",
        "jsonls",
        "yamlls",
        "taplo",
        "vimls",
        "clangd",
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
vim.cmd [[colorscheme nord]]  -- using Nord instead of Gruvbox

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
    options = {
        theme = 'nord',
        section_separators = {'',''},
        component_separators = {'|','|'},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'encoding','fileformat','filetype', function() return os.date("%H:%M") end },
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
    inactive_sections = {
        lualine_c = {'filename'},
        lualine_x = {'location'},
    },
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
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format()]]

-- -----------------------------
-- 14. VSCode check
-- -----------------------------
if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
end

