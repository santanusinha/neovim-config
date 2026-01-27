-- Reference: https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    source_selector = {
        winbar = false,
        statusline = false
    },
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently (e.g. faded out)
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["P"] = {
          "toggle_preview",
          config = {
            use_float = false, -- Revert back to original window
            use_snacks_image = true, -- Use stuff from the snacks plugin
            title = 'Preview',
          },
        }
      },
    },
  },
  config = function(_, opts)
    -- Disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("neo-tree").setup(opts)
  end,
}

