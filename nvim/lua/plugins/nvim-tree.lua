return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Disable netrw which is the default file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Set icons (optional, requires a Nerd Font)
    require("nvim-web-devicons").setup()

    -- Setup nvim-tree
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false, -- Change to true if you want to see dotfiles
      },
    })

    -- Keymap to toggle nvim-tree
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
  end,
}