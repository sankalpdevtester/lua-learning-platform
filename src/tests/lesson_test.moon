import LessonController from src.controllers.lesson_controller
import Lesson from src.models.lesson
import db from src.utils
import LuaUnit from luautf8

testLesson = ->
  it "should create a new lesson", ->
    lesson = { title: "Test Lesson", description: "This is a test lesson" }
    LessonController.createLesson { body: lesson }, (res) ->
      assert.are.same res.statusCode, 200
      assert.are.same res.body.message, "Lesson created successfully"

  it "should get all lessons", ->
    LessonController.getLessons {}, (res) ->
      assert.are.same res.statusCode, 200
      assert.are.same #res.body, 1

  it "should get a lesson by id", ->
    lesson_id = 1
    LessonController.getLesson { params: { id: lesson_id } }, (res) ->
      assert.are.same res.statusCode, 200
      assert.are.same res.body.id, lesson_id

  it "should update a lesson", ->
    lesson_id = 1
    lesson = { title: "Updated Test Lesson", description: "This is an updated test lesson" }
    LessonController.updateLesson { params: { id: lesson_id }, body: lesson }, (res) ->
      assert.are.same res.statusCode, 200
      assert.are.same res.body.message, "Lesson updated successfully"

  it "should delete a lesson", ->
    lesson_id = 1
    LessonController.deleteLesson { params: { id: lesson_id } }, (res) ->
      assert.are.same res.statusCode, 200
      assert.are.same res.body.message, "Lesson deleted successfully"

LuaUnit.run()