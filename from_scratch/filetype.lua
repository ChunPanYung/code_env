-- [[ $XDG_CONFIG_HOME/nvim/ ]]
vim.filetype.add {
  filename = {
    ['Jenkinsfile'] ='groovy',
    ['tf'] = 'terraform'
  }
}
-- Setup functions to call depends on filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = false
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "Jenkinsfile", "groovy" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end
})

-- vim.cmd([[
--   autocmd FileType *.{py,bash,md,rs} call four_spaces()
--   autocmd FileType go call lua hard_tab()
--   " disable automatic comment insertion on next line
--   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
-- ]])
