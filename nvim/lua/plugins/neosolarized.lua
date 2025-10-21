return {
  "svrana/neosolarized.nvim",
  dependencies = { "tjdevries/colorbuddy.nvim" },
  config = function()
    -- You can set options here, e.g.:
    -- vim.g.neosolarized_style = "dark" -- 'dark', 'light', 'auto'
    -- vim.g.neosolarized_contrast = "high" -- 'high', 'low', 'normal'

    -- Note: The colorscheme is set in init.lua to ensure
    -- it loads *after* all plugins are set up.
  end,
}