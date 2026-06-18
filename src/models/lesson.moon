import db from src.utils

class Lesson
  @table: "lessons"

  @fields: {
    id: "int"
    title: "varchar(255)"
    description: "text"
    created_at: "timestamp"
    updated_at: "timestamp"
  }

  @createTable: =>
    query = "CREATE TABLE IF NOT EXISTS #{Lesson.table} (
      #{Lesson.fields.id} PRIMARY KEY AUTO_INCREMENT,
      #{Lesson.fields.title},
      #{Lesson.fields.description},
      #{Lesson.fields.created_at} DEFAULT CURRENT_TIMESTAMP,
      #{Lesson.fields.updated_at} DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    )"
    db.query query, (err) ->
      if err
        print "Error creating lessons table: #{err}"

  @validate: (lesson) =>
    errors = {}
    if not lesson.title or #lesson.title < 1
      table.insert errors, "Title is required"
    if not lesson.description or #lesson.description < 1
      table.insert errors, "Description is required"
    return errors