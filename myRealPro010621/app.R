library(shiny)
library(yaml)
addResourcePath("www", "www")

config.file <- "myRealPro.yaml"
config <-  yaml.load(readLines(config.file))
tunes <- config$tunes
tbl.config <- do.call(rbind,
                      lapply(tunes,
                             function(tune) as.data.frame(tune, stringsAsFactors=FALSE)
                      ))

ui <- navbarPage(HTML("myRealPro"),
                 tabPanel("Jazz",
                          sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput(
                                           inputId = "swingSelector",
                                           label = "Swing",
                                           choices = c("no selection", subset(tbl.config, genre=="swing")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "latinSelector",
                                           label = "Latin",
                                           choices = c("no selection", subset(tbl.config, genre=="latin")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "musetteSelector",
                                           label = "Musette",
                                           choices = c("no selection", subset(tbl.config, genre=="musette")$name),
                                           selected = NULL,
                                           selectize = FALSE)
                            ),
                            
                            mainPanel(
                              uiOutput("imageOutputTabOne")        
                            )
                          )
                 ),
                 
                 tabPanel("Fiddle Tunes",
                          sidebarLayout(
                            sidebarPanel(width = 3,
                                         selectInput(
                                           inputId = "reelSelector",
                                           label = "Reels",
                                           choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="4/4")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "jigSelector",
                                           label = "Jigs",
                                           choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="6/8")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "hornpipeSelector",
                                           label = "Hornpipes",
                                           choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="lilting 4/4")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "waltzSelector",
                                           label = "Waltzes",
                                           choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="3/4")$name),
                                           selected = NULL,
                                           selectize = FALSE),
                                         
                                         selectInput(
                                           inputId = "strathspeySelector",
                                           label = "Strathspeys",
                                           choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="strath 4/4")$name),
                                           selected = NULL,
                                           selectize = FALSE)
                            ),
                            
                            mainPanel(
                              uiOutput("imageOutputTabTwo")
                            )
                          )
                 )
)


server <- function(input, output, session){
  
  tune.url <- reactiveVal()
  
  output$imageOutputTabOne <- renderUI({
    tags$img(src=tune.url(), width=500)
  })
  
  output$imageOutputTabTwo <- renderUI({
    tags$img(src=tune.url(), width=500)
  })
  
  observeEvent(input$jigSelector, ignoreInit=TRUE, {
    tuneName <- input$jigSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$reelSelector, ignoreInit=TRUE, {
    tuneName <- input$reelSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$hornpipeSelector, ignoreInit=TRUE, {
    tuneName <- input$hornpipeSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$waltzSelector, ignoreInit=TRUE, {
    tuneName <- input$waltzSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$strathspeySelector, ignoreInit=TRUE, {
    tuneName <- input$strathspeySelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$swingSelector, ignoreInit=TRUE, {
    tuneName <- input$swingSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$latinSelector, ignoreInit=TRUE, {
    tuneName <- input$latinSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
  
  observeEvent(input$musetteSelector, ignoreInit=TRUE, {
    tuneName <- input$musetteSelector
    tuneURL <- subset(tbl.config, name==tuneName)$url
    tune.url(tuneURL)
  })
}

shinyApp(ui = ui, server = server)
