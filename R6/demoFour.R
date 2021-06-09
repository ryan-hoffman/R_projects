library(shiny)
library(yaml)
library(R6)
addResourcePath("www", "www")

config.file <- "demoFour.yaml"
config <- yaml.load(readLines(config.file))
wordList <- config$wordList
tbl.config <- do.call(rbind,
                      lapply(wordList,
                             function(word) as.data.frame(word, stringsAsFactors=FALSE)
                      ))

demoFourApp = R6Class("demoFourApp", lock_objects = FALSE,
                     
                     private = list(
                       newWordListOne = NULL,
                       newWordListTwo = NULL,
                       newWordListThree = NULL
                     ),
                     
                     public = list(
                       
                       newWordsOne = NULL,
                       newWordsTwo = NULL,
                       newWordsThree = NULL,
                       
                       initialize = function(newWordsOne,
                                             newWordsTwo,
                                             newWordsThree)
                       {
                         newWordsOne <- subset(tbl.config, level=="one")$word
                         newWordsTwo <- subset(tbl.config, level=="two")$word
                         newWordsThree <- subset(tbl.config, level=="three")$word
                         private$newWordListOne <- newWordsOne
                         private$newWordListTwo <- newWordsTwo
                         private$newWordListThree <- newWordsThree
                       },
                       
                       ui = function(){
                         fluidPage(
                           tags$head(
                             tags$link(rel = "stylesheet", type = "text/css", href = "www/style.css")
                           ), 
                           
                           titlePanel(h1(id="title", "Spelling Bee", align="center"), windowTitle="Spelling Bee"),
                           br(),
                           br(),
                           sidebarLayout(
                             sidebarPanel(id="sidebar", width=3, align="center",
                                          actionButton("levelOne",
                                                       "Level 1"),
                                          br(),
                                          br(),
                                          actionButton("levelTwo",
                                                       "Level 2"),
                                          br(),
                                          br(),
                                          actionButton("levelThree",
                                                       "Level 3"),
                                          br(),
                                          br(),
                             ), #sidebarPanel
                             
                             mainPanel(
                               div(id="wordContainer", h3(id="word", " "),
                                   textOutput("selectedWordText")),
                               br(),
                               br(),
                               h6(id="pronunciation", "Pronunciation:"),
                               textOutput("pronunciationText"),
                               br(),
                               h6(id="wordOrigin", "Word Origin:"),
                               textOutput("wordOriginText"),
                               br(),
                               h6(id="partOfSpeech", "Part of Speech:"),
                               textOutput("partOfSpeechText"),
                               br(),
                               h6(id="definition", "Definition:"),
                               textOutput("definitionText"),
                               br(),
                               h6(id="exampleSentence", "Example Sentence:"),
                               textOutput("exampleSentenceText"),
                               br(),
                               br(),
                               br(),
                               div(id="buttonContainer",
                                   actionButton("correct",
                                                "Correct"),
                                   actionButton("incorrect",
                                                "Incorrect"),
                               ),
                               
                             ), #mainPanel
                           ), #sidebarLayout
                         ) #fluidPage
                       }, #ui_function
                       
                       server = function(input, output, session){
                         
                         numRe <- reactiveVal()
                         newListRe <- reactiveVal()
                         selectedWordRe <- reactiveVal()
                         pronunciationRe <- reactiveVal()
                         wordOriginRe <- reactiveVal()
                         partOfSpeechRe <- reactiveVal()
                         definitionRe <- reactiveVal()
                         exampleSentenceRe <- reactiveVal()
                         
                         output$selectedWordText <- renderText(selectedWordRe())
                         output$pronunciationText <- renderText(pronunciationRe())
                         output$wordOriginText <- renderText(wordOriginRe())
                         output$partOfSpeechText <- renderText(partOfSpeechRe())
                         output$definitionText <- renderText(definitionRe())
                         output$exampleSentenceText <- renderText(exampleSentenceRe())
                         
                         observeEvent(input$levelOne, ignoreInit=TRUE, {
                           
                           num <- length(private$newWordListOne)
                           newListRe(private$newWordListOne)
                           numRe(num)
                           choice = sample(1:numRe(), 1)
                           
                           if (num == 0){
                             selectedWord <- "Word list exhausted."
                             selectedWordRe(selectedWord)
                             pronunciation <- " "
                             pronunciationRe(pronunciation)
                             wordOrigin <- " "
                             wordOriginRe(wordOrigin)
                             partOfSpeech <- " "
                             partOfSpeechRe(partOfSpeech)
                             definition <- " "
                             definitionRe(definition)
                             exampleSentence <- " "
                             exampleSentenceRe(exampleSentence)
                           }
                           else {
                             
                             selectedWord <- newListRe()[choice]
                             selectedWordRe(selectedWord)
                             
                             pronunciation <- subset(tbl.config, word==selectedWord)$pronunciation
                             pronunciationRe(pronunciation)
                             
                             wordOrigin <- subset(tbl.config, word==selectedWord)$wordOrigin
                             wordOriginRe(wordOrigin)
                             
                             partOfSpeech <- subset(tbl.config, word==selectedWord)$partOfSpeech
                             partOfSpeechRe(partOfSpeech)
                             
                             definition <- subset(tbl.config, word==selectedWord)$definition
                             definitionRe(definition)
                             
                             exampleSentence <- subset(tbl.config, word==selectedWord)$exampleSentence
                             exampleSentenceRe(exampleSentence)
                             
                             wordChoiceIndex <- grep(selectedWord, private$newWordListOne)
                             private$newWordListOne <- private$newWordListOne[-wordChoiceIndex]
                           }
                         })
                         
                         observeEvent(input$levelTwo, ignoreInit=TRUE, {
                           
                           num <- length(private$newWordListTwo)
                           newListRe(private$newWordListTwo)
                           numRe(num)
                           choice = sample(1:numRe(), 1)
                           
                           if (num == 0){
                             selectedWord <- "Word list exhausted."
                             selectedWordRe(selectedWord)
                             pronunciation <- " "
                             pronunciationRe(pronunciation)
                             wordOrigin <- " "
                             wordOriginRe(wordOrigin)
                             partOfSpeech <- " "
                             partOfSpeechRe(partOfSpeech)
                             definition <- " "
                             definitionRe(definition)
                             exampleSentence <- " "
                             exampleSentenceRe(exampleSentence)
                           }
                           else {
                             
                             selectedWord <- newListRe()[choice]
                             selectedWordRe(selectedWord)
                             
                             pronunciation <- subset(tbl.config, word==selectedWord)$pronunciation
                             pronunciationRe(pronunciation)
                             
                             wordOrigin <- subset(tbl.config, word==selectedWord)$wordOrigin
                             wordOriginRe(wordOrigin)
                             
                             partOfSpeech <- subset(tbl.config, word==selectedWord)$partOfSpeech
                             partOfSpeechRe(partOfSpeech)
                             
                             definition <- subset(tbl.config, word==selectedWord)$definition
                             definitionRe(definition)
                             
                             exampleSentence <- subset(tbl.config, word==selectedWord)$exampleSentence
                             exampleSentenceRe(exampleSentence)
                             
                             wordChoiceIndex <- grep(selectedWord, private$newWordListTwo)
                             private$newWordListTwo <- private$newWordListTwo[-wordChoiceIndex]
                           }
                         })
                         
                         observeEvent(input$levelThree, ignoreInit=TRUE, {
                           
                           num <- length(private$newWordListThree)
                           newListRe(private$newWordListThree)
                           numRe(num)
                           choice = sample(1:numRe(), 1)
                           
                           if (num == 0){
                             selectedWord <- "Word list exhausted."
                             selectedWordRe(selectedWord)
                             pronunciation <- " "
                             pronunciationRe(pronunciation)
                             wordOrigin <- " "
                             wordOriginRe(wordOrigin)
                             partOfSpeech <- " "
                             partOfSpeechRe(partOfSpeech)
                             definition <- " "
                             definitionRe(definition)
                             exampleSentence <- " "
                             exampleSentenceRe(exampleSentence)
                           }
                           else {
                             
                             selectedWord <- newListRe()[choice]
                             selectedWordRe(selectedWord)
                             
                             pronunciation <- subset(tbl.config, word==selectedWord)$pronunciation
                             pronunciationRe(pronunciation)
                             
                             wordOrigin <- subset(tbl.config, word==selectedWord)$wordOrigin
                             wordOriginRe(wordOrigin)
                             
                             partOfSpeech <- subset(tbl.config, word==selectedWord)$partOfSpeech
                             partOfSpeechRe(partOfSpeech)
                             
                             definition <- subset(tbl.config, word==selectedWord)$definition
                             definitionRe(definition)
                             
                             exampleSentence <- subset(tbl.config, word==selectedWord)$exampleSentence
                             exampleSentenceRe(exampleSentence)
                             
                             wordChoiceIndex <- grep(selectedWord, private$newWordListThree)
                             private$newWordListThree <- private$newWordListThree[-wordChoiceIndex]
                           }
                         })
                         
                         # add sounds and random selector code, however, won't work in safari (probably)
                         observeEvent(input$correct, {
                           choice = sample(1:5, 1)
                           soundChoice = switch(choice,
                                                "www/bill_tell.mp3",
                                                "www/thats_the_way.mp3",
                                                "www/you_got_that_right.mp3",
                                                "www/applause.mp3",
                                                "www/star_wars.mp3")
                           
                           removeUI("correctSound")
                           insertUI(selector = "#correct",
                                    where = "afterEnd",
                                    ui = tags$audio(id="currentSound", 
                                                    src=soundChoice,
                                                    type="audio/mp3",
                                                    autoplay=TRUE,
                                                    controls=NA,
                                                    style="display:none;"
                                    ) 
                           ) #insertUI
                         })
                         
                         observeEvent(input$incorrect, {
                           choice = sample(1:5, 1)
                           soundChoice = switch(choice,
                                                "www/cant_buy_me_love.mp3",
                                                "www/i_cant_go_for_that.mp3",
                                                "www/im_sorry.mp3",
                                                "www/fail_trombone.mp3",
                                                "www/desc_whistle.mp3")
                           
                           removeUI("correctSound")
                           insertUI(selector = "#incorrect",
                                    where = "afterEnd",
                                    ui = tags$audio(id="currentSound", 
                                                    src=soundChoice,
                                                    type="audio/mp3",
                                                    autoplay=TRUE,
                                                    controls=NA,
                                                    style="display:none;"
                                    ) 
                           ) #insertUI
                         })
                         
                       }
                     ), #public
) #R6

app <- demoFourApp$new()
x <- shinyApp(app$ui, app$server)
runApp(x)