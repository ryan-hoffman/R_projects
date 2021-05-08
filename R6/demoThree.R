library(shiny)
library(yaml)
library(R6)

demoOneApp = R6Class("demoOneApp",

                     private = list(
                       newWordList = NULL
                     ),

                     public = list(

                       initialize = function(){
                         config = yaml.load(readLines("demoTwo.yaml"))
                         wordList <- config$wordList
                         tbl.config <- do.call(rbind,
                                               lapply(wordList,
                                                      function(word) as.data.frame(word, stringsAsFactors=FALSE)))
                         newWords = tbl.config$word
                         private$newWordList <- newWords
                         },

                       ui = function(){
                         fluidPage(
                           selectInput("wordList",
                                       "Words",
                                       choices = c(" ", private$newWordList)
                           ),
                           br(),
                           br(),
                           br(),
                           br(),
                           br(),
                           br(),
                           br(),
                           br(),

                           textOutput("selectedWord"),
                         )},

                       server = function(input, output, session){

                         wordListChoice <- reactiveVal()

                         observeEvent(input$wordList, ignoreInit=TRUE, {
                           wordChoice <- isolate(input$wordList)
                           wordListChoice(wordChoice)

                           wordChoiceIndex <- grep(wordChoice, private$newWordList)
                           private$newWordList <- private$newWordList[-wordChoiceIndex]
                           updateSelectInput(session, "wordList", choices = c(" ", private$newWordList), selected="")
                         })

                         output$selectedWord <- renderText(wordListChoice())
                       }

                     ),
) # class

app <- demoOneApp$new()
x <- shinyApp(app$ui, app$server)
runApp(x)


