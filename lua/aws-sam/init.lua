local M = {}
local config = require("aws-sam.config")

M.setup = function(user_opts)
  config.setup(user_opts)
  require("aws-sam.commands")
  require("aws-sam.keymaps").setup(config.options)
end

return M
