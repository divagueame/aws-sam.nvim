local M = {}


function M.trigger()
  require("aws-sam.lambda.build").build()
  require("aws-sam.lambda.local_invoke").invoke_fn()
end


return M
