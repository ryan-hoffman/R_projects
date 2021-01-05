library(shiny)
library(yaml)
library(XML)
addResourcePath("www", "www")

config.file <- "cookBook.yaml"
config <- yaml.load(readLines(config.file))
recipes <- config$recipes
tbl.config <- do.call(rbind,
                      lapply(recipes,
                             function(recipe) as.data.frame(recipe, stringsAsFactors=FALSE)
                      ))

ui <- fluidPage(
  titlePanel(
    h1("Stella and Dad's Fantastic Cookbook", align = "center")
  ),
  br(),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "recipes",
        label = "Recipes",
        list("Breakfast" = c("", subset(tbl.config, category=="breakfast")$name),
             "Lunch" = c("", subset(tbl.config, category=="lunch")$name),
             "Dinner" = c("", subset(tbl.config, category=="dinner")$name),
             "Dessert" = c("", subset(tbl.config, category=="dessert")$name),
             selected = NULL,
             selectize = FALSE
        )
      ),
    ),
    
    mainPanel(
      uiOutput("recipeOutput"),
    )
  )
)

server <- function(input, output, session){
  
  item <- reactiveVal()
  
  output$recipeOutput <- renderUI(item())
  
  observeEvent(input$recipes, ignoreInit=TRUE, {
    recipeName <- input$recipes
    itemFILE <- subset(tbl.config, name==recipeName)$file
    item(includeHTML(itemFILE))
  })
}

shinyApp(ui = ui, server = server)