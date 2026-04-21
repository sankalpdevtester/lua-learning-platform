```lua
-- Import required libraries
local luasql = require("luasql.mysql")
local config = require("config")

-- Create a connection to the database
local env = luasql.mysql()
local con = env:connect(config.database.name, config.database.username, config.database.password, config.database.host, config.database.port)

-- Check if the connection was successful
if con then
    print("Connected to database")
else
    print("Failed to connect to database")
    return
end

-- Create the users table
local users = [[
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
    );
]]

-- Create the lessons table
local lessons = [[
    CREATE TABLE IF NOT EXISTS lessons (
        id INT AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL,
        PRIMARY KEY (id)
    );
]]

-- Create the projects table
local projects = [[
    CREATE TABLE IF NOT EXISTS projects (
        id INT AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL,
        PRIMARY KEY (id)
    );
]]

-- Create the forum_posts table
local forum_posts = [[
    CREATE TABLE IF NOT EXISTS forum_posts (
        id INT AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        user_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );
]]

-- Execute the SQL queries to create the tables
con:execute(users)
con:execute(lessons)
con:execute(projects)
con:execute(forum_posts)

-- Define a function to insert a new user into the database
local function insert_user(username, email, password)
    local query = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)"
    local cur = con:execute(query, username, email, password)
    return cur:numrows()
end

-- Define a function to insert a new lesson into the database
local function insert_lesson(title, description, code)
    local query = "INSERT INTO lessons (title, description, code) VALUES (?, ?, ?)"
    local cur = con:execute(query, title, description, code)
    return cur:numrows()
end

-- Define a function to insert a new project into the database
local function insert_project(title, description, code)
    local query = "INSERT INTO projects (title, description, code) VALUES (?, ?, ?)"
    local cur = con:execute(query, title, description, code)
    return cur:numrows()
end

-- Define a function to insert a new forum post into the database
local function insert_forum_post(title, content, user_id)
    local query = "INSERT INTO forum_posts (title, content, user_id) VALUES (?, ?, ?)"
    local cur = con:execute(query, title, content, user_id)
    return cur:numrows()
end

-- Close the database connection
con:close()
env:close()
```