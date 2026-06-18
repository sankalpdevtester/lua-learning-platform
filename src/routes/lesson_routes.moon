import LessonController from src.controllers.lesson_controller
import express from require "express"
import router from express.Router

router.get "/lessons", LessonController.getLessons
router.get "/lessons/:id", LessonController.getLesson
router.post "/lessons", LessonController.createLesson
router.put "/lessons/:id", LessonController.updateLesson
router.delete "/lessons/:id", LessonController.deleteLesson

router.get "/project-ideas", LessonController.getProjectIdeas
router.get "/project-ideas/:id", LessonController.getProjectIdea
router.post "/project-ideas", LessonController.createProjectIdea
router.put "/project-ideas/:id", LessonController.updateProjectIdea
router.delete "/project-ideas/:id", LessonController.deleteProjectIdea

export default router