-- src/middleware/auth.lua
local utils = require("src/utils")
local models = require("src/models")

-- Define a function to authenticate requests
local function authenticate(req, res, next)
    -- Get the authorization header from the request
    local authHeader = req.headers["Authorization"]

    -- If the header is missing, return an error
    if not authHeader then
        return res:status(401):send({ error = "Unauthorized" })
    end

    -- Extract the token from the header
    local token = authHeader:match("Bearer (%S+)")

    -- If the token is missing, return an error
    if not token then
        return res:status(401):send({ error = "Unauthorized" })
    end

    -- Verify the token using the models module
    local user = models.verifyToken(token)

    -- If the token is invalid, return an error
    if not user then
        return res:status(401):send({ error = "Unauthorized" })
    end

    -- Set the user on the request object
    req.user = user

    -- Call the next middleware or route handler
    next()
end

-- Define a function to require authentication for certain routes
local function requireAuth(routes)
    return function(req, res, next)
        -- Check if the request is for a route that requires authentication
        for _, route in ipairs(routes) do
            if req.url:match(route) then
                -- If the request is for a protected route, authenticate the user
                return authenticate(req, res, next)
            end
        end

        -- If the request is not for a protected route, call the next middleware or route handler
        next()
    end
end

-- Define a list of routes that require authentication
local protectedRoutes = {
    "/api/lessons",
    "/api/projects",
    "/api/community",
}

-- Create a middleware function that requires authentication for protected routes
local authMiddleware = requireAuth(protectedRoutes)

-- Return the authentication middleware
return authMiddleware