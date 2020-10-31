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

  observeEvent(input$palabra, {
    choice <- sample(1:9, 1)
    palabraChoice <- names(cocinaVocab[choice])
    palabraRe(palabraChoice)
    })

  observeEvent(input$traducir, {
    req(palabraRe())   # require non-null, non-null value to proceed, otherwise simply return
    palabraTraducir <- cocinaVocab[[palabraRe()]]
    traducirRe(palabraTraducir)
    })

  observeEvent(input$reajustar, {
     palabraRe("")
     traducirRe("")
     })

  output$palabraOutput <- renderText(palabraRe())
  output$traducirOutput <- renderText(traducirRe())
}

runApp(shinyApp(ui = ui, server = server), port=6717)
