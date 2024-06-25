return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- C++
          null_ls.builtins.formatting.clang_format,
          -- Python
          null_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
              local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
              return { "--python-executable", virtual .. "/bin/python3", "--config-file", "~/.config/nvim/mypy.ini" }
            end,
          }),
          null_ls.builtins.diagnostics.pylint.with({
            extra_args = { "--rcfile", "~/.config/nvim/.pylintrc" },
          }),
          null_ls.builtins.formatting.black,
        },
      })
    end,
  },
}
