# ShinyPlotlyHW
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinythemes)
library(rvest)
library(plotly)

#Select website to use to read data in
page <- read_html("https://www.metacritic.com/browse/games/score/metascore/all/all/filtered?sort=desc")

#Get variables (every time I add #main, it creates problems)
game_title <- page %>%
  html_nodes(".product_title") %>%
  html_text() %>%
  str_squish()

meta_score <- page %>%
  html_nodes(".positive") %>%
  html_text() %>%
  as.numeric()

user_score <- page %>%
  html_nodes(".textscore") %>%
  html_text() %>%
  as.numeric()

release_date <- page %>%
  html_nodes(".full_release_date") %>%
  html_text() %>%
  str_squish() %>%
  str_replace("Release Date: ", "") %>%
  str_remove(",") %>%
  str_replace_all(" ", "/") %>%
  as.Date(format = "%b/%d/%y")


game_title <- game_title[1:100]

meta_score <- meta_score[1:100]

release_date <- release_date[1:100]

user_score <- user_score[1:100]

platform <- substring(game_title, regexpr("[(]", game_title) + 1) %>%
  str_remove("[)]")

#create data set
best_games <- data.frame(game_title, platform, release_date, meta_score, user_score)

variables <- c("meta_score", "user_score")

###create shiny and plotly stuff
ui <- fluidPage(
  theme = shinytheme("cyborg"), 
  titlePanel("Best Video Games EVER!!!"),
  sidebarPanel(
    selectInput("x", "X-Axis", choices = variables, selected = "meta_score"),
    selectInput("y", "Y-Axis", choices = variables, selected = "user_score"),
    selectInput("platform", "Platform", choices = "platform"),
    dateRangeInput("release", "Range of Release Dates", start = "1980-01-01",
                   end = NULL, format = "yyy-mm-dd")),

  mainPanel(
    plotlyOutput('gamePlots', height = "900px")
  )
                
)

# Define server logic 
server <- function(input, output) {
  output$gamePlots <- renderPlotly({
    
    # build graph with ggplot syntax
    p <- plot_ly(data = best_games)
    
    p <- ggplot(data = best_games, aes_string(x = input$x, y = input$y, color = best_games$platform)) + 
      geom_point()
    
    
  })
  
}

#Run application
shinyApp(ui = ui, server = server)
