local lsp_keybindings = require("config.lsp_keymaps")
local lspconfig = require("lspconfig")

return {
  lspconfig.pyright.setup({
    filetypes = { "python" },
    on_attach = function(client, bufnr)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      lsp_keybindings.setup_lsp_keybindings(bufnr)
    end,
  }),
}
