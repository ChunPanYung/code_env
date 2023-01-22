local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local use = require('packer').use
require('packer').startup(function(use)

  use 'wbthomason/packer.nvim' -- Packer manageer

  use 'kyazdani42/nvim-web-devicons' -- Add support to nerd fonts

  use { -- Auto-pair
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  -- tabline
    use {
      'seblj/nvim-tabline',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function() require('tabline').setup {
          no_name = '[No Name]',    -- Name for buffers with no name
          modified_icon = '',      -- Icon for showing modified buffer
          close_icon = '',         -- Icon for closing tab with mouse
          separator = "▌",          -- Separator icon on the left side
          padding = 3,              -- Prefix and suffix space
          color_all_icons = false,  -- Color devicons in active and inactive tabs
          right_separator = false,  -- Show right separator on the last tab
          show_index = false,       -- Shows the index of tab before filename
          show_icon = true,         -- Shows the devicon
      } end
    }


  use { -- Statusline
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('lualine').setup {
      options = {
        theme = 'Tomorrow',
        component_separators = '|',
        section_separators = '',
      }
    } end
  }

  use { -- nvim-treesitter, syntax highlight for Neovim
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require'nvim-treesitter.configs'.setup {
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      -- List of parsers to ignore installing
      -- ignore_install = { "javascript" },
      ensure_installed = {
        'bash',
        'css',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'python',
        'rust',
        'typescript',
        'yaml'
      },
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      }
    } end
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use { -- Comment Lines
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use { -- Linter
    'mfussenegger/nvim-lint'
  }

  use {
    'neovim/nvim-lspconfig'
  }

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- [[ Private function ]]
local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
  -- Library failed to load, return `nil`
end

-- [[ nvim-lint ]]
if prequire('lint') then
  require('lint').linters_by_ft = {
    ruby   = {'ruby'},
    yaml   = {'ansible_lint', 'yamllint'},
    python = {'pylint'}
  }

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

-- [[ nvim-lspconfig ]]
if prequire('lspconfig') then
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  require('lspconfig')['pyright'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }
  require('lspconfig')['tsserver'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
  }
  require('lspconfig')['rust_analyzer'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
      -- Server-specific settings...
      settings = {
        ["rust-analyzer"] = {}
      }
  }
end
