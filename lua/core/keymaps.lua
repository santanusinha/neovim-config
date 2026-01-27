-- Reference https://neovim.io/doc/user/lua.html#vim.keymap

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- Remove search highlights after searching
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit console without breaking head
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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

-- The following are for plugins.
-- We keep everything in the same file to ensure that we do not override
keymap.set("n", "<leader>fs", ":Neotree reveal<CR>", { desc = "[F]iles Tree [S]how" })
