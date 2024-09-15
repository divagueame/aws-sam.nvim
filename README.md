<p align="center">
  <h1 align="center">AWS SAM Neovim Plugin</h1>
</p>

## ⚡️ Features
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

