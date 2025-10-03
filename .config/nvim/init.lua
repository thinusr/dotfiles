-- Ensure packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd [[packadd packer.nvim]]

-- Set Leader Key (must be set before mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Plugin management
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'  -- Plugin manager
    use 'neovim/nvim-lspconfig'   -- LSP support
    use 'hrsh7th/nvim-cmp'        -- Completion engine
    use 'hrsh7th/cmp-nvim-lsp'    -- LSP completion source
    use 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
    use 'nvim-lua/plenary.nvim'   -- Required for telescope
    use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'morhetz/gruvbox'         -- Gruvbox color scheme
    use 'tpope/vim-fugitive'      -- Git integration
    use 'nvim-lualine/lualine.nvim' -- Status line
    use 'L3MON4D3/LuaSnip'        -- Snippet engine
    use 'saadparwaiz1/cmp_luasnip' -- Snippet completions
    use 'mfussenegger/nvim-dap'   -- Debugging
    use 'rcarriga/nvim-dap-ui'    -- Debug UI
    use 'nvim-tree/nvim-tree.lua' -- File explorer
    use 'lewis6991/gitsigns.nvim' -- Git signs in the editor
    use 'nvim-neotest/nvim-nio'   -- Required for nvim-dap-ui
    use 'windwp/nvim-autopairs'   -- Auto brackets & quotes
    use 'shaunsingh/nord.nvim'    -- Nord color scheme
    use {
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({
          "*", -- Enable for all filetypes
        }, {
          names = true,
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
        })
      end
    }
end)

-- Enable LSP for Python
require('lspconfig').pyright.setup{
    settings = {
        python = {
            analysis = { typeCheckingMode = "strict" }
        }
    }
}

-- Set up autocompletion
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

-- Configure Treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "lua" },
    highlight = { enable = true },
}

-- Apply Gruvbox color scheme
vim.cmd [[colorscheme nord]]

-- Improve LSP diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
})

-- Set up Telescope keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

require('telescope').setup {
    defaults = {
        layout_config = {
            horizontal = { width = 0.9 },
        },
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
    pickers = {
        find_files = {
            hidden = true,
        },
    }
}

-- Load FZF extension if available
pcall(require('telescope').load_extension, 'fzf')

-- Format Python files on save
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format()]]

-- Configure Lualine (status bar)
require('lualine').setup {
    options = { theme = 'nord' }
}

-- Set up Git signs
require('gitsigns').setup {}

-- Configure file explorer
require'nvim-tree'.setup {
    view = {
        side = "left",
        width = 30,
    },
    actions = {
        open_file = {
            window_picker = { enable = false },
        },
    },
}

-- Keybinding for file tree toggle (after setup)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {})

-- Debugger (DAP) UI setup
require("dapui").setup()
vim.keymap.set('n', '<leader>db', ':DapToggleBreakpoint<CR>', {})
vim.keymap.set('n', '<leader>dc', ':DapContinue<CR>', {})
vim.keymap.set('n', '<leader>dt', ':DapTerminate<CR>', {})

-- Auto pairs (auto-close brackets & quotes)
require("nvim-autopairs").setup{}

-- Relative line numbers
vim.opt.relativenumber = true

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE
  highlight VertSplit guibg=NONE
  highlight EndOfBuffer guibg=NONE
]]

vim.opt.clipboard = "unnamedplus"

if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
end
