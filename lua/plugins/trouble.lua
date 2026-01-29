-- Reference: 

return {
    "folke/trouble.nvim",
    opts = {
        auto_close = true,
        focus = true,
        win = {
            type = "split",
            position = "bottom", -- or "right", "left", "top"
            relative = "editor",
            size = 0.25, -- 25% of the editor height/width
        },
        preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.3,
        },
--        modes = {
--            diagnostics = {
--                win = {
--                    type = "float",
--                    relative = "win",
--                    position = "right",
--                    --size = 0.3,
--                },
--            },
--            lsp_definitions = {
--                mode = "lsp_definitions",
--                preview = {
--                    type = "float",
--                    relative = "editor",
--                    border = "rounded",
--                    title = "Preview",
--                    title_pos = "center",
--                    position = { 0, -2 },
--                    size = { width = 0.3, height = 0.3 },
--                    zindex = 200,
--                }
--            },
--            lsp_references = {
--                win = {
--                    type = "split",
--                    position = "bottom", -- or "right", "left", "top"
--                    relative = "editor",
--                    size = 0.2, -- 20% of the editor height/width
--                },
--                preview = {
--                    type = "split",
--                    relative = "win",
--                    position = "right",
--                    size = 0.3,
--                },
--            }
--        }
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
    icons = {
        indent = {
            middle = " ",
            last = " ",
            top = " ",
            ws = "│  ",
        },
    },
}
