local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("taplo", {
    capabilities = capabilities,
    root_dir = vim.fs.root(0, { "taplo.toml", ".taplo.toml", "Cargo.toml", ".git" }),
})

vim.lsp.enable("taplo")
