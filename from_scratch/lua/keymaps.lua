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
-- [[ insert single character before cursor ]]
vim.cmd([[
nnoremap <Leader>i :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap <Leader>a :exec "normal a".nr2char(getchar())."\e"<CR>
]])

-- move up/down by visual line instead of text line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
