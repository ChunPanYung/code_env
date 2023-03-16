return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- Required
      {'hrsh7th/cmp-nvim-lsp'},     -- Required
      {'hrsh7th/cmp-buffer'},       -- Optional
      {'hrsh7th/cmp-path'},         -- Optional
      {'saadparwaiz1/cmp_luasnip'}, -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional

      -- Snippets
      {'L3MON4D3/LuaSnip'},             -- Required
      {'rafamadriz/friendly-snippets'}, -- Optional

      {'folke/neodev.nvim'},
    },
    config = function()
      require('neodev').setup({})
      -- Learn the keybindings, see :help lsp-zero-keybindings
      -- Learn to configure LSP servers, see :help lsp-zero-api-showcase
      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      -- Setup vscode like key mappings
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      lsp.setup_nvim_cmp({
        mapping = lsp.defaults.cmp_mappings({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
          ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        })
      })

      -- See :help lsp-zero-preferences
      lsp.set_preferences({
        set_lsp_keymaps = true, -- set to false if you want to configure your own keybindings
        manage_nvim_cmp = true, -- set to false if you want to configure nvim-cmp on your own

        -- Opt-out of mason.nvim
        suggest_lsp_servers = false,
        setup_servers_on_start = false,
        call_servers = 'global'
      })
      local lsp_opts = {
        single_file_support = false
      }
      lsp.setup_servers({'bashls', 'ruff_lsp', 'rust_analyzer',
        -- Web Development
        'quick_lint_js', 'tsserver',
        -- DevOps
        'ansiblels', 'terraformls',
        opts = lsp_opts})

      -- (Optional) Configure lua language server for neovim
      lsp.nvim_workspace()

      lsp.setup()
    end
  }
}
