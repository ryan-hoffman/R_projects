# Spelling Bee Rules:

# alternate pronunciations
# definition
# part of speech
# language of origin
# use in a sentence
# pronounced again

#------------------------------------------------------------------

# Possible app functionality:

# allow words to be only selected once per session
# create and enable sound buttons
# possibly tally scores

#------------------------------------------------------------------

# Questions

# conditional panel to hide descriptive words on mainPanel?
# add descriptive words to server?
# radio buttons for level selection?
# uiOutput vs textOutput
# when is addResourcePath() necessary?
# possibly make server code more efficient?
# is config.file simply a variable or does the .file have a function?

#------------------------------------------------------------------

# ToDo

# add more words

#------------------------------------------------------------------

library(shiny)
library(yaml)

# setBackgroundColor()
library(shinyWidgets)

# use_googlefont()
library(fresh)

config.file <- "app.yaml"
config <- yaml.load(readLines(config.file))
words <- config$words
tbl.config <- do.call(rbind,
                      lapply(words,
                             function(word) as.data.frame(word, stringsAsFactors=FALSE)
                      ))

ui <-  
  fluidPage(
    # using separate css file ultimately might be better
    # css adds modifies the layout, adds color, changes the font and makes some things display inline 
    tags$head(tags$style("#word-container * {
                         display:inline;
                         } 
                         #content-container * {
                         display:inline;
                         }
                         #sidebar {
                         background-color: #d6c681;
                         }
                         #selectLevelOneWord, #selectLevelTwoWord, #selectLevelThreeWord {
                         background-color: #fff6c9;
                         }
                         #title, #selectLevelOneWord, #selectLevelTwoWord, #selectLevelThreeWord,
                         #word, #wordOutput, #pronunciation, #pronunciationOutput, #wordOrigin, 
                         #wordOriginOutput, #part_of_speech, #partOfSpeechOutput, #definition, 
                         #definitionOutput, #example_sentence, #exampleSentenceOutput, #playCorrectSound, 
                         #playIncorrectSound {
                         font-family: Yusei Magic, sans-serif;
                         }
                         #playCorrectSound {
                         background-color: #c7fcdb;
                         }
                         #playIncorrectSound {
                         background-color: #f7b2d0;
                         }
                         #word {
                         padding-right: 100px;
                         }
                         #pronunciation {
                         padding-right: 40px;
                         }
                         #wordOrigin {
                         padding-right: 54px;
                         }
                         #part_of_speech {
                         padding-right: 30px;
                         }"
    )),
    
    setBackgroundColor("#fff6c9"),
    use_googlefont("Yusei Magic"),
    titlePanel(h1(id="title", "Spelling Bee", align="center"), windowTitle="Spelling Bee"),
    sidebarLayout(
      sidebarPanel(id="sidebar", width=2,
                   
                   actionButton(
                     "selectLevelOneWord",
                     "Level 1"),
                   br(),
                   
                   br(),
                   actionButton(
                     "selectLevelTwoWord",
                     "Level 2"),
                   br(),
                   
                   br(),
                   actionButton(
                     "selectLevelThreeWord",
                     "Level 3")
      ),
      
      mainPanel(
        br(),
        div(id="word-container", 
            h3(id="word", "Word:"),
            uiOutput("wordOutput", style="font-size: 30px; 
                                              font-weight: bold;")),
        br(),
        
        br(),
        div(id="content-container", 
            h5(id="pronunciation", "Pronunciation:"),
            uiOutput("pronunciationOutput", style="font-size: 20px; font-weight: bold;")),
        
        br(),
        div(id="content-container", 
            h5(id="wordOrigin", "Word Origin:"),
            uiOutput("wordOriginOutput", style="font-size: 20px; font-weight: bold;")),
        
        br(),
        div(id="content-container", 
            h5(id="part_of_speech", "Part of Speech:"), 
            uiOutput("partOfSpeechOutput", style="font-size: 20px; font-weight: bold;")),
        
        br(),
        div(h5(id="definition", "Definition:"),
            uiOutput("definitionOutput", style="font-size: 20px; font-weight: bold;")),
        
        br(),
        div(h5(id="example_sentence", "Example sentence:"), 
            uiOutput("exampleSentenceOutput", style="font-size: 20px; font-weight: bold;")),
        br(),
        
        br(),
        actionButton("playCorrectSound",
                     "Correct!"),
        br(),
        
        br(),
        actionButton("playIncorrectSound",
                     "Incorrect!"),
        
        # not functioning at the moment
        uiOutput("playMusic")
      ),
    )
  )

# possibly make server code more efficient?

server <- function(input, output, session) {
  
  wordRe <- reactiveVal()
  pronunciationRe <- reactiveVal()
  wordOriginRe <- reactiveVal()
  partOfSpeechRe <- reactiveVal()
  definitionRe <- reactiveVal()
  sentenceRe <- reactiveVal()
  soundRe <- reactiveVal()
  
  output$wordOutput = renderUI(wordRe())
  output$pronunciationOutput = renderUI(pronunciationRe())
  output$wordOriginOutput = renderUI(wordOriginRe())
  output$partOfSpeechOutput = renderUI(partOfSpeechRe())
  output$definitionOutput = renderUI(definitionRe())
  output$exampleSentenceOutput = renderUI(sentenceRe())
  
  # this doesn't work
  output$playMusic = renderUI(soundRe())
  
  
  observeEvent(input$selectLevelOneWord, ignoreInit=TRUE, {
    
    choice <- sample(1:10, 1)
    
    wordChoice <- subset(tbl.config, index==choice & level=="one")$word
    wordRe(wordChoice)
    
    pronunciationChoice <- subset(tbl.config, word==wordRe())$pronunciation
    pronunciationRe(pronunciationChoice)
    
    wordOriginChoice <- subset(tbl.config, word==wordRe())$wordOrigin
    wordOriginRe(wordOriginChoice)
    
    partOfSpeechChoice <- subset(tbl.config, word==wordRe())$partOfSpeech
    partOfSpeechRe(partOfSpeechChoice)
    
    definitionChoice <- subset(tbl.config, word==wordRe())$definition
    definitionRe(definitionChoice)
    
    sentenceChoice <- subset(tbl.config, word==wordRe())$sentence
    sentenceRe(sentenceChoice)
  })
  
  observeEvent(input$selectLevelTwoWord, ignoreInit=TRUE, {
    
    choice <- sample(1:10, 1)
    
    wordChoice <- subset(tbl.config, index==choice & level=="two")$word
    wordRe(wordChoice)
    
    pronunciationChoice <- subset(tbl.config, word==wordRe())$pronunciation
    pronunciationRe(pronunciationChoice)
    
    wordOriginChoice <- subset(tbl.config, word==wordRe())$wordOrigin
    wordOriginRe(wordOriginChoice)
    
    partOfSpeechChoice <- subset(tbl.config, word==wordRe())$partOfSpeech
    partOfSpeechRe(partOfSpeechChoice)
    
    definitionChoice <- subset(tbl.config, word==wordRe())$definition
    definitionRe(definitionChoice)
    
    sentenceChoice <- subset(tbl.config, word==wordRe())$sentence
    sentenceRe(sentenceChoice)
  })
  
  observeEvent(input$selectLevelThreeWord, ignoreInit=TRUE, {
    
    choice <- sample(1:10, 1)
    
    wordChoice <- subset(tbl.config, index==choice & level=="three")$word
    wordRe(wordChoice)
    
    pronunciationChoice <- subset(tbl.config, word==wordRe())$pronunciation
    pronunciationRe(pronunciationChoice)
    
    wordOriginChoice <- subset(tbl.config, word==wordRe())$wordOrigin
    wordOriginRe(wordOriginChoice)
    
    partOfSpeechChoice <- subset(tbl.config, word==wordRe())$partOfSpeech
    partOfSpeechRe(partOfSpeechChoice)
    
    definitionChoice <- subset(tbl.config, word==wordRe())$definition
    definitionRe(definitionChoice)
    
    sentenceChoice <- subset(tbl.config, word==wordRe())$sentence
    sentenceRe(sentenceChoice)
  })
  
  # This doesn't work
  
  observeEvent(input$playCorrectSound, ignoreInit=TRUE, {
    renderUI(
      #selector="#playCorrectSound",
      soundFile <- tags$audio(src="jive.mp3", type="aucio/mp3", autoplay=NA, controls=NA),
      soundRe(soundFile),
      print("button clicked")
    )
  })
}

shinyApp(ui <- ui, server <- server)