
-- Return to dashboard when all buffers are closed
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    vim.schedule(function()
      local bufs = vim.api.nvim_list_bufs()
      local has_real_buffer = false
      for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
          local name = vim.api.nvim_buf_get_name(buf)
          local ft = vim.bo[buf].filetype
          -- Check if it's a real file (has a name and isn't a special buffer)
          if name ~= "" and ft ~= "snacks_dashboard" and ft ~= "neo-tree" and ft ~= "trouble" then
            has_real_buffer = true
            break
          end
        end
      end

      if not has_real_buffer then
        local current_ft = vim.bo.filetype
        if current_ft ~= "snacks_dashboard" then
          require("snacks").dashboard.open()
        end
      end
    end)
  end,
})
