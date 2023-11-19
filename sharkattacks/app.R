library(shiny)
library(tidyverse)
library(shinythemes)
library(rsconnect)

# read in dataset and edit column names
shark_data <- read_csv("data/shark_data.csv", show_col_types = FALSE)
colnames(shark_data)[1] <- "Location"
colnames(shark_data)[3] <- "Attacks"
colnames(shark_data)[4] <- "Fatalities"

# define UI for app to plot the number of shark attacks and fatalities
ui <- fluidPage(

  # FEATURE 1: changed app theme
  theme = shinytheme("lumen"),

  # app title
  titlePanel("Shark Attacks and Fatalities by Location"),

  # create sidebar for user to select options
  sidebarLayout(
    sidebarPanel(
      # FEATURE 2: selecting one or multiple locations using selectizeInput(), allowing the user to compare the attacks and fatalities between locations by typing and searching
      selectizeInput("Location", "Select location(s):", choices = unique(shark_data$Location), selected = NULL, multiple = TRUE),

      # FEATURE 3: sliders for the user to select start and end year (separated so the buttons do not overlap) so the data can be filtered by the desired time range
      sliderInput("StartYear", "Select start year:", min = min(shark_data$Year),
                  max = max(shark_data$Year), value = min(shark_data$Year), step = 1),
      sliderInput("EndYear", "Select end year:", min = min(shark_data$Year),
                  max = max(shark_data$Year), value = max(shark_data$Year), step = 1),

      # FEATURE 4: checkboxGroupInput() is used to to allow the user to select one or more sorting variables so the resulting table can be sorted accordingly
      checkboxGroupInput("sortVariables", "Sort table by:", choices = c("Location","Year", "Attacks", "Fatalities"),
                         selected = "Location"),

      # FEATURE 5: a download button for the user to download the data table as a .csv file
      downloadButton("download", "Download data")
    ),

    # show plot and table as the output
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

# define server logic required to output the plots and table
server <- function(input, output) {

  # make output react to input to allow updates when the user changes the location(s)/time range
  data_filtered <- reactive({
    shark_data %>%
      filter(Location %in% input$Location, Year >= input$StartYear, Year <= input$EndYear)
  })

  # reactive expression to sort the data if the user selects the options to
  data_sorted <- reactive({
    data_sorted <- data_filtered()
    if ("Location" %in% input$sortVariables) {
      data_sorted <- arrange(data_sorted, Location)
    }
    if ("Year" %in% input$sortVariables) {
      data_sorted <- arrange(data_sorted, Year)
    }
    if ("Attacks" %in% input$sortVariables) {
      data_sorted <- arrange(data_sorted, Attacks)
    }
    if ("Fatalities" %in% input$sortVariables) {
      data_sorted <- arrange(data_sorted, Fatalities)
    }
    data_sorted
  })

  # create grouped bar plot showing attacks and fatalities (fatalities is outlined in black within the same bar)
  output$plot <- renderPlot({
    ggplot(data_filtered(), aes(x = Year, fill = Location)) +
      geom_bar(aes(y = Attacks), position = "dodge", stat = "identity") +
      geom_bar(aes(y = Fatalities), position = "dodge", stat = "identity", color = "black") +
      labs(title = "Shark Attacks and Fatalities",
           y = "Count",
           x = "Year",
           fill = "Location") +
      theme_light()
  })

  # create table, where the results will be sorted by variables if selected by the user (feature 4)
  output$table <- renderTable({
    data_sorted()
  })

  # downloadHander() to create a .csv file with the data the user selects, with the current date saved in the file name (feature 5)
  output$download <- downloadHandler(
    filename = function() {
      paste("shark_data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(data_sorted(), file)
    }
  )
}

# run the application
shinyApp(ui = ui, server = server)

