```lua
--- Formats a Lua table into a string for easier debugging.
--- @param tbl table The table to format.
--- @param indent number The indentation level.
--- @return string The formatted table as a string.
local function formatTable(tbl, indent)
    indent = indent or 0
    local result = {}
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            table.insert(result, string.rep("  ", indent) .. tostring(key) .. " = {\n" .. formatTable(value, indent + 1) .. string.rep("  ", indent) .. "}")
        else
            table.insert(result, string.rep("  ", indent) .. tostring(key) .. " = " .. tostring(value))
        end
    end
    return table.concat(result, "\n")
end

return {
    formatTable = formatTable
}
```