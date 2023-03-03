return {
  { -- Auto-pair
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  },
  { -- bufferline.nvim
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end,
    keys = {
      {"<Leader>Z", ":write<CR>:bprevious<CR>:bdelete #<CR><C-l>", desc = 'Save and close current buffer'},
      {"<Leader>q", ":bprevious<CR>:bdelete #<CR><C-l>", desc = 'Close current buffer'},
      {"<S-l>", ":BufferLineCycleNext<CR>", desc = "Next Buffer"},
      {"<S-h>", ":BufferLineCyclePrev<CR>", desc = "Prev Buffer"}
    }
  },
  { -- File explorer
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 30
      },
      filesystem = {
        filtered_items = {
          never_show = {
            ".git"
          }
        }
      }
    },
    keys = {
      { "<Leader>e", "<cmd>Neotree toggle<cr>", desc = "Neotree" }
    }
  },
  { -- Statusline
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'Tomorrow',
        component_separators = '|',
        section_separators = '',
      }
    }
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      open_mapping = [[<Leader>t]],
      direction = 'float'
    },
    keys = {
      { "<Leader>t", "<Cmd>ToggleTerm<CR>", desc = "Terminal Toggle" }
    },
  },
  { -- Comment Lines
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name= "+goto" },
        ["<Leader>"] = {
          name = "+leader",
          i = { name = "insert single character before cursor." },
          a = { name = "insert single character after cursor." }
        },
        ["z"] = { name = "+fold" }
      })

    end
  }
} -- End plugins manager
