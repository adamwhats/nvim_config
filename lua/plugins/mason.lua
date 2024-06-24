return {
  -- Add mason and mason-lspconfig
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" }, -- Ensure pyright is installed
      })
    end,
  },
  -- Add nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig")
    end,
  },
}
