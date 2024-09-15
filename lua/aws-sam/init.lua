local M = {}

M.setup = function()
	require("aws-sam.validate_template").validate_template()
end

return M
