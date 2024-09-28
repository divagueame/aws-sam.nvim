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

local function is_json_file(file_name)
    return file_name:match("%.json$") ~= nil
end

-- TODO Support all events + Sorting per priority
function M.get_events(core_uri)
  local events_path = core_uri .. "events"
  local json_files = {}

  local pfile = io.popen('ls -1 "' .. events_path .. '" /b')
  if pfile then
    for file in pfile:lines() do
      if is_json_file(file) then
        local file_path = events_path .. "/" .. file
        table.insert(json_files, file_path)
      end
    end
    pfile:close()
  end

  return json_files
end

return M
