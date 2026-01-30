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

-- Code commenting
keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
keymap.set("v", "<leader>/", "<Plug>(comment_toggle_blockwise_visual)", { desc = "Comment Selected" })

 
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
keymap.set("n", "<leader>to", ":sp | resize 30 | terminal<CR>i", { desc = "[T]erminal [O]pen" })

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

-- Trouble plugin
keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr><CR>', { desc = "Trouble in current file" })
keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle<CR>', { desc = "Trouble Everywhere(alt: gl)" })
keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<CR>', { desc = "Trouble Location List" })
keymap.set('n', '<leader>xQ', '<cmd>Trouble loclist toggle<CR>', { desc = "Trouble Location List" })

-- Diagnostic
keymap.set('n', '<leader>gl', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = "Dia[g]nostic [l]ist in Current File" })
keymap.set('n', '<leader>gL', '<cmd>Trouble diagnostics toggle<CR>', { desc = "Dia[g]nostic [L]ist" })
--keymap.set('n', '<leader>gL', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Dia[g]nostic [L]ist Floating" })
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = "Dia[g]nostic [N]ext" })
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = "Dia[g]nostic [P]revious" })

-- Code/LSP
keymap.set('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = "[C]ode [H]elp" })
--keymap.set('n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "[C]ode [d]efinition" })
keymap.set('n', '<leader>cd', '<cmd>Trouble lsp_definitions toggle<CR>', { desc = "[C]ode [d]efinition" })
 -- keymap.set('n', '<leader>cD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = "[C]ode [D]eclaration" })
keymap.set('n', '<leader>cD', '<cmd>Trouble lsp_declarations toggle<CR>', { desc = "[C]ode [D]eclaration" })
-- keymap.set('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = "[C]ode [I]mplementation" })
keymap.set('n', '<leader>ci', '<cmd>Trouble lsp_implementations toggle<CR>', { desc = "[C]ode [I]mplementation" })
-- keymap.set('n', '<leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "[C]ode [T]ype Definition" })
keymap.set('n', '<leader>ct', '<cmd>Trouble lsp_type_definitions toggle<CR>', { desc = "[C]ode [T]ype Definition" })
-- keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = "[C]ode [R]eferences" })
keymap.set('n', '<leader>cr', '<cmd>Trouble lsp_references toggle<CR>', { desc = "[C]ode [R]eferences" })
-- Signature help is fine
keymap.set('n', '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = "[C]ode Element [S]ignature" })
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "[R]ename Variable (Shift-F6)" })
keymap.set('n', '<S-F6>',   '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = "[R]ename Variable (Shift-F6)" })
keymap.set('v', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = "[C]ode [F]ormat" })
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "[C]ode [A]ctions" })
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Debugging: Breakpoint Management
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "[B]reakpoint [B]reak Toggle" })
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "[B]reakpoint [C]ondition" })
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = "[B]reakpoint With [L]og" })
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = "[B]reakpoint [R]emove" })
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = "[B]reakpoint [L]ist" })

keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebugger [C]ontinue (F9)" })
keymap.set("n", "<F9>", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebugger [C]ontinue" })
keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<cr>", { desc = "[D]ebugger [S]tep Over (Shift-F8)" })
keymap.set("n", "<S-F8>", "<cmd>lua require'dap'.step_over()<cr>", { desc = "[D]ebugger [S]tep Over" })
keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "[D]ebugger Step [I]nto (F7)" })
keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { desc = "[D]ebugger Step [I]nto" })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = "[D]ebugger Step [O]ut (F8)" })
keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", { desc = "[D]ebugger Step [O]ut" })
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end, { desc = "[D]ebugger " })
keymap.set("n", '<leader>dx', function() require('dap').terminate(); require('dapui').close(); end, { desc = "[D]ebugger  E[x]it (Ctrl-Atl-F9)" })
keymap.set("n", '<C-M-F9>', function() require('dap').terminate(); require('dapui').close(); end, { desc = "[D]ebugger  E[x]it (Ctrl-Atl-F9)" })
-- We don't really want the repl to go away due to random keypresses
-- keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "[D]ebugger " })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "[D]ebugger Run [L]ast (Ctrl-Alt-F9)" })
keymap.set("n", "<C-M-F9>", "<cmd>lua require'dap'.run_last()<cr>", { desc = "[D]ebugger Run [L]ast" })
keymap.set("n", '<leader>dw', function() require "dap.ui.widgets".hover() end, { desc = "[D]ebugger [W]idgets" })
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end, { desc = "[D]ebugger [F]loat" })
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>', { desc = "[D]ebugger " })
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = "[D]ebugger [H]elp (Shift-F9)" })
keymap.set("n", '<S-F9>', '<cmd>Telescope dap commands<cr>', { desc = "[D]ebugger [H]elp" })
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = "[D]ebugger " })
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end, { desc = "[D]ebugger " })

-- Filetype-specific keymaps are present in ftplugin/<filetype>.lua
