library(shiny)
library(yaml)
library(R6)
#addResourcePath("www", "www")

demoTwoApp = R6Class("demoTwoApp",
                     
                     private = list(
                       newWordList = NULL
                     ),
                     
                     public = list(
                       
                       initialize = function(){
                         
                         config.file <- "demoTwo.yaml"
                         config <- yaml.load(readLines(config.file))
                         wordList <- config$wordList
                         tbl.config <- do.call(rbind,
                                               lapply(wordList,
                                                      function(word) as.data.frame(word, stringsAsFactors=FALSE)
                                               ))
                         #the problem is here, I think
                         extractedWordList <- subset(tbl.config, word==word)$word
                         private$newWordList = unlist(extractedWordList)
                       },
                       
                       ui = function(){
                         fluidPage(
                           actionButton("selectWord",
                                        "Select a Word"),
                           
                           textOutput("selectedWordText")
                         )
                       },
                       
                       server = function(input, output, session){
                         
                         choice = sample(1:4, 1)
                         
                         #selectedWordRe <- reactiveVal()
                         
                         observeEvent(input$selectWord, ignoreInit=TRUE, {
                           selectedWord <- subset(tbl.config, index==choice)$word
                           #selectedWordRe(selectedWord)
                           output$selectedWordText <- renderText(selectedWord)
                         })
                         
                         
                       }
                     ), #public
) #R6

app <- demoTwoApp$new()
x <- shinyApp(app$ui, app$server)
runApp(x)