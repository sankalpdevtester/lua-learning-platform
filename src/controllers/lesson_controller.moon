import Lesson from src.models
import User from src.models
import db from src.utils

class LessonController
  @getLessons: (req, res) =>
    db.query "SELECT * FROM lessons", (err, results) ->
      if err
        res\send { error: "Failed to retrieve lessons" }
      else
        res\send results

  @getLesson: (req, res) =>
    lesson_id = req.params.id
    db.query "SELECT * FROM lessons WHERE id = ?", { lesson_id }, (err, results) ->
      if err
        res\send { error: "Failed to retrieve lesson" }
      else
        res\send results[1]

  @createLesson: (req, res) =>
    lesson = req.body
    db.query "INSERT INTO lessons SET ?", lesson, (err, results) ->
      if err
        res\send { error: "Failed to create lesson" }
      else
        res\send { message: "Lesson created successfully" }

  @updateLesson: (req, res) =>
    lesson_id = req.params.id
    lesson = req.body
    db.query "UPDATE lessons SET ? WHERE id = ?", { lesson, lesson_id }, (err, results) ->
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

  @getProjectIdeas: (req, res) =>
    db.query "SELECT * FROM project_ideas", (err, results) ->
      if err
        res\send { error: "Failed to retrieve project ideas" }
      else
        res\send results

  @getProjectIdea: (req, res) =>
    project_id = req.params.id
    db.query "SELECT * FROM project_ideas WHERE id = ?", { project_id }, (err, results) ->
      if err
        res\send { error: "Failed to retrieve project idea" }
      else
        res\send results[1]

  @createProjectIdea: (req, res) =>
    project_idea = req.body
    db.query "INSERT INTO project_ideas SET ?", project_idea, (err, results) ->
      if err
        res\send { error: "Failed to create project idea" }
      else
        res\send { message: "Project idea created successfully" }

  @updateProjectIdea: (req, res) =>
    project_id = req.params.id
    project_idea = req.body
    db.query "UPDATE project_ideas SET ? WHERE id = ?", { project_idea, project_id }, (err, results) ->
      if err
        res\send { error: "Failed to update project idea" }
      else
        res\send { message: "Project idea updated successfully" }

  @deleteProjectIdea: (req, res) =>
    project_id = req.params.id
    db.query "DELETE FROM project_ideas WHERE id = ?", { project_id }, (err, results) ->
      if err
        res\send { error: "Failed to delete project idea" }
      else
        res\send { message: "Project idea deleted successfully" }