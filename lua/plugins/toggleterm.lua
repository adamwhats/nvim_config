return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
      })

      -- From https://github.com/akinsho/toggleterm.nvim/issues/533#issuecomment-2020547425
      -- Count number of terminals
      function CountTerminals()
        local buffers = vim.api.nvim_list_bufs()
        local term_count = 0

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == "terminal" then
            term_count = term_count + 1
          end
        end
        return term_count
      end

      -- New terminal
      vim.keymap.set("n", "<leader>tt", function()
        local command = CountTerminals() + 1 .. "ToggleTerm"
        vim.cmd(command)
      end, { noremap = true, silent = true, desc = "New ToggleTerm" })

      -- Close terminal
      vim.keymap.set("n", "<leader>te", function()
        if CountTerminals() == 0 then
          return
        end
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
      end, { noremap = true, silent = true, desc = "Exit current ToggleTerm" })
    end,
  },
}
