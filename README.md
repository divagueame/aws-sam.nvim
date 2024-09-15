<p align="center">
  <h1 align="center">AWS SAM Neovim Plugin</h1>
</p>

## Features

- Validate SAM Templates

## Installation

Using Lazy:

```
return {
	"divagueame/aws-sam.nvim",
	dependencies = {
		"rcarriga/nvim-notify",
	},
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
## keymaps

| Mode   | Keybinding          | Action             | Description                  |
| ------ | ------------------- | ------------------ | ---------------------------- |
| Normal | `<leader><leader>v` | `:SamValidate<CR>` | Validate an AWS SAM template |


## Configuration

Aws-sam.nvim will automatically create keymaps. You can disable this by passing a table to override the default values on the setup function.

These are the default values:

```
require("aws-sam").setup({
    keymaps = true,
})
```


