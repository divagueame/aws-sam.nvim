local M = {}

M.invoke_fn = function()
  local response = { exit_code = nil, stdout = nil, stderr = nil }
  local notify = require("notify")


  local spinner = require("aws-sam.utils.spinner")
  local finders = require("aws-sam.utils.finders")
  spinner.start()
  local function_logical_id
  local success, _ = pcall(function()
    local code_uri = finders.get_code_uri()
    local template_parser = require("aws-sam.lambda.template_parser")
    local template_path = finders.find_template_path()
    function_logical_id = template_parser.get_function_identifier(code_uri, template_path)
  end)

  if not success or function_logical_id == nil then
    notify("Could not find the Function's logical name", "error")
    spinner.stop()
    return
  end

  notify('Invoking locally - ' .. function_logical_id)

  vim.system({ "sam", "local", "invoke", function_logical_id }, {}, function(obj)
    spinner.stop()

    response.exit_code = obj.code
    response.stdout = obj.stdout
    response.stderr = obj.stderr
    if response.exit_code == 0 then
      notify(response.stdout)
    else
      notify(response.stderr)
    end
  end)
end

return M
