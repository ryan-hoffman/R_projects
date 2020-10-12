library(shiny)
library(yaml)
addResourcePath("www","www")

# will be better with a empty initial value - fixed that with empty string
# that solution may not be optimal

config.file <- "myRP.yaml"
config <-  yaml.load(readLines(config.file))
tunes <- config$tunes
tbl.config <- do.call(rbind,
                      lapply(tunes,
                             function(tune) as.data.frame(tune, stringsAsFactors=FALSE)
                      ))

ui <- fluidPage(
  titlePanel(
    h1("MyRealPro", align="center")
  ),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "charts", "Select a Tune", list(
          "Reels" = c("", "Congress Reel", "Earl's Chair", "Mulqueen's", "Traveler's"),
          "Jigs" = c("","Blarney Pilgrim", "Champion", "Geese in the Bog", "Leitim Fancy"),
          "Hornpipes" = c("","Belfast Hornpipe", "Garrett Barry's"),
          "Swing" = c("","After You've Gone","Ain't Misbehavin'", "All of Me", "All the Things You Are"),
          "Latin" = c("", "Gentle Rain","Mambo Inn", "Manha de Carnival")
        )
      )
    ),
    
    mainPanel(
      uiOutput("chartOutput")
    )
  )
)

server <- function(input, output, session){
  
  output$chartOutput <- renderUI({
    tuneName <- input$charts
    print("chartOutput triggered")
    if(tuneName != ""){
      tuneURL <- subset(tbl.config, name==tuneName)$url
      tags$img(src=tuneURL, width=500)
    }
  })
}

shinyApp(ui = ui, server = server)
