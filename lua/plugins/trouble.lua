-- Reference: 

return {
    "folke/trouble.nvim",
    opts = {
        auto_close = true,
        focus = true,
        follow = false,
        win = {
            type = "split",
            position = "bottom", -- or "right", "left", "top"
            relative = "editor",
            size = 0.25, -- 25% of the editor height/width
        },
        preview = {
            -- type = "split",
            -- relative = "win",
            -- position = "right",
            -- size = 0.3,
            type = "main",
            scratch = true
        },
    },
    cmd = "Trouble",
    icons = {
        indent = {
            middle = " ",
            last = " ",
            top = " ",
            ws = "│  ",
        },
    },
}
