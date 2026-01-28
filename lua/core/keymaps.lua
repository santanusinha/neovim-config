-- Reference https://neovim.io/doc/user/lua.html#vim.keymap

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Remove search highlights after searching
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit console without breaking head
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Show keymaps
keymap.set("n", "<S-k>", require('telescope.builtin').keymaps, { desc = "[S]how [K]eymap" })

-- Split Management
keymap.set("n", "<leader>w|", ":vsplit<CR>", { desc = "[W]indow Split [V]ertical" })
keymap.set("n", "<leader>w_", ":split<CR>", { desc = "[W]indow Split [H]orizontal" })
keymap.set("n", "<leader>w+", "<C-w>+", { desc = "[W]indow Split Height [P]lus" })
keymap.set("n", "<leader>w-", "<C-w>-", { desc = "[W]indow Split Height [M]lus" })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow Split Equal Width" })
keymap.set("n", "<leader>w>", "<C-w>>5", { desc = "[W]indow Split Increase Width by 5" })
keymap.set("n", "<leader>w<", "<C-w><5", { desc = "[W]indow Split Decrease Width by 5" })
keymap.set("n", "<leader>wc", ":close<CR>", { desc = "[W]indow Split Decrease Width by 5" })

-- Tab Management
keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "[T]ab New" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "[T]ab Close " })
keymap.set("n", "<leader>t>", ":tabn<CR>", { desc = "[T]ab Next" })
keymap.set("n", "<leader>t<", ":tabp<CR>", { desc = "[T]ab Close" })

-- Buffer Management
keymap.set("n", "<leader>b>", ":bn<CR>", { desc = "[B]uffer [N]ext" })
keymap.set("n", "<leader>b<", ":bp<CR>", { desc = "[B]uffer [P]revious" })
keymap.set("n", "<leader>bx", ":bd!<CR>", { desc = "[B]uffer [C]lose" })
keymap.set("n", "<leader>bl", require('telescope.builtin').buffers, { desc = "[B]uffer [L]ist" })

-- Terminal
keymap.set("n", "<leader>to", ":sp | resize 30 | terminal<CR>", { desc = "[T]erminal [O]pen" })

-- The following are for plugins.
-- We keep everything in the same file to ensure that we do not override

-- NeoTree (lua/plugins/neo-tree.lua)
keymap.set("n", "<S-t>", ":Neotree reveal<CR>", { desc = "[S]how [T]ree" })

-- Telescope 
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "[F]ind [F]iles" })
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "[F]ind [G]rep" })
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "[F]ind [H]elp Tags" })
keymap.set('n', '<leader>fs', require('telescope.builtin').lsp_document_symbols, { desc = "[F]ind [S]ymbol" })
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, { desc = "[F]ind [I]ncomin Calls" })
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, { desc = "[F]ind [S]ymbol in current file"})
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({symbols={'function', 'method'}}) end, { desc = "[F]ind [M]ethods" })

-- Diagnostic
keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "[D]iagnostic [L]ist" })
keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "[D]iagnostic [N]ext" })
keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "[D]iagnostic [P]revious" })

-- Code/LSP
keymap.set('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "[C]ode [H]over" })
keymap.set('n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "[C]ode [d]efinition" })
keymap.set('n', '<leader>cD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "[C]ode [D]eclaration" })
keymap.set('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "[C]ode [I]mplementation" })
keymap.set('n', '<leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "[C]ode [T]ype Definition" })
keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "[C]ode [R]eferences" })
keymap.set('n', '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "[C]ode Element [S]ignature" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "[R]ename " })
keymap.set('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "[C]ode " })
keymap.set('v', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "[C]ode " })
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "[C]ode " })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Jetbrains binding
keymap.set('n', '<C-F6>', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "[R]ename " })

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", '<leader>go', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').organize_imports();
  end
end)

keymap.set("n", '<leader>gu', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').update_projects_config();
  end
end)

keymap.set("n", '<leader>tc', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_class();
  end
end)

keymap.set("n", '<leader>tm', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_nearest_method();
  end
end)


