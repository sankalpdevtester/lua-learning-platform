-- Project Ideas Module
-- This module provides a list of project ideas for users to work on and learn Lua.
-- It includes filtering and sorting functionality to make it easier for users to find projects that suit their interests and skill levels.

local ProjectIdeas = {}
local utils = require("utils")
local models = require("models")

-- Project Idea Model
local ProjectIdea = models.Model:extend({
  name = "",
  description = "",
  difficulty = "",
  tags = {}
})

-- Project Ideas List
local projectIdeas = {
  ProjectIdea:new({
    name = "To-Do List App",
    description = "Create a simple to-do list app that allows users to add, remove, and mark tasks as completed.",
    difficulty = "easy",
    tags = {"beginner", "app"}
  }),
  ProjectIdea:new({
    name = "Game of Life",
    description = "Implement the Game of Life simulation using Lua.",
    difficulty = "medium",
    tags = {"intermediate", "game"}
  }),
  ProjectIdea:new({
    name = "Chatbot",
    description = "Create a simple chatbot that responds to basic user queries.",
    difficulty = "hard",
    tags = {"advanced", "ai"}
  })
}

-- Filtering Function
local function filterProjectIdeas(ideas, query)
  local filteredIdeas = {}
  for _, idea in ipairs(ideas) do
    if utils.stringContains(idea.name, query) or utils.stringContains(idea.description, query) then
      table.insert(filteredIdeas, idea)
    end
  end
  return filteredIdeas
end

-- Sorting Function
local function sortProjectIdeas(ideas, sortBy)
  if sortBy == "name" then
    table.sort(ideas, function(a, b) return a.name < b.name end)
  elseif sortBy == "difficulty" then
    table.sort(ideas, function(a, b) return a.difficulty < b.difficulty end)
  end
  return ideas
end

-- Get Project Ideas Function
local function getProjectIdeas(query, sortBy)
  local ideas = projectIdeas
  if query then
    ideas = filterProjectIdeas(ideas, query)
  end
  if sortBy then
    ideas = sortProjectIdeas(ideas, sortBy)
  end
  return ideas
end

-- Add Project Idea Function
local function addProjectIdea(idea)
  table.insert(projectIdeas, idea)
end

-- Remove Project Idea Function
local function removeProjectIdea(name)
  for i, idea in ipairs(projectIdeas) do
    if idea.name == name then
      table.remove(projectIdeas, i)
      break
    end
  end
end

-- Expose Functions
ProjectIdeas.getProjectIdeas = getProjectIdeas
ProjectIdeas.addProjectIdea = addProjectIdea
ProjectIdeas.removeProjectIdea = removeProjectIdea

return ProjectIdeas