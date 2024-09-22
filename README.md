<h1 align="center">AWS SAM Neovim Plugin</h1>
<p align="center">This plugins aims at improving the workflow when developing SAM AWS applications in Neovim.</p>

## Features

- Validate SAM Templates
- Build and run lambda functions from within Neovim

## Installation

Using Lazy:

```
return {
	"divagueame/aws-sam.nvim",
	config = function()
		require("aws-sam").setup()
	end,
}
```

## Usage

- To validate a SAM Template, open a SAM project and type:
```
:SamValidate
```
This command will find recursively to find your template.yml in that project.


- To invoke a lambda function locally, open your your function on a buffer and run:

```
:SamLocalInvoke<CR>
```

- Build a lambda function locally:

```
:SamLocalBuildFn<CR>
```

- Build and invoke a lambda function locally:

```
:SamLocalBuildInvokeFn<CR>
```


## keymaps

| Mode   | Keybinding          | Action                | Description                  |
| ------ | ------------------- | --------------------- | ---------------------------- |
| Normal | `<leader><leader>v` | `:SamValidate<CR>`    | Validate an AWS SAM template |
| Normal | `<leader><leader>i` | `:SamLocalInvoke<CR>` | Invoke a function locally    |
| Normal | `<leader><leader>f` | `:SamLocalBuildInvokeFn<CR>` | Build && Invoke a function locally    |

## Configuration

Aws-sam.nvim will automatically create keymaps. You can disable this by passing a table to override the default values on the setup function.

These are the default values:

```
require("aws-sam").setup({
    keymaps = true,
})
```
