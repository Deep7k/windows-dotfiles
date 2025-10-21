-- Set leader key
-- This MUST be set before any mappings are created
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Normal Mode
keymap("n", "<leader>w", ":w<CR>", opts)   -- Save
keymap("n", "<C-s>", ":w<CR>", opts)       -- Save (Ctrl+S)
keymap("n", "<leader>q", ":q<CR>", opts)   -- Quit
keymap("n", "<leader>qq", ":qa!<CR>", opts) -- Force Quit All

-- Disable default 'Q' to enter Ex mode
keymap("n", "Q", "<nop>", opts)

-- Clear search highlight
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Buffer Navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Move lines up/down (Visual mode)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Join lines without moving cursor
keymap("n", "J", "mzJ`z", opts)

-- Center screen on half-page jumps
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)