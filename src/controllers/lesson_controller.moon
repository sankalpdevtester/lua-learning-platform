import Lesson from src.models
import db from src.utils
import validate from src.utils

class LessonController
  @getLessons: (req, res) =>
    db.query "SELECT * FROM lessons", (err, results) ->
      if err
        res\send { error: "Failed to fetch lessons" }
      else
        res\send results

  @getLesson: (req, res) =>
    lesson_id = req.params.id
    db.query "SELECT * FROM lessons WHERE id = ?", { lesson_id }, (err, results) ->
      if err
        res\send { error: "Failed to fetch lesson" }
      else
        res\send results[1]

  @createLesson: (req, res) =>
    lesson = req.body
    validate lesson, (err) ->
      if err
        res\send { error: "Invalid lesson data" }
      else
        db.query "INSERT INTO lessons SET ?", lesson, (err, results) ->
          if err
            res\send { error: "Failed to create lesson" }
          else
            res\send { message: "Lesson created successfully" }

  @updateLesson: (req, res) =>
    lesson_id = req.params.id
    lesson = req.body
    validate lesson, (err) ->
      if err
        res\send { error: "Invalid lesson data" }
      else
        db.query "UPDATE lessons SET ? WHERE id = ?", { lesson }, { lesson_id }, (err, results) ->
          if err
            res\send { error: "Failed to update lesson" }
          else
            res\send { message: "Lesson updated successfully" }

  @deleteLesson: (req, res) =>
    lesson_id = req.params.id
    db.query "DELETE FROM lessons WHERE id = ?", { lesson_id }, (err, results) ->
      if err
        res\send { error: "Failed to delete lesson" }
      else
        res\send { message: "Lesson deleted successfully" }