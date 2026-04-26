```lua
--- Escapes special characters in a Lua pattern.
--- @param pattern string The Lua pattern to escape.
--- @return string The escaped Lua pattern.
local function escape_lua_pattern(pattern)
    return pattern:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

--- Returns the updated utils table with the new function.
return {
    escape_lua_pattern = escape_lua_pattern
}
```