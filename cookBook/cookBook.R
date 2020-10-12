# the image updates when the selectInput changes, but the other info does not

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
      div(uiOutput("recipeOutput"),
          h3(uiOutput("recipeNameOutput"), align = "center"),
          br(),
          h5(uiOutput("recipeIngredientsOutput"), align = "center"),
          br(),
          h5(uiOutput("recipeDirectionsOutput"), align = "center"),
      )
    )
  )
)

server <- function(input, output, session){
  
  output$recipePicOutput <- renderUI({
    recipeName <- input$recipes
    if(recipeName != ""){
      itemPic <- subset(tbl.config, name==recipeName)$pic
      tags$img(src=itemPic, width=500)
    }
  })
  
  output$recipeOutput <- renderUI({
    recipeName <- input$recipes
    
    if(recipeName != ""){
      itemName <- subset(tbl.config, name==recipeName)$name
      output$recipeNameOutput <- renderUI(itemName)
    }
    
    if(recipeName != ""){
      itemIng <- subset(tbl.config, name==recipeName)$ingredients
      output$recipeIngredientsOutput <- renderUI(itemIng)
    }
    
    if(recipeName != ""){
      itemDir <- subset(tbl.config, name==recipeName)$directions
      output$recipeDirectionsOutput <- renderUI(itemDir)
    }
  })
}

shinyApp(ui = ui, server = server)