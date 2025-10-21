local opt = vim.opt

-- Set $VIM to your nvim config directory
vim.env.VIM = vim.fn.stdpath("config")

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4       -- Number of spaces a <Tab> counts for
opt.softtabstop = 4   -- Number of spaces to insert for a <Tab>
opt.shiftwidth = 4    -- Number of spaces for auto-indent
opt.expandtab = true  -- Use spaces instead of tabs
opt.autoindent = true
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true  -- ...unless search pattern contains uppercase letters

-- UI
opt.wrap = false        -- Do not wrap lines
opt.scrolloff = 8       -- Keep 8 lines of context around the cursor
opt.sidescrolloff = 8
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.signcolumn = "yes"   -- Always show the sign column
opt.splitright = true    -- New vertical splits go to the right
opt.splitbelow = true    -- New horizontal splits go below

-- Behavior
opt.swapfile = false
opt.backup = false
opt.undofile = true     -- Persistent undo
-- Create undo directory
local undodir = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undodir = undodir

opt.updatetime = 50     -- Faster update time for plugins
opt.completeopt = { "menu", "menuone", "noselect" }