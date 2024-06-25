return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        never_show = { ".git" },
      },
    },
    default_component_configs = {
      icon = {
        folder_open = "",
      },
    },
  },
}
