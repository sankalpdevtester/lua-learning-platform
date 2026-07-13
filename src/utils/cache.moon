-- src/utils/cache.moon
-- In-memory cache with TTL for API responses

import Timer from require "luvit.timer"
import utils from require "utils"

Cache = {}
Cache.__index = Cache

-- Create a new cache instance
function Cache.new(ttl = 60) -- 1 minute default TTL
  local instance = setmetatable({}, Cache)
  instance.cache = {}
  instance.ttl = ttl
  return instance
end

-- Get a value from the cache
function Cache:get(key)
  local value = self.cache[key]
  if value and value.expire > os.time() then
    return value.data
  else
    self.cache[key] = nil
    return nil
  end
end

-- Set a value in the cache
function Cache:set(key, data)
  self.cache[key] = {
    data: data
    expire: os.time() + self.ttl
  }
end

-- Delete a value from the cache
function Cache:delete(key)
  self.cache[key] = nil
end

-- Clear the entire cache
function Cache:clear()
  self.cache = {}
end

-- Create a cache instance with a 5 minute TTL
cache = Cache.new(300)

-- Example usage:
-- cache:set("api_response", { status: 200, data: "Hello World" })
-- print(cache:get("api_response")) -- prints: { status: 200, data: "Hello World" }

-- Automatically clear expired cache entries
Timer.setInterval(60, function() -- every 1 minute
  for key, value in pairs(cache.cache) do
    if value.expire < os.time() then
      cache:delete(key)
    end
  end
end)

-- Export the cache instance
export cache