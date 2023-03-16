-- [[ lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
-- Load all *.lua within ~/.config/nvim/lua/plugins/
require("lazy").setup("plugins")

-- Run 'keymaps.lua' if exists
local keymap_path = vim.fn.stdpath 'config' .. '/lua/keymaps.lua'
if vim.fn.findfile(keymap_path) then
  require('keymaps')
end

-- [[ Basic Settings ]]
local set = vim.opt

set.number = true
set.title = true

set.cursorline = true
set.colorcolumn = '80'
set.mouse = 'a'

set.syntax = 'on'
vim.opt.termguicolors = true

set.completeopt = 'menuone,noselect'

vim.opt.exrc = true -- Enable local directory settings

-- [[ Tab & Indent ]]
set.expandtab = true
set.shiftwidth = 2
set.softtabstop = 2

set.tabstop = 2
set.smartindent = true
set.autoindent = true
set.breakindent = true

-- [[ Line Break ]]
set.linebreak = true
set.showbreak = '↪'

-- [[ Display invisible characters ]]
set.listchars = { trail = '·', tab = '» ' }
vim.opt.list = true

vim.cmd.colorscheme('habamax')

-- [[ Diagnostic Settings ]]
vim.diagnostic.config({
  virtual_text = false, -- disable diagnostic message on the right side
  float = { border = "rounded" }
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  callback = function()
    vim.diagnostic.open_float(nil, {focus=false})
  end
})

-- [[ folding settings (press za to toggle folds) ]]
set.foldmethod = 'indent'  -- Fold based on indent
set.foldenable = false     -- Dont fold by default
set.foldlevel = 1           -- Don't fold the root level

-- [[ Netrw: built-in file browser setup ]]
vim.g['netrw_liststyle'] = 3      -- tree list view in netrw
vim.g['netrw_fastbrowse'] = 0     -- always obtains directory listings
vim.g['netrw_keepdir'] = 0     -- always obtains directory listings

vim.cmd([[
" disable line number in terminal mode
autocmd TermOpen * setlocal nonumber norelativenumber
]])

vim.opt.undofile = true

vim.cmd([[
" autoread and load file when focus on buffer
au FocusGained,BufEnter * :silent! !
]])

--[[ User Created Commands ]]
vim.api.nvim_create_user_command('Trimblank', function()
  vim.cmd([[
    " Replace multiple blank lines with a single blank line
    silent! %s/\(\n\n\)\n\+/\1/
    " Trim final newline
    silent! v/\_s*\S/d
    " Clear all highlight
    nohlsearch
  ]])
end, {})

vim.api.nvim_create_user_command('Trimspace', function()
  vim.cmd([[
    " Remove trailing white spaces
    %s/\s\+$//e
  ]])
end, {})
