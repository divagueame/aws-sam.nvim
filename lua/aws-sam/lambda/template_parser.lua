local M = {}

local function read_file_as_string(filepath)
	local file = io.open(filepath, "r")
	if not file then
		return nil, "Could not open file: " .. filepath
	end

	local content = file:read("*all")
	file:close()
	return content
end

local function find_unique_function_name(content, code_uri)
	local parser = vim.treesitter.get_string_parser(content, "yaml")
	local tree = parser:parse()[1]
	local root = tree:root()
	local function_unique_id_query = string.format(
		[[
(
  block_mapping_pair
    (flow_node
      (plain_scalar
        (string_scalar) @target_function_name
        )
      )
    (block_node
      (block_mapping
        (block_mapping_pair
          (block_node
            (block_mapping
              (block_mapping_pair
                (flow_node
                  (plain_scalar
                    (string_scalar) @value (#eq? @value "%s")
                  )
                )
              )
            )
          )
        )
      )
    )
  )
]],
		code_uri
	)

	local query_obj = vim.treesitter.query.parse("yaml", function_unique_id_query)

	for _, match, _ in query_obj:iter_matches(root, content, 0, -1) do
		for id, node in pairs(match) do
			local capture_name = query_obj.captures[id] -- Name of the capture (@key, @value)
			local node_text = vim.treesitter.get_node_text(node, content)
			if capture_name == "target_function_name" then
				return node_text
			end
		end
	end
end

function M.get_function_identifier(code_uri, template_path)
	local content, err = read_file_as_string(template_path)
	if content then
		return find_unique_function_name(content, code_uri)
	else
		print("Error:", err)
	end
end

return M
