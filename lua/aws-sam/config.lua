local M = {}

M.defaults = {
  keymaps = true,
}

M.setup = function(user_opts)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, user_opts or {})
end

return M
