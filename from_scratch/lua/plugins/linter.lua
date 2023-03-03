return {
  { -- Linter
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        ruby   = {'ruby'},
        yaml   = {'yamllint'},
        ansible = {'ansible_lint'}, -- set ft=yaml.ansible
        dockerfile = {'hadolint'}
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
        require("lint").try_lint()
        end,
      })
    end
  },
}
