local M = {}
local response = { exit_code = nil, stdout = nil, stderr = nil }
local notify = require("notify")

M.validate = function(opts)
  vim.system({ "sam", "validate" }, {}, function(obj)
    local stderr = obj.stderr
    response.exit_code = obj.code
    response.stdout = obj.stdout
    response.stderr = obj.stderr

    if response.exit_code == 0 then
      notify(" →  Success. Valid SAM template")
    else
      notify(" → " .. stderr, "error")
    end
    if stderr and #stderr > 0 then
      print("Error:", stderr)
    end
  end)
end

return M
