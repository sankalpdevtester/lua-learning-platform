-- src/middleware/auth.lua
local utils = require("src/utils")
local models = require("src/models")

-- Define a function to authenticate requests
local function authenticate(req, res, next)
    -- Get the authorization header from the request
    local authHeader = req.headers["Authorization"]

    -- If the header is missing, return an error
    if not authHeader then
        return res:status(401):send("Unauthorized")
    end

    -- Extract the token from the header
    local token = authHeader:match("Bearer (%S+)")

    -- If the token is missing, return an error
    if not token then
        return res:status(401):send("Unauthorized")
    end

    -- Verify the token using the models module
    local user = models.verifyToken(token)

    -- If the token is invalid, return an error
    if not user then
        return res:status(401):send("Unauthorized")
    end

    -- Set the user on the request object
    req.user = user

    -- Call the next middleware or route handler
    next()
end

-- Define a function to require authentication for a route
local function requireAuth(route)
    return function(req, res, next)
        authenticate(req, res, function()
            route(req, res, next)
        end)
    end
end

-- Define a function to optional authentication for a route
local function optionalAuth(route)
    return function(req, res, next)
        authenticate(req, res, function()
            route(req, res, next)
        end)
    end
end

-- Return the authentication middleware functions
return {
    authenticate = authenticate,
    requireAuth = requireAuth,
    optionalAuth = optionalAuth,
}
```
```lua
-- src/utils.lua (update)
local auth = require("src/middleware/auth")

-- Define a function to protect routes with authentication
local function protectRoute(route)
    return auth.requireAuth(route)
end

-- Return the updated utils module
return {
    -- ... existing functions ...
    protectRoute = protectRoute,
}
```
```lua
-- src/config.lua (update)
local auth = require("src/middleware/auth")

-- Define the authentication middleware
local authMiddleware = auth.authenticate

-- Return the updated config
return {
    -- ... existing config ...
    authMiddleware = authMiddleware,
}
```
```lua
-- src/models.lua (update)
local utils = require("src/utils")

-- Define a function to verify a token
local function verifyToken(token)
    -- Implement token verification logic here
    -- For example, using a database or a secret key
    -- ...
    return true -- or false if the token is invalid
end

-- Return the updated models module
return {
    -- ... existing models ...
    verifyToken = verifyToken,
}