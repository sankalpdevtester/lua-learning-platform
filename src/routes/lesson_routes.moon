import LessonController from src.controllers.lesson_controller
import express from luvit.express

lessonRoutes = express.Router()

lessonRoutes.get "/lessons", LessonController.getLessons
lessonRoutes.get "/lessons/:id", LessonController.getLesson
lessonRoutes.post "/lessons", LessonController.createLesson
lessonRoutes.put "/lessons/:id", LessonController.updateLesson
lessonRoutes.delete "/lessons/:id", LessonController.deleteLesson

export default lessonRoutes