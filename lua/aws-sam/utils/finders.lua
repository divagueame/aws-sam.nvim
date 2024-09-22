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
  local buf_folder_path = vim.api.nvim_buf_get_name(buf)

  local project_path = vim.fn.getcwd()
  local dir = vim.fn.fnamemodify(buf_folder_path, ":p:h")

  return dir:sub(#project_path + 2) .. "/"
end

return M
