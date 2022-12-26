--[[
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function SortImports()
  local node = ts_utils.get_node_at_cursor()
  if node == nil then
    error("No node at cursor")
  end

  local root = ts_utils.get_root_for_node(node)

  local children = ts_utils.get_named_children(root)

  local imports = {}
  for _, child in ipairs(children) do
    if child:type() == "import_statement" then
      table.insert(imports, child)
    end
  end

  --local import_lines = {}
  for _, import in ipairs(imports) do
    local module_name = import:children_with_type("import_clause")[1]:children_with_type("identifier")[1]:text()
    local module_path = import:children_with_type("string_literal")[1]:text()
    print(module_name, module_path)
  end

end
]]--
