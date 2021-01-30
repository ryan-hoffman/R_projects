library(shiny)
addResourcePath("www", "www");

ui <- fluidPage(
   selectInput(inputId="riffPicker",  label="Play Riff", choices=c("", "Nyandolo", "I Feel the Same"),
               selected = NULL,
               multiple = FALSE,
               selectize = TRUE,
               width = NULL,
               size = NULL
               )
   )

server <- function(input, output, session) {
    observeEvent(input$riffPicker, {
        riffName = switch(input$riffPicker,
                          "Nyandolo" = "www/Nyandolo.mp3",
                          "I Feel the Same" = "www/iFeelTheSameLoop-Fsharp.mp3")
        removeUI("#currentSound")   # not strictly needed, but good practice.  removes any previously inserted audio tag.
        insertUI(selector = "#riffPicker",
                 where = "afterEnd",
                 ui=tags$audio(id="currentSound", src=riffName, type="audio/mp3", autoplay=TRUE, controls=NA, style="display:none;")
        )
    })
}

runApp(shinyApp(ui, server), port=9998)

