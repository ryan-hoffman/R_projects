library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(rel= "stylesheet", type="text/css", href ="style.css"),
  ),
  br(),
  sidebarLayout(
    sidebarPanel(
      
      #tags$style("#container1 * .selectize-input {font-size: 10px; line-height: 10px;}"),
      div(id="container1",
          textInput("a", "Female first name"),
          textInput("b", "Adjective"),
          textInput("c", "Exclamatory word"),
          textInput("d", "Noun"),
          textInput("e", "Adjective"),
          textInput("f", "Noun"),
          textInput("g", "Verb ending in 'ing'"),
          textInput("h", "verb ending in 'ed'"),
          br(),
          actionButton("submit", "Finished!"))
    ),
    
    mainPanel(
      titlePanel( 
        h1("Mad Mad Libs App!", align = "center")
      ),
      br(),
      br(),
      textOutput("emptyPanel"),
      conditionalPanel(id="conditionalPanel",
                       condition = "input.submit",
                       
                       #tags$style("#container2 * {display: inline; line-height: 3;}"),
                       div(id="container2", h5("There once was a giant named  "), 
                           h4(textOutput("aOutput")),h5(", who lived in an extremely "), 
                           h4(textOutput("bOutput")),h5("  castle.  '"),
                           h4(textOutput("cOutput")),h5(" !' she cursed as she tried to squeeze through the "), 
                           h4(textOutput("dOutput")),h5(" .  'This castle is too "),
                           h4(textOutput("eOutput")),h5(" ,'  she cried, waving her hands in disgust!  This is the final  "),
                           h4(textOutput("fOutput")),h5("! I'm "),h4(textOutput("gOutput")),h5("!  And with that, she "),
                           h4(textOutput("hOutput")),h5(".")))
    )
  ) 
)


server <- function(input, output){
  
  output$emptyPanel <- renderText({
    paste(" ")
  })
  
  observeEvent(input$submit, {
    
    output$aOutput <- renderText({
      paste(input$a) 
    })
    
    output$bOutput <- renderText({
      paste(input$b)
    })
    
    output$cOutput <- renderText({
      paste(input$c)
    })
    
    output$dOutput <- renderText({
      paste(input$d)
    })
    
    output$eOutput <- renderText({
      paste(input$e)
    })
    
    output$fOutput <- renderText({
      paste(input$f)
    })
    
    output$gOutput <- renderText({
      paste(input$g)
    })
    
    output$hOutput <- renderText({
      paste(input$h)
    })
  })
}

shinyApp(ui = ui, server = server)