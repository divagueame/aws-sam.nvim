local M = {}

function M.start()
  local buf = vim.api.nvim_create_buf(false, true)
  local opts = {
    relative = 'editor',
    width = 4,
    height = 1,
    -- col = 10,
    col = math.floor(vim.o.columns) - 10,
    -- col = math.floor(vim.o.columns / 2) - 10,
    -- row = 2,
    -- row = math.floor(vim.o.lines / 2),
    row = math.floor(vim.o.lines) - 4,
    anchor = 'NW',
    style = 'minimal'
  }
  local win = vim.api.nvim_open_win(buf, false, opts)
  M.win = win
  M.buf = buf
  M.animation_running = true

  vim.cmd([[highlight FloatingWindowGreen guifg=#d7a003 guibg=NONE]])
  vim.api.nvim_win_set_option(win, 'winhl', 'Normal:FloatingWindowGreen')


  -- M.frames = {"⬤   ", "  ⬤"}
  -- M.frames = {"●    ", "  ●"}
  M.frames = {"▏","▎","▍","▌","▋","▉","▉","█"}


  M.frame_index = 1

  vim.api.nvim_set_option_value('winblend', 20, { scope = 'local' })
  vim.api.nvim_set_option_value('winhighlight', 'Normal:Normal', { scope = 'local' })

  local function update_animation()
    if M.animation_running then
      vim.schedule(function()
        if M.win and M.buf then
          vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, { M.frames[M.frame_index] })
          M.frame_index = (M.frame_index % #M.frames) + 1
        end
      end)
    end
  end

  M.timer = vim.loop.new_timer()
  M.timer:start(0, 300, vim.schedule_wrap(update_animation))
end

function M.stop()
  if M.timer then
    M.timer:stop()
    M.timer:close()
    M.timer = nil
  end
  M.animation_running = false
  if M.win and M.buf then
    vim.schedule(function()
      vim.api.nvim_win_close(M.win, true)
      vim.api.nvim_buf_delete(M.buf, { force = true })
      M.win = nil
      M.buf = nil
    end)
  end
end

return M

