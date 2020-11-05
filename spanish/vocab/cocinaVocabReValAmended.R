library(shiny)
library(yaml)

cocinaVocab <- yaml.load(readLines("cocinaVocabReVal.yaml"))

ui <- fluidPage(
  br(),
  actionButton("palabra",
               "Seleccionar una palabra"),
  br(),
  br(),
  textOutput("palabraOutput"),
  br(),
  actionButton("traducir",
               "Traducir"),
  br(),
  br(),
  textOutput("traducirOutput"),
  br(),
  actionButton("reajustar",
               "Reajustar")
)

server <- function(input,output) {
  
  palabraRe <- reactiveVal()
  traducirRe <- reactiveVal()
  # randChoice <- reactiveVal() not necessary
  
  observeEvent(input$palabra, {
    choice <- sample(1:9, 1)
    # randChoice(choice) eliminated and replaced randChoice() with choice variable
    palabraChoice <- names(cocinaVocab[choice])
    palabraRe(palabraChoice)
    # added to display empty string instead of translated word
    traducirRe(" ")
  })
  
  # separated the functionality of the observeEvent()s
  
  observeEvent(input$traducir, {
    # replaced palabraChoice with palabraRe() 
    palabraTraducir <- cocinaVocab[[palabraRe()]]
    traducirRe(palabraTraducir)
  })
  
  observeEvent(input$reajustar, {
    # choice <- 1 - not necessary
    # palabraChoice <- names(cocinaVocab[choice]) - not necessary
    # replaced palabraChoice with " "
    palabraRe(" ")
    # palabraTraducir <- cocinaVocab[[palabraChoice]] - not necessary
    # replaced palabraTraducir with " "
    traducirRe(" ")
  })
  
  output$palabraOutput <- renderText(palabraRe())
  output$traducirOutput <- renderText(traducirRe())
}

shinyApp(ui = ui, server = server)