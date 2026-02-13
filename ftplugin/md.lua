-- Markdown LSP and Rendering setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup Marksman LSP using the new Neovim 0.11+ API
-- This avoids the lspconfig deprecation warning
vim.lsp.enable('marksman', {
    capabilities = capabilities,
    root_dir = vim.fs.root(0, { ".git", ".marksman.toml" }),
})

-- Setup render-markdown plugin
require('render-markdown').setup({
    heading = {
        enabled = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    code = {
        enabled = true,
        style = 'full',
        left_pad = 2,
        right_pad = 2,
    },
    checkbox = {
        enabled = true,
    },
})

-- Markdown specific keymaps
local keymap = vim.keymap
keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", { buffer = true, desc = "Toggle Markdown Render" })
