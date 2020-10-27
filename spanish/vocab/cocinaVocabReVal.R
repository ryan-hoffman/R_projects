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
  randChoice <- reactiveVal()
  
  observeEvent(input$palabra, {
    choice <- sample(1:9, 1)
    randChoice(choice)
    palabraChoice <- names(cocinaVocab[randChoice()])
    palabraRe(palabraChoice)
    
    observeEvent(input$traducir, {
      palabraTraducir <- cocinaVocab[[palabraChoice]]
      traducirRe(palabraTraducir)
    })
  })
  observeEvent(input$reajustar, {
    choice <- 1
    palabraChoice <- names(cocinaVocab[choice])
    palabraRe(palabraChoice)
    palabraTraducir <- cocinaVocab[[palabraChoice]]
    traducirRe(palabraTraducir)
  })
  
  output$palabraOutput <- renderText(palabraRe())
  output$traducirOutput <- renderText(traducirRe())
}

shinyApp(ui = ui, server = server)