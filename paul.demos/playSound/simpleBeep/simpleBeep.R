library(shiny)
addResourcePath("www", "www");

ui <- fluidPage(
   actionButton("dobeep", "Play sound")
   )

server <- function(input, output, session) {
    observeEvent(input$dobeep, {
        insertUI(selector = "#dobeep",
                 where = "afterEnd",
                 #ui = tags$audio(src = "www/beep-01a.wav", type = "audio/wav", autoplay = TRUE, controls = NA, style="display:none;")
                 ui = tags$audio(src = "www/beep-01a.mp3", type = "audio/mp3", autoplay = TRUE, controls = NA, style="display:none;")
        )
    })
}

runApp(shinyApp(ui, server), port=9998)

