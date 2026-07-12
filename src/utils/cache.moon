-- src/utils/cache.moon

-- Import required modules
import Cache from 'lru-cache'

-- Define cache constants
CACHE_TTL = 60 -- 1 minute
CACHE_MAX_SIZE = 1000

-- Create a new cache instance
cache = Cache {
  max: CACHE_MAX_SIZE
  ttl: CACHE_TTL * 1000 -- convert to milliseconds
}

-- Define a function to get a value from the cache
get_cached_value = (key) ->
  cache\get key

-- Define a function to set a value in the cache
set_cached_value = (key, value) ->
  cache\set key, value

-- Define a function to delete a value from the cache
delete_cached_value = (key) ->
  cache\delete key

-- Define a function to clear the entire cache
clear_cache = ->
  cache\reset!

-- Define a middleware function to cache API responses
cache_api_response = (req, res, next) ->
  -- Get the cache key from the request
  cache_key = req.url

  -- Check if the response is already cached
  cached_response = get_cached_value cache_key
  if cached_response
    -- Return the cached response
    res\send cached_response
  else
    -- Call the next middleware function
    res.on 'finish', ->
      -- Cache the response
      set_cached_value cache_key, res.body
    next!

-- Export the cache functions
export {
  :get_cached_value
  :set_cached_value
  :delete_cached_value
  :clear_cache
  :cache_api_response
}
```
-- Example usage in src/controllers/lesson_controller.moon
```moonscript
-- src/controllers/lesson_controller.moon

import cache_api_response from require 'utils.cache'

-- Define a route handler for the lessons API endpoint
get_lessons = (req, res) ->
  -- Use the cache middleware function
  cache_api_response req, res, ->
    -- Fetch the lessons from the database
    lessons = Lesson\find_all!
    -- Return the lessons as JSON
    res\json lessons

-- Define the route for the lessons API endpoint
routes\get '/api/lessons', get_lessons