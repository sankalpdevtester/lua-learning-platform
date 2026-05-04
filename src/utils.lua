```lua
--- Escapes special characters in a Lua pattern.
-- @param pattern string The Lua pattern to escape.
-- @return string The escaped Lua pattern.
local function escape_lua_pattern(pattern)
    return pattern:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

--- Adds the escape_lua_pattern function to the utils module.
utils.escape_lua_pattern = escape_lua_pattern
```