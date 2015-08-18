library(markdown)
shinyUI(navbarPage("Iris Data",
## Introduction ===============================================================================================                   
                   tabPanel("Introduction",
                            fluidRow(
                                 column(12,
                                        includeMarkdown("Introduction.md")
                                 )
                            )
                   ),
                   navbarMenu("More",
                              tabPanel("Structure",
                                       verbatimTextOutput("str")
                              ),
                              tabPanel("summary",
                                       verbatimTextOutput("summary")
                              )
                   ),
## K mean ======================================================================================================  
                   tabPanel("k mean",
                            sidebarLayout(
                                 sidebarPanel(
                                      h4('Iris k-means clustering Plot'),
                                      selectInput('xcol', 'X axis', names(iris)[1:4], selected=names(iris)[[3]]),
                                      selectInput('ycol', 'Y axis', names(iris)[1:4], selected=names(iris)[[4]]),
                                      numericInput('clusters', 'Cluster count', 3, min = 1, max = 6),
                                      h5('Iris k-means clustering Plot shows how the clusters are been map out.'),
                                      h5('Enable instant comparison against the scatter plot.'),
                                      h5('Change the x or y axis for more comparison. Increase the cluster number to view the mapping.')
                                 ),
                                 mainPanel(
                                      plotOutput('k_plot')
                                 )
                            )
                   ),
## Table ======================================================================================================
                   tabPanel("Table",
                            fluidRow(
                                 column(2, 
                                        selectInput("Spec", 
                                                    "Species :", 
                                                    c("All", 
                                                      unique(as.character(iris$Species))))
                                 )      
                            ),
                            # Create a new row for the table.
                            fluidRow(
                                 dataTableOutput(outputId="table")
                            )
                   ),
## Random Forest ==============================================================================================
                    tabPanel("Random Forest",
                             sidebarLayout(
                                  sidebarPanel(
                                        h4('Random Forest Model'),
                                        sliderInput("decimal", "Training set(%):", 
                                                    min = 0.5, max = 0.9, value = 0.5, step= 0.1),
                                        sliderInput("ntree", "Number of trees(ntree):", 
                                                    min = 1, max = 300, value = 80, step= 1),
                                        h4('User Guide'),
                                        h5('This Shiny Random Forest script allows user to build dynamic R script. 
                                            Adjust the slider above and view the predicted output.'),
                                        h5('Note: It may takes 1 or 2 minutes to run the code.')
                                  ),
                                  mainPanel(
                                        h4("Script Generator"),
                                        verbatimTextOutput('rfScript'),
                                        h4("Training set:Test set ratio"),
                                        verbatimTextOutput('rfDim'),
                                        h4("Final Model"),
                                        verbatimTextOutput('FinalMod'),
                                        h4("rf variable importance"),
                                        verbatimTextOutput('VariableImp'),
                                        h4("variable Important plot"),
                                        plotOutput('k_plot2'),
                                        
                                        h4("Confusion Matrix and Statistics"),
                                        verbatimTextOutput('confMatrix')
                                       
                                  )
                             )
                    ),
## About ======================================================================================================
                   tabPanel("About",
                            fluidRow(
                                 column(12,
                                        includeMarkdown("about.md")
                                 )
                            )
                   )
))