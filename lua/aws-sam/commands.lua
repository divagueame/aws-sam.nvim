vim.api.nvim_create_user_command(
  "SamLocalInvoke",
  vim.schedule_wrap(
    function()
      require("aws-sam.lambda.local_invoke").invoke_fn()
    end
  ),
  {}
)

vim.api.nvim_create_user_command(
  "SamValidate",
  vim.schedule_wrap(
    function()
      require("aws-sam.validate_template").validate()
    end
  ),
  {}
)

vim.api.nvim_create_user_command(
  "SamLocalBuildInvokeFn",
  vim.schedule_wrap(
    function()
      require("aws-sam.lambda.build").build()
    end
  ),
  {}
)

vim.api.nvim_create_user_command(
  "SamLocalBuildInvokeFn",
  vim.schedule_wrap(
    function()
      require("aws-sam.lambda.build_and_run").trigger()
    end
  ),
  {}
)

vim.api.nvim_create_user_command(
  "SamApiGatewayLocalStart",
  vim.schedule_wrap(
    function()
      require("aws-sam.api_gateway.local_start").local_start()
    end
  ),
  {}
)


