-- Reference: https://github.com/rachartier/tiny-inline-diagnostic.nvim
-- displaying inline diagnostic messages with customizable styles and icons.
--

return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
}
