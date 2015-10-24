library(randomForest)  # for deploying it to shinyapp.io
library(shiny)
library(ggplot2)
library(dplyr)
library(caret)

# The below is how to build the prediction model and split Wage dataset:
# 
# set.seed(1234)
# 
# Wage <- subset(Wage, select=-c(logwage, sex, region))
# inTrain <- createDataPartition(y=Wage$wage, p=0.6, list=FALSE)
# training <- Wage[inTrain, ]
# testing <- Wage[-inTrain, ]
# 
# model_fit <- train(wage ~ ., data=training, method="rf",
#                    trControl=trainControl(method="cv", number=5),
#                    allowParallel=TRUE, verbose=FALSE, importance=TRUE)  # making variable importance information
# 
# saveRDS(model_fit, filename)
# saveRDS(Wage, "wage.rds")
# saveRDS(training, "training.rds")
# saveRDS(testing, "testing.rds")

set.seed(1234)

model_fit <- readRDS("model_fit.rds")  # too slow to build the prediction model on starting up
varimp <- varImp(model_fit)

wage <- readRDS("wage.rds")  # Wage dataset
training <- readRDS("training.rds")  # training dataset
testing <- readRDS("testing.rds")  # testing dataset

shinyServer(function(input, output) {
        output$expectedWage <- renderPrint({
                x <- data.frame(
                        year = input$year,
                        age = input$age,
                        maritl = input$marriage,
                        race = input$race,
                        education = input$education,
                        jobclass = input$jobclass,
                        health = input$health,
                        health_ins = input$health_ins
                )
                predict(model_fit, x)
        })
        output$plotDensity <- renderPlot({
                
                if (input$densityKind == "marriage") {
                        return(qplot(wage, color=maritl, data=wage, geom="density"))
                } else if (input$densityKind == "race") {
                        return(qplot(wage, color=race, data=wage, geom="density"))
                } else if (input$densityKind == "education") {
                        return(qplot(wage, color=education, data=wage, geom="density"))
                } else if (input$densityKind == "jobclass") {
                        return(qplot(wage, color=jobclass, data=wage, geom="density"))
                } else if (input$densityKind == "health") {
                        return(qplot(wage, color=health, data=wage, geom="density"))
                } else if (input$densityKind == "health_ins") {
                        return(qplot(wage, color=health_ins, data=wage, geom="density"))
                }
        })
        output$varImp <- renderPlot({
                plot(varimp)
        })
        output$varImp2 <- renderPrint({
                varimp
        })
        output$plotWage <- renderPlot({
                qplot(predict(model_fit, testing), wage, data = testing)
        })
})