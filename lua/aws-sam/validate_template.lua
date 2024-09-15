local M = {}

M.validate_template = function()
	local response = { exit_code = nil, stdout = nil, stderr = nil } -- Store the job response here

	local notify = require("notify")
	vim.api.nvim_create_user_command(
		"SamValidate",
		vim.schedule_wrap(function()
			job = vim.system({ "sam", "validate" }, {}, function(obj)
				local code = obj.code -- exit code
				local stdout = obj.stdout -- standard output
				local stderr = obj.stderr -- standard error
				-- print("Job finished with exit code:", code)
				-- print("Output:", stdout)
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

	-- vim.api.nvim_create_user_command(
	-- 	"SamValidate", -- the command name
	-- 	function()
	-- 		print("Validating Template")
	-- 	end,
	-- 	{ nargs = 0 } -- options for the command
	-- )
end

return M
