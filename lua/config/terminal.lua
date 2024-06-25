-- Define the module table
local M = {}

-- Function to open the terminal in a split
function M.open_terminal_in_split()
  vim.cmd("split") -- Open a horizontal split
  vim.cmd("resize 10") -- Adjust the height of the split to 10 lines, change as needed
  vim.cmd("terminal") -- Open a terminal in the split
end

-- Set a key mapping to open the terminal in a split
function M.setup()
  vim.api.nvim_set_keymap(
    "n",
    "<leader>tt",
    ':lua require("config.terminal").open_terminal_in_split()<CR>',
    { noremap = true, silent = true }
  )
end

-- Call the setup function to apply the key mapping
M.setup()

-- Export the module table
return M
