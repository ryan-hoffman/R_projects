library(shiny)
library(R6)
#----------------------------------------------------------------------------------------------------
buttonStyle <- "margin: 5px; margin-right: 0px; font-size: 14px;"

DemoApp = R6Class("DemoApp",

    #--------------------------------------------------------------------------------
    private = list(
                wordList=NULL
                ),

    #--------------------------------------------------------------------------------
    public = list(

        initialize = function(){
           randomText <- function(dummyArgument) paste(sample(c(LETTERS, letters), 10, replace=TRUE), collapse="")
           private$wordList <- unlist(lapply(1:3, randomText))
           },

        #------------------------------------------------------------
        ui = function(){
           fluidPage(
               selectInput("wordSelector", "Choose Word", c("", private$wordList)),
               wellPanel(style="margin-top: 200px; width: 300px",
                   h4("your choice: "),
                   div(verbatimTextOutput("currentWordDisplay", placeholder=TRUE))
                   )
              )},

        #------------------------------------------------------------
        server = function(input, output, session){

            printf("entering server")

            observeEvent(input$wordSelector, ignoreInit=TRUE, {
               word <- isolate(input$wordSelector)
               if(nchar(word) > 0){
                  output$currentWordDisplay <- renderText(word)
                  indexOfChosenWord <- grep(word, private$wordList)
                  private$wordList <- private$wordList[-indexOfChosenWord]
                  updateSelectInput(session, "wordSelector", choices = c("", private$wordList), selected="")
                  }
              })
            } # server

       ) # public
    ) # class
#--------------------------------------------------------------------------------
app <- DemoApp$new()
x <- shinyApp(app$ui, app$server)
runApp(x, port=1156)

