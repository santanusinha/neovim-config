-- Reference: https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure Neovim statusline written in Lua.
local colors = require("kanagawa.colors")

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        {
            'nvim-tree/nvim-web-devicons'
        },
        {
            -- https://github.com/linrongbin16/lsp-progress.nvim
            'linrongbin16/lsp-progress.nvim' -- LSP loading progress
        },
    },
    opts = {
        options = {
            theme = 'material', -- Todo::Check auto
            icons_enabled = true,
            section_separators = { left = '', right = ''},
            component_separators = { left = '', right = ''},
            always_divide_middle = true,
            globalstatus = true,
            ignore_focus = { 'Neotree' },
            refresh = { -- refresh config
                statusline = 100,
                tabline = 100,
                winbar = 100,
                refresh_time = 16,
                events = { -- events to refresh on
                    'WinEnter',
                    'BufEnter',
                    'BufWritePost',
                    'SessionLoadPost',
                    'FileChangedShellPost',
                    'VimResized',
                    'Filetype',
                    'CursorMoved',
                    'CursorMovedI',
                    'ModeChanged',
                },
                -- Also you can force lualine's refresh by calling refresh function
                -- like require('lualine').refresh()
            }
        },
        sections = {
            -- LHS
            lualine_a = { 'mode' }, -- Mode (n/v/i)
            lualine_b = { 'filename' }, -- File
            lualine_c = {
                {
                    'branch',
                    icon = "",
                    color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                },
                {
                    'diff',
                    sections = { added = " ", modified = " ", removed = " " },
                    diff_color = {
                        added = { fg = colors.green },
                        modified = { fg = colors.orange },
                        removed = { fg = colors.red },
                    }
                },
                {
                    'diagnostics',
                    symbols = { error = " ", warn = " ", info = " " },
                    diagnostics_color = {
                        -- Same values as the general color option can be used here.
                        error = { fg = colors.red },
                        warn  = { fg = colors.yellow },
                        info  = { fg = colors.white },
                        hint  = { fg = colors.cyan },
                    },
                    colored = true,           -- Displays diagnostics status in color if set to true.
                    update_in_insert = false, -- Update diagnostics in insert mode.
                    always_visible = false,
                }
            }, -- Change stats

            -- RHS
            lualine_w = { 'lsp_status' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- File details
            lualine_y = { 'progress' }, -- file progress
            lualine_z = { 'location' } -- Cursor location

        }
    }
}

