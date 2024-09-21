local M = {}

local function find_template_path()
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

local function get_code_uri()
  local buf = vim.api.nvim_get_current_buf()
  local buf_path = vim.api.nvim_buf_get_name(buf)
  local dir = vim.fn.fnamemodify(buf_path, ":p:h")
  local parent_folder = vim.fn.fnamemodify(dir, ":t")
  return parent_folder .. "/"
end

M.invoke = function(opts)
	local response = { exit_code = nil, stdout = nil, stderr = nil }
	local notify = require("notify")

	vim.api.nvim_create_user_command(
		"SamLocalInvoke",
		vim.schedule_wrap(function()
			local spinner = require("aws-sam.utils.spinner")
			spinner.start()
			local function_logical_id
			local success, result = pcall(function()
				local code_uri = get_code_uri()
				local template_parser = require("aws-sam.lambda.template_parser")
				local template_path = find_template_path()
				function_logical_id = template_parser.get_function_identifier(code_uri, template_path)
			end)

			if not success then
				notify(result .. "invoked locally", "error")

				spinner.stop()
				return
			end

			notify(function_logical_id)

			vim.system({ "sam", "local", "invoke", function_logical_id }, {}, function(obj)
				spinner.stop()

				local stderr = obj.stderr
				response.exit_code = obj.code
				response.stdout = obj.stdout
				response.stderr = obj.stderr
				if response.exit_code == 0 then
					notify(response.stdout)
				else
					notify(response.stderr)
				end
			end)
		end),
		{}
	)

end

return M
