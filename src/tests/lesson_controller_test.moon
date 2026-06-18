import LessonController from src.controllers.lesson_controller
import db from src.utils
import assert from require "assert"

describe "LessonController", ->
  before (done) ->
    db.query "CREATE TABLE IF NOT EXISTS lessons (id INT PRIMARY KEY, name VARCHAR(255))", (err) ->
      db.query "CREATE TABLE IF NOT EXISTS project_ideas (id INT PRIMARY KEY, name VARCHAR(255))", (err) ->
        done()

  after (done) ->
    db.query "DROP TABLE lessons", (err) ->
      db.query "DROP TABLE project_ideas", (err) ->
        done()

  it "should get all lessons", (done) ->
    LessonController.getLessons {}, (res) ->
      assert.equal res.status, 200
      done()

  it "should get a lesson", (done) ->
    db.query "INSERT INTO lessons SET ?", { id: 1, name: "Test Lesson" }, (err) ->
      LessonController.getLesson { params: { id: 1 } }, (res) ->
        assert.equal res.status, 200
        done()

  it "should create a lesson", (done) ->
    LessonController.createLesson { body: { name: "Test Lesson" } }, (res) ->
      assert.equal res.status, 200
      done()

  it "should update a lesson", (done) ->
    db.query "INSERT INTO lessons SET ?", { id: 1, name: "Test Lesson" }, (err) ->
      LessonController.updateLesson { params: { id: 1 }, body: { name: "Updated Test Lesson" } }, (res) ->
        assert.equal res.status, 200
        done()

  it "should delete a lesson", (done) ->
    db.query "INSERT INTO lessons SET ?", { id: 1, name: "Test Lesson" }, (err) ->
      LessonController.deleteLesson { params: { id: 1 } }, (res) ->
        assert.equal res.status, 200
        done()

  it "should get all project ideas", (done) ->
    LessonController.getProjectIdeas {}, (res) ->
      assert.equal res.status, 200
      done()

  it "should get a project idea", (done) ->
    db.query "INSERT INTO project_ideas SET ?", { id: 1, name: "Test Project Idea" }, (err) ->
      LessonController.getProjectIdea { params: { id: 1 } }, (res) ->
        assert.equal res.status, 200
        done()

  it "should create a project idea", (done) ->
    LessonController.createProjectIdea { body: { name: "Test Project Idea" } }, (res) ->
      assert.equal res.status, 200
      done()

  it "should update a project idea", (done) ->
    db.query "INSERT INTO project_ideas SET ?", { id: 1, name: "Test Project Idea" }, (err) ->
      LessonController.updateProjectIdea { params: { id: 1 }, body: { name: "Updated Test Project Idea" } }, (res) ->
        assert.equal res.status, 200
        done()

  it "should delete a project idea", (done) ->
    db.query "INSERT INTO project_ideas SET ?", { id: 1, name: "Test Project Idea" }, (err) ->
      LessonController.deleteProjectIdea { params: { id: 1 } }, (res) ->
        assert.equal res.status, 200
        done()