-- src/utils/cache.moon

import Cache from require "lru-cache"

-- Create a new cache instance with a TTL of 1 hour
cache = Cache {
  max: 500
  ttl: 1000 * 60 * 60
}

-- Function to get a value from the cache
get = (key) ->
  cache\get key

-- Function to set a value in the cache
set = (key, value) ->
  cache\set key, value

-- Function to delete a value from the cache
delete = (key) ->
  cache\delete key

-- Function to clear the entire cache
clear = ->
  cache\reset!

-- Example usage:
-- cache\set "lesson:1", { id: 1, name: "Introduction to Lua" }
-- print cache\get "lesson:1"

-- Export the cache functions
export {
  :get
  :set
  :delete
  :clear
}

-- Example usage in a controller:
-- src/controllers/lesson_controller.moon
import cache from require "utils.cache"

get_lesson = (id) ->
  cached_lesson = cache\get "lesson:#{id}"
  if cached_lesson
    return cached_lesson
  else
    lesson = Lesson\find id
    cache\set "lesson:#{id}", lesson
    return lesson

-- Example usage in a route:
-- src/routes/lesson_routes.moon
import cache from require "utils.cache"

get "/lessons/:id", (req, res) ->
  id = req.params.id
  lesson = cache\get "lesson:#{id}"
  if lesson
    res\send lesson
  else
    lesson = Lesson\find id
    cache\set "lesson:#{id}", lesson
    res\send lesson