library(shiny)
library(yaml)
addResourcePath("www", "www")

#--------------------------------------------------------------------------------
# read the yaml file, do some not-initially-obvious manipulations, turn
# it into a readily usable data.frame.  take them on faith for nowm, learn
# details later if and when they become important
#--------------------------------------------------------------------------------
config.file <- "myRP.yaml"
config <-  yaml.load(readLines(config.file))
tunes <- config$tunes
tbl.config <- do.call(rbind,
                      lapply(tunes,
                             function(tune) as.data.frame(tune, stringsAsFactors=FALSE)
                      ))
#--------------------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("myRealPro"),
  sidebarLayout(

    sidebarPanel(
      selectInput(
        inputId = "reelSelector",
        label = "Reels",
        choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="4/4")$name),
        selected = NULL),

      selectInput(
        inputId = "jigSelector",
        label = "Jigs",
        choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="6/8")$name),
        selected = NULL),

      selectInput(
        inputId = "hornpipeSelector",
        label = "Hornpipes",
        choices = c("no selection", subset(tbl.config, genre=="Irish" & timeSignature=="lilting 4/4")$name),
        selected = NULL),

      selectInput(
        inputId = "swingSelector",
        label = "Swing",
        choices = c("no selection", subset(tbl.config, genre=="swing")$name),
        selected = NULL),

      selectInput(
        inputId = "latinSelector",
        label = "Latin",
        choices = c("no selection", subset(tbl.config, genre=="latin")$name),
        selected = NULL)

    ), # sbp

    mainPanel(
      div(
        uiOutput("imageOutput"),
      )

    ) # m
  ) # sbl
) # fp

server <- function(input, output, session){

   tune.url <- reactiveVal()

   output$imageOutput <- renderUI({
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
      print("hornpipe")
      tuneName <- input$hornpipeSelector
      tuneURL <- subset(tbl.config, name==tuneName)$url
      tune.url(tuneURL)
      })

   observeEvent(input$swingSelector, ignoreInit=TRUE, {
      print("swing")
      tuneName <- input$swingSelector
      tuneURL <- subset(tbl.config, name==tuneName)$url
      tune.url(tuneURL)
      })

   observeEvent(input$latinSelector, ignoreInit=TRUE, {
      print("latin")
      tuneName <- input$latinSelector
      tuneURL <- subset(tbl.config, name==tuneName)$url
      tune.url(tuneURL)
      })


}

runApp(shinyApp(ui = ui, server = server), port=9997)
