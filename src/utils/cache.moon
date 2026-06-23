-- src/utils/cache.moon

-- Import required modules
import Cache from 'lru-cache'
import config from 'src/config'

-- Define cache options
cacheOptions = {
  max: 500
  maxAge: 1000 * 60 * 60 -- 1 hour
}

-- Create a new cache instance
cache = Cache cacheOptions

-- Function to get a value from the cache
get = (key) ->
  cache\get key

-- Function to set a value in the cache
set = (key, value) ->
  cache\set key, value

-- Function to delete a value from the cache
del = (key) ->
  cache\del key

-- Function to clear the cache
clear = ->
  cache\reset!

-- Example usage:
-- cache\set 'api-response', { data: 'example data' }
-- print cache\get 'api-response'

-- Export the cache functions
export {
  :get
  :set
  :del
  :clear
}

-- Example usage in a route handler
import cache from 'src/utils/cache'
import LessonController from 'src/controllers/lesson_controller'

lessonController = LessonController!

-- Define a route handler that uses the cache
getLessons = (req, res) ->
  cachedResponse = cache\get 'lessons'
  if cachedResponse
    res\json cachedResponse
  else
    lessons = lessonController\getLessons!
    cache\set 'lessons', lessons
    res\json lessons

-- Define a route handler that clears the cache
clearCache = (req, res) ->
  cache\clear!
  res\json { message: 'Cache cleared' }

-- Export the route handlers
export {
  :getLessons
  :clearCache
}