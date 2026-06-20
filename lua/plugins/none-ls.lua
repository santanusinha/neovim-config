-- Refernce: https://github.com/nvimtools/none-ls.nvim

return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local sources = {}

        local function add_source_if_executable(source, cmd)
            if vim.fn.executable(cmd) == 1 then
                table.insert(sources, source)
            end
        end

        add_source_if_executable(null_ls.builtins.formatting.stylua, "stylua")
        add_source_if_executable(require("none-ls.diagnostics.eslint_d"), "eslint_d")
        add_source_if_executable(null_ls.builtins.formatting.prettier, "prettier")

        null_ls.setup({
            sources = sources,
        })
    end
}
