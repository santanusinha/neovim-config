-- Code Tree Support / Syntax Highlighting
return {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- This is the new stable branch
    lazy = false,
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
        ensure_installed = {
            'lua',
            'comment',
            'gitignore',
            'vim',
            'vimdoc',
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
            'toml',
            'python'
        },
    },
    config = function (_, opts)
        local ts = require('nvim-treesitter')
        ts.setup({})
        ts.install(opts.ensure_installed)
    end
}
