-- Code Tree Support / Syntax Highlighting
return {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- This is the new stable branch
    event = 'VeryLazy',
    dependencies = {
        {
            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            'nvim-treesitter/nvim-treesitter-textobjects',
            branch = 'main' -- This is the new stable branch
        },
        {
            'windwp/nvim-ts-autotag'
        },
    },
    build = ':TSUpdate',
    opts = {
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        auto_install = true,
        ensure_installed = {
            'lua',
            'comment',
            'gitignore',
            'vim',
            'vimdoc',
            'lua',
            'java',
            'javascript',
            'typescript',
            'html',
            'css',
            'json',
            'tsx',
            'markdown',
            'markdown_inline',
            'go',
            'rust',
            'python'
        },
    },
    config = function (_, opts)
        local configs = require("nvim-treesitter.config")
        configs.setup(opts)
    end
}

