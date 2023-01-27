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
    end
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
      close_if_last_window = true
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
} -- End plugins manager
