local function setup_lsp_keybindings(bufnr)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>r",
    "<Cmd>lua vim.lsp.buf.rename()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>gr",
    "<Cmd>lua vim.lsp.buf.references()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>lw",
    "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>ld",
    "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    { noremap = true, silent = true }
  )
end

return {
  setup_lsp_keybindings = setup_lsp_keybindings,
}
