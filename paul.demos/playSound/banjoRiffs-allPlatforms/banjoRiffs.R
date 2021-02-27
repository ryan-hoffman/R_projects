library(shiny)
library(shinyjs)

addResourcePath("www", "www");

playSound.01 <- "document.getElementById('sound_01').play();"
playSound.02 <- "document.getElementById('sound_02').play();"

jsCode <- "playSpecifiedSound = function(value){
              document.getElementById(value).play();
              }"


ui <- fluidPage(
   useShinyjs(),
   extendShinyjs(text=jsCode, functions="playSpecifiedSound"),
   h4("Play riff"),
   tags$button(id="b1", type="button", onclick=playSound.01, "I Feel the Same"),
   tags$button(id="b2", type="button", onclick=playSound.02, "Nyandolo"),
       # hidden audio tags.  add "controls=TRUE" to make them visible
   tags$audio(id="sound_01", src="www/iFeelTheSameLoop-Fsharp.mp3", type="audio/mpeg", preload="auto"),
   tags$audio(id="sound_02", src="www/Nyandolo.mp3", type="audio/mpeg", preload="auto"),
   br(),br(),
   HTML("<select id='riffChooser' onchange=playSpecifiedSound(value);>
          <option value='none'>- Choose One -</option>
          <option value='sound_01'>I Feel the Same</option>
          <option value='sound_02'>Nyandolo</option>
        </select>")
   )

server <- function(input, output, session) {
}

runApp(shinyApp(ui, server), port=9998)


