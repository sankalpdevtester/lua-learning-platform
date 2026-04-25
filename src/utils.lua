```lua
--- Validate and format Lua table keys
--- @param key string
--- @return string
local function formatTableKey(key)
    if type(key) ~= "string" then
        error("Table key must be a string")
    end

    -- Remove leading and trailing whitespace
    key = key:gsub("^%s+", ""):gsub("%s+$", "")

    -- Replace special characters with underscores
    key = key:gsub("[^%w_]", "_")

    return key
end

--- Add the new function to the utils module
utils.formatTableKey = formatTableKey
```