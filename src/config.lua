-- Core configuration for Lua learning platform

-- Import required modules
local luvit = require("luvit")
local luaunit = require("luaunit")
local luasql = require("luasql.sqlite3")

-- Set up database connection
local db = luasql.sqlite3()
local con = db:connect("lua_learning_platform.db")

-- Create tables if they don't exist
con:execute[[
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL
    );
]]

con:execute[[
    CREATE TABLE IF NOT EXISTS lessons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL
    );
]]

con:execute[[
    CREATE TABLE IF NOT EXISTS projects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL
    );
]]

-- Close database connection
con:close()

-- Set up Luvit server
local server = luvit.http.createServer(function(req, res)
    -- Handle requests
    if req.url == "/" then
        res:writeHeader(200, {["Content-Type"] = "text/html"})
        res:write("<html><body>Welcome to Lua Learning Platform</body></html>")
        res:finish()
    elseif req.url == "/home" then
        res:writeHeader(200, {["Content-Type"] = "text/html"})
        res:write("<html><body>Home page</body></html>")
        res:finish()
    elseif req.url == "/dashboard" then
        res:writeHeader(200, {["Content-Type"] = "text/html"})
        res:write("<html><body>Dashboard page</body></html>")
        res:finish()
    elseif req.url == "/lessons" then
        res:writeHeader(200, {["Content-Type"] = "text/html"})
        res:write("<html><body>Lessons page</body></html>")
        res:finish()
    else
        res:writeHeader(404, {["Content-Type"] = "text/html"})
        res:write("<html><body>Page not found</body></html>")
        res:finish()
    end
end)

-- Listen on port 3000
server:listen(3000, function()
    print("Server listening on port 3000")
end)

-- Set up Materialize CSS
local materialize = require("materialize")

-- Set up LuaUnit testing framework
local test = luaunit.LuaUnit.new()

-- Test suite
test:suite("Lua Learning Platform Tests")

-- Test case
test:test("Test database connection", function()
    local db = luasql.sqlite3()
    local con = db:connect("lua_learning_platform.db")
    assert(con ~= nil)
    con:close()
end)

-- Run tests
test:run()