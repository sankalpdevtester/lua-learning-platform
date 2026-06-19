-- src/utils/cache.moon

-- Import required modules
import utils from require "utils"
import luvit from require "luvit"
import LuaSQL from require "LuaSQL"

-- Define cache class
class Cache
  new: (@ttl = 60) =>
    @cache = {}
    @lock = luvit.lock()

  -- Get value from cache
  get: (key) =>
    @lock\lock!
    value = @cache[key]
    @lock\unlock!
    return value

  -- Set value in cache
  set: (key, value) =>
    @lock\lock!
    @cache[key] = { value, expires = os.time! + @ttl }
    @lock\unlock!

  -- Delete value from cache
  delete: (key) =>
    @lock\lock!
    @cache[key] = nil
    @lock\unlock!

  -- Clean up expired values
  cleanup: =>
    @lock\lock!
    now = os.time!
    for key, value in pairs @cache
      if value.expires < now
        @cache[key] = nil
    @lock\unlock!

-- Create cache instance
cache = Cache 300 -- 5 minutes TTL

-- Define function to cache API responses
cache_api_response = (key, fn) =>
  value = cache\get key
  if value
    return value.value
  else
    value = fn!
    cache\set key, value
    return value

-- Define function to invalidate cache
invalidate_cache = (key) =>
  cache\delete key

-- Define function to clean up cache
clean_up_cache = =>
  cache\cleanup!

-- Example usage:
-- cache_api_response "lessons", ->
--   -- API call to fetch lessons
--   lessons = LuaSQL.query "SELECT * FROM lessons"
--   return lessons

-- invalidate_cache "lessons"

-- clean_up_cache!