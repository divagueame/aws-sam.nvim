local M = {}

local function find_template(dir)
  dir = vim.fn.getcwd()
  local templates = {}
  for _, file in ipairs(vim.fn.globpath(dir, "**/*.{yaml}", 0, 1)) do
    table.insert(templates, file)
  end

  for _, template in ipairs(templates) do
    return template
  end

  return nil
end

local function get_code_uri()
  local buf = vim.api.nvim_get_current_buf()
  local buf_path = vim.api.nvim_buf_get_name(buf)
  local dir = vim.fn.fnamemodify(buf_path, ":p:h")
  local parent_folder = vim.fn.fnamemodify(dir, ":t")
  return parent_folder .. "/"
end

M.invoke = function(opts)
  )

  if opts.keymaps ~= false then
    vim.api.nvim_set_keymap("n", "<leader><leader>i", ":SamLocalInvoke<cr>", { noremap = true, silent = true })
  end
end

return M
