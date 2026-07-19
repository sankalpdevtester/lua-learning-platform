-- src/utils/cache.moon

-- Import required modules
import utils from require "utils"
import luvit from require "luvit"
import LuaSQL from require "luasql.mysql"

-- Define cache class
class Cache
  new: (@ttl = 60) =>
    @cache = {}

  -- Get value from cache
  get: (key) =>
    if @cache[key]
      if @cache[key].expires > os.time!
        return @cache[key].value
      else
        @cache[key] = nil
    nil

  -- Set value in cache
  set: (key, value) =>
    @cache[key] = {
      value: value
      expires: os.time! + @ttl
    }

  -- Delete value from cache
  delete: (key) =>
    @cache[key] = nil

-- Create a new cache instance
cache = Cache 300 -- 5 minutes TTL

-- Define a function to cache API responses
cache_api_response = (key, func) =>
  cached_value = cache\get key
  if cached_value
    return cached_value
  else
    value = func!
    cache\set key, value
    return value

-- Example usage:
-- Cache a database query
cache_db_query = (query) =>
  cache_api_response "db_query", ->
    db = LuaSQL.mysql()
    cur = db\execute query
    rows = {}
    row = cur\fetch {}
    while row
      table.insert rows, row
      row = cur\fetch {}
    cur\close!
    db\close!
    rows

-- Cache a HTTP request
cache_http_request = (url) =>
  cache_api_response "http_request", ->
    http = luvit.http
    response = http.request url
    body = response\body!
    response\close!
    body

-- Test the cache
test_cache = ->
  print "Testing cache..."
  cached_value = cache_db_query "SELECT * FROM lessons"
  print "Cached value:", cached_value
  cached_value = cache_http_request "https://example.com"
  print "Cached value:", cached_value

-- Run the test
test_cache!