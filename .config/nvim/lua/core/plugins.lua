-- ========================================================
-- CORE.PLUGINS.LUA - Packer Plugin Setup
-- ========================================================

return require("packer").startup(function(use)
  -- Package Manager
  use("wbthomason/packer.nvim")

  -- LSP & Completion
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- Treesitter
  use("nvim-treesitter/nvim-treesitter")

  -- Telescope
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- UI Enhancements
  use("morhetz/gruvbox")
  use("shaunsingh/nord.nvim")
  use("nvim-lualine/lualine.nvim")
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
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
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
          require("colorizer").attach_to_buffer(0)
        end,
      })
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          highlight = "IblIndent",
        },
        scope = {
          show_start = false,
          show_end = false,
          highlight = "IblScope",
        },
      })
    end,
  })

  -- Git Integration
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- File Explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
    end,
  })

  -- Debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("nvim-neotest/nvim-nio")

  -- Miscellaneous
  use("windwp/nvim-autopairs")

  -- dashboard
  use({
  'goolord/alpha-nvim',
  requires = { 'nvim-tree/nvim-web-devicons' },
})


end)

