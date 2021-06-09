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

addResourcePath("www", "www")

config.file <- "app2.yaml"
config <- yaml.load(readLines(config.file))
words <- config$words
tbl.config <- do.call(rbind,
                      lapply(words,
                             function(word) as.data.frame(word, stringsAsFactors=FALSE)
                      ))

playsound.01 <- "document.getElementById('sound_1').play();"
playsound.02 <- "document.getElementById('sound_2').play();"
playsound.03 <- "document.getElementById('sound_3').play();"
playsound.04 <- "document.getElementById('sound_4').play();"
playsound.05 <- "document.getElementById('sound_5').play();"
playsound.06 <- "document.getElementById('sound_6').play();"
playsound.07 <- "document.getElementById('sound_7').play();"
playsound.08 <- "document.getElementById('sound_8').play();"
playsound.09 <- "document.getElementById('sound_9').play();"
playsound.10 <- "document.getElementById('sound_10').play();"

ui <-  
  fluidPage(
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
                         #playCheers {
                         background-color: #c7fcdb;
                         }
                         #playBoos {
                         background-color: #f7b2d0;
                         }
                          #playBillTell {
                         background-color: #c56ef0;
                         }
                         #playHens {
                         background-color: #fffa6e;
                         }
                         #playStarWars {
                         background-color: #73c0ff;
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
      
      # try https://stackoverflow.com/questions/39250200/rshiny-textoutput-and-paragraph-on-same-line
      
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
        
        tags$button(id="b1", type="button", onclick=playsound.01, "KC and Sunshine!"),
        tags$button(id="b2", type="button", onclick=playsound.02, "Disco Luke"),
        tags$button(id="b3", type="button", onclick=playsound.03, "Bill Tell"),
        tags$button(id="b4", type="button", onclick=playsound.04, "It's All Right"),
        tags$button(id="b5", type="button", onclick=playsound.05, "You Got That Right"),
        br(),
        br(),
        tags$button(id="b6", type="button", onclick=playsound.06, "John and Darryl"),
        tags$button(id="b7", type="button", onclick=playsound.07, "No, No, No!"),
        tags$button(id="b8", type="button", onclick=playsound.08, "I'm Sorry"),
        tags$button(id="b9", type="button", onclick=playsound.09, "Vadar"),
        tags$button(id="b10", type="button", onclick=playsound.10, "Trombones"),
        
        tags$audio(id="sound_1", src="www/thats_the_way.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_2", src="www/star_wars.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_3", src="www/bill_tell.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_4", src="www/its_all_right.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_5", src="www/you_got_that_right.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_6", src="www/i_cant_go_for_that.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_7", src="www/cant_buy_me_love.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_8", src="www/im_sorry.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_9", src="www/imperial_march.mp3", type="audio/mp3", preload="auto"),
        tags$audio(id="sound_10", src="www/fail_trombone.mp3", type="audio/mp3", preload="auto"),
        
        # br(),
        # br(),
        # 
        # actionButton("playCheers",
        #              "Cheers"),
        # br(),
        # br(),
        # actionButton("playBoos",
        #              "Boos"),
        # br(),
        # br(),
        # actionButton("playBillTell",
        #              "Bill Tell"),
        # br(),
        # br(),
        # actionButton("playHens",
        #              "Hens"),
        # br(),
        # br(),
        # actionButton("playStarWars",
        #              "Disco Luke"),
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
  
  output$wordOutput = renderUI(wordRe())
  output$pronunciationOutput = renderUI(pronunciationRe())
  output$wordOriginOutput = renderUI(wordOriginRe())
  output$partOfSpeechOutput = renderUI(partOfSpeechRe())
  output$definitionOutput = renderUI(definitionRe())
  output$exampleSentenceOutput = renderUI(sentenceRe())
  
  observeEvent(input$selectLevelOneWord, ignoreInit=TRUE, {
    
    choice <- sample(1:19, 1)
    
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
    
    choice <- sample(1:16, 1)
    
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
    
    choice <- sample(1:12, 1)
    
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
  
  observeEvent(input$playCheers, {
    removeUI("#currentSound")
    insertUI(selector = "#playCheers",
             where = "afterEnd",
             ui = tags$audio(src = "www/applause.wav", 
                             type = "audio/wav",
                             preload = "metadata",
                             autoplay = TRUE, 
                             controls = NA, 
                             style = "display:none;")
    )
  })
  
  observeEvent(input$playBoos, {
    removeUI("#currentSound")
    insertUI(selector = "#playBoos",
             where = "afterEnd",
             ui = tags$audio(src = "www/boo.mp3", 
                             type = "audio/mp3", 
                             autoplay = TRUE, 
                             controls = NA, 
                             style = "display:none;")
    )
  })
  
  observeEvent(input$playBillTell, {
    removeUI("#currentSound")
    insertUI(selector = "#playBillTell",
             where = "afterEnd",
             ui = tags$audio(src = "www/bill_tell.mp3", 
                             type = "audio/mp3", 
                             autoplay = TRUE, 
                             controls = NA, 
                             style = "display:none;")
    )
  })
  
  observeEvent(input$playHens, {
    removeUI("#currentSound")
    insertUI(selector = "#playHens",
             where = "afterEnd",
             ui = tags$audio(src = "www/hens.mp3", 
                             type = "audio/mp3", 
                             autoplay = TRUE, 
                             controls = NA, 
                             style = "display:none;")
    )
  })
  
  observeEvent(input$playStarWars, {
    removeUI("#currentSound")
    insertUI(selector = "#playStarWars",
             where = "afterEnd",
             ui = tags$audio(src = "www/star_wars.mp3", 
                             type = "audio/mp3", 
                             autoplay = TRUE, 
                             controls = NA, 
                             style = "display:none;")
    )
  })
}

shinyApp(ui <- ui, server <- server)