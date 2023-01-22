-- [[ kickstart.nvim: $XDG_CONFIG_HOME/nvim/after/plugin/ ]]
vim.opt.title = true

vim.opt.cursorline = true
vim.opt.colorcolumn = '80'

vim.opt.syntax = 'on'
vim.opt.termguicolors = true

-- [[ Tab & Indent ]]
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.tabstop = 2
vim.opt.smartindent = true

-- [[ Line Break ]]
vim.opt.linebreak = true
vim.opt.showbreak = '↪'

-- [[ pop up menu ]]
vim.opt.pumheight = 20

-- [[ highlight: use different color than specify by colorscheme ]]
vim.cmd([[
  " Set invisible characters' color
  highlight Nontext    ctermfg=DarkGray guifg=DarkGray
  highlight SpecialKey ctermfg=DarkGray guifg=DarkGray
  " Set popup menu background color
  highlight Pmenu           ctermbg=Black    guibg=Black
]])

-- [[ Diagnostic Settings ]]
vim.diagnostic.config({
  virtual_text = false -- disable diagnostic message on the right side
})

-- Show line diagnostics automatically in hover window
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- [[ folding settings (press za to toggle folds) ]]
vim.opt.foldmethod = 'indent'  -- Fold based on indent
vim.opt.foldnestmax = 10       -- Deepest fold is 10 levels
vim.opt.foldenable = false     -- Dont fold by default
vim.opt.foldlevel= 1           -- Don't fold the root level

-- [[ Netrw: built-in file browser setup ]]
vim.g['netrw_liststyle'] = 3      -- tree list view in netrw
vim.g['netrw_fastbrowse'] = 0     -- always obtains directory listings
vim.g['netrw_keepdir'] = 0     -- always obtains directory listings

vim.cmd([[
" disable line number in terminal mode
autocmd TermOpen * setlocal nonumber norelativenumber
]])

vim.cmd([[
  silent !mkdir ~/.cache/nvim/backup > /dev/null 2>&1
  set backupcopy=yes " Overwrite the original backup file
  au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
]])

local HOME = os.getenv('HOME')
vim.opt.backupdir = HOME .. '/.cache/nvim/backup/'
vim.opt.backup = true
vim.opt.writebackup = true

vim.cmd([[
" autoread and load file when focus on buffer
au FocusGained,BufEnter * :silent! !
]])

--[[ Setup highlight, match function will call per buffer.
     Otherwise it will not work.
--]]
vim.cmd([[
  highlight ExtraWhitespace ctermbg=LightMagenta guibg=LightMagenta
]])
-- Ensure trailing white spaces will be highlighted.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = [[match ExtraWhitespace /\s\+$/]]
})

--[[ User Created Commands ]]
vim.api.nvim_create_user_command('TrimBlank', function()
  vim.cmd([[
    " Replace multiple blank lines with a single blank line
    silent! %s/\(\n\n\)\n\+/\1/
    " Trim final newline
    silent! v/\_s*\S/d
    " Clear all highlight
    nohlsearch
  ]])
end, {})

vim.api.nvim_create_user_command('TrimSpace', function()
  vim.cmd([[
    " Remove trailing white spaces
    %s/\s\+$//e
  ]])
end, {})

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
-- keymap("n", ",i", "i_<Esc>r", opts) -- insert single character with ,i
-- keymap("n", ",a", "a_<Esc>r", opts) -- insert single character with ,a
keymap("n", "<Space>i", "i_<Esc>r", opts) -- insert single character with ,i
keymap("n", "<Space>a", "a_<Esc>r", opts) -- insert single character with ,a

-- move up/down by visual line instead of text line
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- [[ File Type ]]
vim.filetype.add {
  extension = {
    ejs='html',
    hbs='html',
    Jenkinsfile='groovy'
  }
}

-- Setup functions to call depends on filetype
local function four_spaces()
  vim.opt_local.shiftwidth = 4
  vim.opt_local.softtabstop = 4
  vim.opt_local.tabstop = 4
end

local function hard_tab()
  vim.opt_local.shiftwidth = 4
  vim.opt_local.tabstop = 4
  vim.opt_local.expandtab = false
end

vim.cmd([[
  autocmd FileType *.{py,bash,md,rs} call FourSpaces()
  autocmd FileType groovy call FourSpaces()
  autocmd FileType Jenkinsfile call FourSpaces()
  autocmd FileType go call HardTab()
  " disable automatic comment insertion on next line
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]])
