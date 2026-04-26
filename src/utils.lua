```lua
--- Escapes special characters in a Lua pattern.
-- @param pattern string The Lua pattern to escape.
-- @return string The escaped Lua pattern.
local function escape_pattern(pattern)
    return pattern:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

--- Adds the escape_pattern function to the utils module.
utils.escape_pattern = escape_pattern
```