-- Lua Learning Platform
-- Interactive Lua interpreter and tutorial system

local LearningPlatform = {}
LearningPlatform.__index = LearningPlatform

function LearningPlatform:new()
    local instance = {
        lessons = {},
        currentLesson = 1,
        score = 0
    }
    setmetatable(instance, self)
    instance:initLessons()
    return instance
end

function LearningPlatform:initLessons()
    self.lessons = {
        {
            title = "Variables and Data Types",
            content = "Learn about Lua variables and data types",
            exercises = {
                { question = "Create a variable named 'name' with your name", answer = "name" },
                { question = "Create a number variable 'age'", answer = "age" }
            }
        },
        {
            title = "Functions",
            content = "Learn how to create and call functions in Lua",
            exercises = {
                { question = "Create a function that adds two numbers", answer = "function" }
            }
        },
        {
            title = "Tables",
            content = "Master Lua's powerful table data structure",
            exercises = {
                { question = "Create a table with three elements", answer = "table" }
            }
        }
    }
end

function LearningPlatform:displayLesson(lessonNum)
    local lesson = self.lessons[lessonNum]
    if not lesson then
        print("Lesson not found!")
        return
    end
    
    print(string.rep("=", 50))
    print("Lesson " .. lessonNum .. ": " .. lesson.title)
    print(string.rep("=", 50))
    print(lesson.content)
    print()
end

function LearningPlatform:runExercise(lessonNum, exerciseNum)
    local lesson = self.lessons[lessonNum]
    if not lesson then return end
    
    local exercise = lesson.exercises[exerciseNum]
    if not exercise then return end
    
    print("Exercise: " .. exercise.question)
    print("Your code:")
end

function LearningPlatform:checkAnswer(code, expectedKeyword)
    if string.find(code, expectedKeyword) then
        self.score = self.score + 10
        print("✓ Correct! Score: " .. self.score)
        return true
    else
        print("✗ Try again!")
        return false
    end
end

-- Main function
function main()
    print("🎓 Welcome to Lua Learning Platform!")
    print("Interactive Lua Tutorial System")
    print()
    
    local platform = LearningPlatform:new()
    
    for i = 1, #platform.lessons do
        platform:displayLesson(i)
    end
    
    print("Total Lessons: " .. #platform.lessons)
    print("Happy Learning! 🚀")
end

main()

return LearningPlatform
