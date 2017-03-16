library(shiny)
library(shinydashboard)
library(shinyBS)
library(e1071)
library(randomForest)
library(caret)
createFolds = caret::createFolds
confusionMatrix = caret::confusionMatrix
