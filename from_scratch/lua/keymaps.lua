-- [[ Keymap ]]
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("t", "<Esc>", "<C-\\><C-n>", opts) -- map <Esc> to exit terminal-mode
keymap("v", "<C-_>", "gc", { silent = true }) -- Map <C-_> and <C-/> to gcc

-- [[ Insert Mode ]]
keymap("i", "<C-H>", "<C-W>", { silent = true }) -- map <C-H> and <C-BS> to delete word
keymap("i", "<M-BS>", "<C-W>", { silent = true }) -- map <M-BS> to delete word
keymap("i", "<C-s>", "<Esc>:write<CR>i", { silent = true }) -- map <M-BS> to delete word

-- [[ Normal mode ]]
keymap("n", "<C-_>", "gcc", { silent = true }) -- Map <C-_> and <C-/> to gcc
-- keymap("n", "<Leader>i", "i_<Esc>r", opts) -- insert single character before cursor
-- keymap("n", "<Leader>a", "a_<Esc>r", opts) -- insert single character after cursor
-- [[ insert single character before cursor ]]
vim.cmd([[
nnoremap ,i :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap ,a :exec "normal a".nr2char(getchar())."\e"<CR>
]])

-- [[ buffer keymaps ]]
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

keymap("n", "<Leader>Z", ":write<CR>:bdelete<CR>", opts)
keymap("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR><C-l>", {silent = true})

-- move up/down by visual line instead of text line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
