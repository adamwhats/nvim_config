local function set_dap_keymaps()
  -- Buffer-local key mappings
  local opts = { noremap = true, silent = true, buffer = true }

  -- Set key mappings for DAP
  vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<Leader>B",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(
    0,
    "n",
    "<Leader>lp",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dr", ":lua require'dap'.repl.open()<CR>", opts)
  vim.api.nvim_buf_set_keymap(0, "n", "<Leader>dl", ":lua require'dap'.run_last()<CR>", opts)
end

-- Define a function to clear DAP key mappings
local function clear_dap_keymaps()
  -- Clear buffer-local key mappings
  vim.api.nvim_buf_del_keymap(0, "n", "<F5>")
  vim.api.nvim_buf_del_keymap(0, "n", "<F10>")
  vim.api.nvim_buf_del_keymap(0, "n", "<F11>")
  vim.api.nvim_buf_del_keymap(0, "n", "<F12>")
  vim.api.nvim_buf_del_keymap(0, "n", "<Leader>b")
  vim.api.nvim_buf_del_keymap(0, "n", "<Leader>B")
  vim.api.nvim_buf_del_keymap(0, "n", "<Leader>lp")
  vim.api.nvim_buf_del_keymap(0, "n", "<Leader>dr")
  vim.api.nvim_buf_del_keymap(0, "n", "<Leader>dl")
end

return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependecies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_intialized["dapui_config"] = function()
        dapui.open()
        set_dap_keymaps()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
        clear_dap_keymaps()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
        clear_dap_keymaps()
      end
    end,
  },
}
