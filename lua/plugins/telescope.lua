-- Reference: https://github.com/nvim-telescope/telescope.nvim
-- Fuzzy search

return {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
        -- https://github.com/nvim-lua/plenary.nvim
        { 'nvim-lua/plenary.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        {
            'nvim-telescope/telescope-ui-select.nvim',
            config = function()
                -- get access to telescopes navigation functions
                local actions = require("telescope.actions")
                local open_with_trouble = require("trouble.sources.telescope").open
                require("telescope").setup({
                    -- use ui-select dropdown as our ui
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown {}
                        }
                    },
                    -- set keymappings to navigate through items in the telescope io
                    mappings = {
                        i = {
                            -- use <cltr> + n to go to the next option
                            ["<C-n>"] = actions.cycle_history_next,
                            -- use <cltr> + p to go to the previous option
                            ["<C-p>"] = actions.cycle_history_prev,
                            -- use <cltr> + j to go to the next preview
                            ["<C-j>"] = actions.move_selection_next,
                            -- use <cltr> + k to go to the previous preview
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<c-t>"] = open_with_trouble,
                        },
                        n = {
                            ["<c-t>"] = open_with_trouble,
                        },

                    },
                    -- load the ui-select extension
                    require("telescope").load_extension("ui-select")
                })
            end
        },
        {
            'folke/trouble.nvim'
        }
    },
    opts = function(_, opts)
        local actions = require("telescope.actions")
        local open_with_trouble = require("trouble.sources.telescope").open

        opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {},{
            layout_config = {
            },
            path_display = {
                filename_first = {
                    reverse_directories = true
                }
            },
            mappings = {
                i = {
                    ["<c-t>"] = open_with_trouble,
                },
                n = {
                    ["<c-t>"] = open_with_trouble,
                },
            }
        })
        opts.pickers = {
            find_files = {
                theme = "dropdown",
            },
            find_grep = {
                theme = "dropdown",
            },
            lsp_document_symbols = {
                theme = "cursor"
            }
            ,
            lsp_incoming_calls = {
                theme = "cursor"
            },
            -- TODO::ACCORDING TO CONTEXT
        }
    end
}
