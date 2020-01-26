## Shiny App is a function to show the results nicely. We add the reactive scatter plots for different money lines and the boba plot for pick accuracy in the first tab the app. Also, we have attached the whole analysis set for reference. The shiny app code only works when all the analysis code ("Consulting Project Final Code") is run. The shiny app is consist of ui and server, ui lists all the things we want to show on the app, and the server contains the output order. 

library(shinydashboard)
library(plotly)
library(shiny)

ui <- dashboardPage(
  dashboardHeader(title = "College Football"),
  dashboardSidebar(    
    sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("DataTable", tabName = "widgets", icon = icon("th"))
    )
  ),
  dashboardBody(    
    tabItems(
    # First tab content
    tabItem(tabName = "dashboard",
            fluidPage(
              navlistPanel(
                    tabPanel("Money Line 500",
                    radioButtons("plotType", "Plot Type:", "plotly"),
                    plotlyOutput("plot"),
                    verbatimTextOutput("hover"),
                    verbatimTextOutput("click")
         ),
                     tabPanel("Money Line 1000",
                              radioButtons("plotType", "Plot Type:", "plotly"),
                              plotlyOutput("plot1")
                              #verbatimTextOutput("hover1"),
                              #verbatimTextOutput("click1")
                    ),
                     tabPanel("Money Line 1500",
                              radioButtons("plotType", "Plot Type:", "plotly"),
                              plotlyOutput("plot2")
                              #verbatimTextOutput("hover2"),
                              #verbatimTextOutput("click2")
                              ),
                     tabPanel("Pick Pct. vs Average Pts. Earned",
                              radioButtons("plotType", "Plot Type:", "plotly"),
                              plotlyOutput("plot3", height = "800px")))
  
    )
    ),
    # Second tab content
    tabItem(tabName = "widgets",
            fluidPage(
              titlePanel("Basic DataTable"),
              fluidPage(
              DT::dataTableOutput("table")
            )
    )
  )
)
)
)


server <- function(input, output, session) {
  
  output$plot <- renderPlotly({
      plot_ly(
      ML500, x = ~Num.Pick1, y = ~Pick.PCT1,
      # Hover text:
      text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick1, '<br>Correct Presentage:', Pick.PCT1),
      color = ~Pick.PCT1, size = ~Pick.PCT1, key = ~row_names) %>%
      layout(dragmode = "select")
  })
  
  output$plot1 <- renderPlotly({
    p1 <- plot_ly(
      ML1000, x = ~Num.Pick2, y = ~Pick.PCT2,
      # Hover text:
      text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick2, '<br>Correct Presentage:', Pick.PCT2),
      color = ~Pick.PCT2, size = ~Pick.PCT2, key = ~row_names) %>%
      layout(dragmode = "select")
  })
  
  output$plot2 <- renderPlotly({
    p2 <- plot_ly(
      ML1500, x = ~Num.Pick3, y = ~Pick.PCT3,
      # Hover text:
      text = ~paste("Expert Name: ", row_names, "<br>Number of Picks: ", Num.Pick3, '<br>Correct Presentage:', Pick.PCT3),
      color = ~Pick.PCT3, size = ~Pick.PCT3, key = ~row_names) %>%
      layout(dragmode = "select")
  })
  
  output$plot3 <- renderPlotly({
    ggplot(How.Good) +
      aes(Analyst = Analyst, x = Pick.PCT, y = Avg.Score, size = N.Preds) +
      geom_point(colour = "#0c4c8a") +
      labs(x = "Pick Percentage", y = "Average Points Earned", title = "Compare Pick Accuracy to Weighted Values", size = "Number of Predictions") +
      theme_gray()
  })
  
  output$hover <- renderPrint({
    d <- event_data("plotly_hover")
    if (is.null(d)) "Hover events appear here (unhover to clear)" else d
  })
  
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) "Click events appear here (double-click to clear)" else d
  })
  
  output$table <- DT::renderDataTable({
    data <- Analysis_set
    data
  })
}

shinyApp(ui, server)
