-- Reference: https://github.com/ThePrimeagen/harpoon
-- Quick file marks and navigation

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon"):setup()
    end,
}
