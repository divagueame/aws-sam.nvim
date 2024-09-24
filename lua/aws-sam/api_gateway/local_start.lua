local M = {}

M.local_start = function()
 
  local notify = require("notify")
  local response = { exit_code = nil, stdout = nil, stderr = nil }

      notify('Starting Api Gateway')
    vim.system({ "sam", "local", "start-api"}, {}, function(obj)

    response.exit_code = obj.code
    response.stdout = obj.stdout
    response.stderr = obj.stderr
    if response.exit_code == 0 then
      notify(response.stdout)
      notify(response.stderr)
    else
      notify(response.stderr)
      notify(response.stdout)
    end
  end)

end

return M
