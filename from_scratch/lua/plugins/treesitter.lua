return {
  { -- nvim-treesitter, syntax highlight for Neovim
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    opts = {
      sync_install = false,
      auto_install = true,
      ensure_installed = {
        'bash',
        'rust',
        'lua',
        'python',
        'markdown',
        'go',
        'toml',
        -- Web development
        'html',
        'css',
        'typescript',
        'javascript',
        'json',
        -- IaC
        'dockerfile',
        'hcl',
        'yaml',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  }
}
