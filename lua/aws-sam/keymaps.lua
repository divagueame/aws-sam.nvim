local M = {}

M.setup = function(opts)
  if opts.keymaps ~= false then
    vim.api.nvim_set_keymap("n", "<leader><leader>v", ":SamValidate<cr>", {})
		vim.api.nvim_set_keymap("n", "<leader><leader>i", ":SamLocalInvoke<cr>", { noremap = true, silent = true })
  end
end

return M
