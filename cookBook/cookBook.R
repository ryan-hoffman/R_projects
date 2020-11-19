
library(shiny)
library(yaml)
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
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "recipes",
        label = "Recipes",
        list("Breakfast" = c("", subset(tbl.config, category=="breakfast")$name),
             "Lunch" = c("", subset(tbl.config, category=="lunch")$name),
             "Dinner" = c("", subset(tbl.config, category=="dinner")$name),
             "Dessert" = c("", subset(tbl.config, category=="dessert")$name),
             selected = NULL
        )
      ),
    ),
    
    mainPanel(
      div(uiOutput("recipePicOutput"), align = "center"),
      br(),
      h3(uiOutput("recipeNameOutput"), align = "center"),
      br(),
      h5(uiOutput("recipeIngredientsOutput"), align = "center"),
      br(),
      h5(uiOutput("recipeDirectionsOutput"), align = "center"),
      
    )
  )
)

server <- function(input, output, session){
  
  itemPic <- reactiveVal()
  itemName <- reactiveVal()
  itemIng <- reactiveVal()
  itemDir <- reactiveVal()
  
  output$recipePicOutput <- renderUI({
    tags$img(src=itemPic(), width=500)
  })
  
  output$recipeNameOutput <- renderUI(itemName())
  
  output$recipeIngredientsOutput <- renderUI(itemIng())
  
  output$recipeDirectionsOutput <- renderUI(itemDir())
  
  observeEvent(input$recipes, ignoreInit=TRUE, {
    recipeName <- input$recipes
    itemPIC <- subset(tbl.config, name==recipeName)$pic
    itemPic(itemPIC)
  })
  
  observeEvent(input$recipes, ignoreInit=TRUE, {
    recipeName <- input$recipes
    itemNAME <- subset(tbl.config, name==recipeName)$name
    itemName(itemNAME)
  })
  
  observeEvent(input$recipes, ignoreInit=TRUE, {
    recipeName <- input$recipes
    itemING <- subset(tbl.config, name==recipeName)$ingredients
    itemIng(itemING)
  })
  
  observeEvent(input$recipes, ignoreInit=TRUE, {
    recipeName <- input$recipes
    itemDIR <- subset(tbl.config, name==recipeName)$directions
    itemDir(itemDIR)
  })
}

shinyApp(ui = ui, server = server)