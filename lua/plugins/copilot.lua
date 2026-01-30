return {
  -- Configure Copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>", -- Accept with Tab
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
    },
  },
  -- Configure Copilot cmp (completion)
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
