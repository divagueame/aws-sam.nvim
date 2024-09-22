local M = {}

-- TODO Support several templates
function M.find_template_path()
  local dir = vim.fn.getcwd()
  local templates = {}
  for _, file in ipairs(vim.fn.globpath(dir, "**/*.{yaml}", 0, 1)) do
    table.insert(templates, file)
  end

  for _, template in ipairs(templates) do
    return template
  end

  return nil
end

return M
