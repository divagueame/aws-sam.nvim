local M = {}

M.setup = function(opts)
  if opts.keymaps ~= false then
    vim.api.nvim_set_keymap("n", "<leader><leader>v", ":SamValidate<cr>", { desc = "Sam - Validate a template", noremap = true, silent = true })
		-- vim.api.nvim_set_keymap("n", "<leader><leader>i", ":SamLocalInvoke<cr>", { desc = "Sam - Invoke function locally", noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader><leader>f", ":SamLocalBuildInvokeFn<cr>", { desc = "Sam - Validate a template", noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader><leader>g", ":SamApiGatewayLocalStart<cr>", { desc = "Sam - Launch Api Gateway Locally", noremap = true, silent = true })
  end
end

return M
