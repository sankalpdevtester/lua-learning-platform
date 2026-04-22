```lua
-- Import required libraries
local luasql = require("luasql.sqlite3")
local config = require("config")

-- Create a connection to the SQLite database
local env = luasql.sqlite3()
local con = env:connect(config.database.name)

-- Create the users table
con:execute[[
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
    );
]]

-- Create the lessons table
con:execute[[
    CREATE TABLE IF NOT EXISTS lessons (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL
    );
]]

-- Create the projects table
con:execute[[
    CREATE TABLE IF NOT EXISTS projects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        code TEXT NOT NULL
    );
]]

-- Create the community_posts table
con:execute[[
    CREATE TABLE IF NOT EXISTS community_posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
    );
]]

-- Create the user_lessons table to track user progress
con:execute[[
    CREATE TABLE IF NOT EXISTS user_lessons (
        user_id INTEGER NOT NULL,
        lesson_id INTEGER NOT NULL,
        completed INTEGER NOT NULL DEFAULT 0,
        PRIMARY KEY (user_id, lesson_id),
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (lesson_id) REFERENCES lessons (id)
    );
]]

-- Create a function to insert a new user into the database
local function insertUser(username, email, password)
    local cur = con:execute("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", username, email, password)
    con:commit()
    return cur:fetch({}, "a")
end

-- Create a function to retrieve a user by their ID
local function getUserById(id)
    local cur = con:execute("SELECT * FROM users WHERE id = ?", id)
    return cur:fetch({}, "a")
end

-- Create a function to retrieve all lessons
local function getLessons()
    local cur = con:execute("SELECT * FROM lessons")
    local lessons = {}
    local row = cur:fetch({}, "a")
    while row do
        table.insert(lessons, row)
        row = cur:fetch({}, "a")
    end
    return lessons
end

-- Create a function to insert a new lesson into the database
local function insertLesson(title, description, code)
    local cur = con:execute("INSERT INTO lessons (title, description, code) VALUES (?, ?, ?)", title, description, code)
    con:commit()
    return cur:fetch({}, "a")
end

-- Close the database connection
con:close()
env:close()
```