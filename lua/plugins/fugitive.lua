return {
  'tpope/vim-fugitive',
  event = "VeryLazy",
  config = function()
    local keymap = vim.keymap
    
    keymap.set('n', '<leader>Gs', ':Git<CR>', { desc = "[G]it [s]tatus" })
    keymap.set('n', '<leader>Gc', ':Git commit<CR>', { desc = "[G]it [c]ommit" })
    keymap.set('n', '<leader>Gp', ':Git push<CR>', { desc = "[G]it [p]ush" })
    keymap.set('n', '<leader>Gl', ':Git pull<CR>', { desc = "[G]it pu[l]l" })
    keymap.set('n', '<leader>Gb', ':Git blame<CR>', { desc = "[G]it [b]lame" })
    keymap.set('n', '<leader>Gd', ':Gdiffsplit<CR>', { desc = "[G]it [d]iff" })
    keymap.set('n', '<leader>Ge', ':Gedit<CR>', { desc = "[G]it [e]dit" })
  end,
}
