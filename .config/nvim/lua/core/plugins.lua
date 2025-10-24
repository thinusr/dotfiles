-- -----------------------------
-- Plugin Management
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
    use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- already included
  },
  config = function()
    require('nvim-tree').setup {}
  end
}

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'nvim-neotest/nvim-nio'

    -- Misc
    use 'windwp/nvim-autopairs'

end)

