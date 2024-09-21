local M = {}

M.validate_template = function(opts)
  local response = { exit_code = nil, stdout = nil, stderr = nil }

  local notify = require("notify")
  vim.api.nvim_create_user_command(
    "SamValidate",
    vim.schedule_wrap(function()
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
    end),
    {}
  )
end

return M
