local M = {}
local config = require("aws-sam.config")

M.setup = function(user_opts)
  config.setup(user_opts)

  require("aws-sam.validate_template").validate_template(config.options)
  require("aws-sam.lambda.local_invoke").invoke(config.options)
end

return M
