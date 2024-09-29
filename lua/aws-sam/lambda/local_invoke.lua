local M = {}

M.invoke_fn = function()
  local spinner = require("aws-sam.utils.spinner")
  spinner.start()
  local lacasitos =   require("lacasitos")
  local notify = require("notify")
  local finders = require("aws-sam.utils.finders")
  local lambda_event_file

  local function_logical_id
  local code_uri

  local success, _ = pcall(function()
    code_uri = finders.get_code_uri()
    local events = finders.get_events(code_uri)
    lambda_event_file = lacasitos.get_user_choice(events)
  end)

  if not success then
    notify("Error. No Code UIR or Events", "error" )
    spinner.stop()
    return
  end


  success, _ = pcall(function()
    local template_parser = require("aws-sam.lambda.template_parser")
    local template_path = finders.find_template_path()
    function_logical_id = template_parser.get_function_identifier(code_uri, template_path)
  end)

  if not success or function_logical_id == nil then
    notify("Could not find the Function's logical name", "error" )
    spinner.stop()
    return
  end

  notify('Invoking locally - ' .. function_logical_id)
  local command = { "sam", "local", "invoke", function_logical_id }

  if lambda_event_file then
    table.insert(command, "--event")
    table.insert(command, lambda_event_file)
  end

  vim.system(command, {}, function(obj)
    spinner.stop()

    local response = { exit_code = nil, stdout = nil, stderr = nil }
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
