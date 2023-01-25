-- [[ Keymap ]]
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- map <Esc> to exit terminal-mode
keymap("v", "<C-_>", "gc", { silent = true }) -- Map <C-_> and <C-/> to gcc

-- [[ Insert Mode ]]
keymap("i", "<C-H>", "<C-W>", { silent = true }) -- map <C-H> and <C-BS> to delete word
keymap("i", "<M-BS>", "<C-W>", { silent = true }) -- map <M-BS> to delete word

-- [[ Normal mode ]]
keymap("n", "<C-_>", "gcc", { silent = true }) -- Map <C-_> and <C-/> to gcc
keymap("n", ",i", "i_<Esc>r", opts) -- insert single character with ,i
keymap("n", ",a", "a_<Esc>r", opts) -- insert single character with ,a

-- [[ buffer keymaps ]]
keymap("n", "<Leader>b", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":write<CR>:bdelete<CR>", opts)
keymap("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR><C-l>", {silent = true})

-- move up/down by visual line instead of text line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
