local M = {}

-- TODO Support several templates
function M.find_template_path()
  local dir = vim.fn.getcwd()
  local templates = {}
  for _, file in ipairs(vim.fn.globpath(dir, "**/*.{yaml}", false, 1)) do
    table.insert(templates, file)
  end

  for _, template in ipairs(templates) do
    return template
  end

  return nil
end


function M.get_code_uri()
  local buf = vim.api.nvim_get_current_buf()
  local buf_path = vim.api.nvim_buf_get_name(buf)
  local dir = vim.fn.fnamemodify(buf_path, ":p:h")
  local parent_folder = vim.fn.fnamemodify(dir, ":t")
  return parent_folder .. "/"
end

return M
