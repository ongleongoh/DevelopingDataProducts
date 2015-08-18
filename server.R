shinyServer(function(input, output) {
## k means ===============================================================
    color = (c('red', 'blue', 'green',' brown','orange','purple'))
    palette(color)
     selectedData <- reactive({
          iris[, c(input$xcol, input$ycol)]
     })
     
     clusters <- reactive({
          kmeans(selectedData(), input$clusters)
     })
     
     output$k_plot <- renderPlot({
          par(mfrow = c(1, 2))
          par(mar = c(5.1, 4.1, 1.5, 1))
          plot(selectedData(),
               col = clusters()$cluster,
               pch = 20, cex = 2)
          points(clusters()$centers, pch = 4, cex = 2, lwd = 3)
          title("k means", cex.main = 1.2,   font.main= 4, col.main= "blue")
          legend('bottomright', names(a)[-1] , legend =  paste("cluster ",sort(unique(clusters()$cluster))),inset=.05,
                 col=color, bty='n', cex=.9, pch = 19)
          
          plot(selectedData(),
               col = iris$Species,
               pch = 20, cex = 2)
          title("Scatter Plot", cex.main = 1.2,   font.main= 4, col.main= "blue")
          legend('bottomright', names(a)[-1] , legend =  unique(iris$Species),inset=.05,
                 col=color, bty='n', cex=.9, pch = 19)
     })
## Summary ================================================================
     output$summary <- renderPrint({
          summary(iris)
     })
## Structure ==============================================================
     output$str <- renderPrint({
          str(iris)
     })
## table ==================================================================
     output$table <- renderDataTable({
          data <- iris
          if (input$Spec != "All"){
               data <- data[data$Species == input$Spec,]
          }
          data
     })
## Random Forest ==========================================================
     library(ggplot2)
     library(caret)
     library(randomForest)
     library(e1071)
     data(iris)
     
     output$rfScript<- renderPrint({
        lib        <- as.character("library(ggplot2);library(caret);library(randomForest);library(e1071);", sep="")
        dat        <- as.character("data(iris)", sep="")
        inTrain    <- paste("inTrain <- createDataPartition(y=iris$Species, p=",input$decimal,", list=FALSE)", sep="")
        training   <- as.character("training <- iris[inTrain,]", sep="")
        testing    <- as.character("testing <- iris[-inTrain,]", sep="")
        class      <- as.character("class <- training$Species", sep="")
        Traindat   <- as.character("data  <- training[-ncol(training)] # remove the last column(classe)", sep="")
        rf         <- paste("rf <- train(Species~., data=training, method = 'rf', tuneLength = 1, ntree=",input$ntree,")", sep="")
        FinMod     <- as.character("FinMod <- rf$finalModel", sep="")
        PlotVarImp <- as.character("plot(varImp(rf))", sep="")
        VI         <- as.character("varImp(rf)", sep="")
        testPred   <- as.character("testingPred <- predict(rf, newdata=testing)", sep="")
        confMatrix1 <- as.character("confMatrix <- confusionMatrix(testingPred, testing$Species)", sep="")
        confMatrix2 <- as.character("confMatrix", sep="")
        confMatrix3 <- as.character("confMatrix$overall", sep="")

        cat(paste(lib,dat,inTrain,training,testing,class,Traindat,rf,FinMod,PlotVarImp,VI,testPred,confMatrix1,confMatrix2,confMatrix3, sep='\n'))
     })
     output$rfDim <- renderPrint({
         inTrain <- createDataPartition(y=iris$Species, p=input$decimal, list=FALSE)
         training <- iris[inTrain,]
         testing <- iris[-inTrain,]
         tr <- paste("Training set:",dim(training)[1])
         te <- paste("Test set:",dim(testing)[1])
         cat(paste(tr,te, sep='\n'))
     })
     output$FinalMod<- renderPrint({
         inTrain <- createDataPartition(y=iris$Species, p=input$decimal, list=FALSE)
         training <- iris[inTrain,]
         testing <- iris[-inTrain,]
         dim1 = dim(training)[1]
         class <- training$Species
         data  <- training[-ncol(training)] # remove the last column(classe)
         rf <- train(Species~., data=training, method = 'rf', tuneLength = 1, ntree=input$ntree)
         FinMod <- rf$finalModel
         plot(varImp(rf))
         varImp(rf)
         testingPred <- predict(rf, newdata=testing)
         confMatrix <- confusionMatrix(testingPred, testing$Species)
         confMatrix
         confMatrix$overall
         FinMod
     })
     output$VariableImp<- renderPrint({
         inTrain <- createDataPartition(y=iris$Species, p=input$decimal, list=FALSE)
         training <- iris[inTrain,]
         testing <- iris[-inTrain,]
         dim1 = dim(training)[1]
         class <- training$Species
         data  <- training[-ncol(training)] # remove the last column(classe)
         rf <- train(Species~., data=training, method = 'rf', tuneLength = 1, ntree=input$ntree)
         FinMod <- rf$finalModel
         plot(varImp(rf))
         varImp(rf)
         testingPred <- predict(rf, newdata=testing)
         confMatrix <- confusionMatrix(testingPred, testing$Species)
         confMatrix
         confMatrix$overall
         
         varImp(rf)
     }) 
     output$confMatrix<- renderPrint({
         inTrain <- createDataPartition(y=iris$Species, p=input$decimal, list=FALSE)
         training <- iris[inTrain,]
         testing <- iris[-inTrain,]
         dim1 = dim(training)[1]
         class <- training$Species
         data  <- training[-ncol(training)] # remove the last column(classe)
         rf <- train(Species~., data=training, method = 'rf', tuneLength = 1, ntree=input$ntree)
         FinMod <- rf$finalModel
         plot(varImp(rf))
         varImp(rf)
         testingPred <- predict(rf, newdata=testing)
         confMatrix <- confusionMatrix(testingPred, testing$Species)
         confMatrix
         confMatrix$overall
         
         confMatrix
     }) 
     output$k_plot2 <- renderPlot({
         inTrain <- createDataPartition(y=iris$Species, p=input$decimal, list=FALSE)
         training <- iris[inTrain,]
         testing <- iris[-inTrain,]
         dim1 = dim(training)[1]
         class <- training$Species
         data  <- training[-ncol(training)] # remove the last column(classe)
         rf <- train(Species~., data=training, method = 'rf', tuneLength = 1, ntree=input$ntree)
         FinMod <- rf$finalModel
         plot(varImp(rf))
         varImp(rf)
         testingPred <- predict(rf, newdata=testing)
         confMatrix <- confusionMatrix(testingPred, testing$Species)
         confMatrix
         confMatrix$overall
         
         plot(varImp(rf))
     }) 
})


