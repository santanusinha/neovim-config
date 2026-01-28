-- Reference: https://github.com/neovim/nvim-lspconfig
-- LSP Support
return {
    -- LSP Configuration
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        -- LSP Management
        -- https://github.com/williamboman/mason.nvim
        { 'williamboman/mason.nvim' },
        -- https://github.com/williamboman/mason-lspconfig.nvim
        { 'williamboman/mason-lspconfig.nvim' },

        -- Auto-Install LSPs, linters, formatters, debuggers
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

        -- Useful status updates for LSP
        -- https://github.com/j-hui/fidget.nvim
        { 'j-hui/fidget.nvim', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        -- https://github.com/folke/lazydev.nvim
        { 'folke/lazydev.nvim', opts = {} },
    },
    config = function ()
        require('mason').setup()

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Set global defaults for all LSP servers (Neovim 0.11+)
        vim.lsp.config('*', {
            capabilities = lsp_capabilities,
        })

        require('mason-lspconfig').setup({
            -- Install these LSPs automatically
            ensure_installed = {
                'bashls',
                'cssls',
                'html',
                'gradle_ls',
                'groovyls',
                'lua_ls',
                'jdtls',
                'jsonls',
                'lemminx',
                'marksman',
                'quick_lint_js',
                'ts_ls',
                'yamlls',
            },
            handlers = {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name)
                    -- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
                    if server_name ~= 'jdtls' then
                        vim.lsp.enable(server_name)
                    end
                end,
                -- Next, you can provide a dedicated handler for specific servers.

                ['lua_ls'] = function()
                    vim.lsp.enable('lua_ls', {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = { 'vim' },
                                },
                            },
                        },
                    })
                end,

            },
        })

        require('mason-tool-installer').setup({
            -- Install these linters, formatters, debuggers automatically
            ensure_installed = {
                'java-debug-adapter',
                'java-test',
            },
        })

        -- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
        -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
        vim.api.nvim_command('MasonToolsInstall')

        -- Modern way to handle on_attach using autocommands
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                -- Create your keybindings here...
            end,
        })

        -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
        local open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or "rounded" -- Set border to rounded
            return open_floating_preview(contents, syntax, opts, ...)
        end

    end
}

