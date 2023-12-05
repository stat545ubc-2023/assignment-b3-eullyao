library(shiny)
library(tidyverse)
library(shinythemes)
library(plotly)
library(DT)
library(htmlwidgets)
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

      # NEW FEATURE 1: create a user guide
      HTML(
        '<div style="margin-bottom: 30px;">
        <h4><b>How to use:</h4></b>
        <p>1. Use the options below to select location(s) and time range.
        The plot and table will update based on the selections. Black outlines in the plot indicate fatalities - hover over data bars for the values.</p>
        <p>2. Hover over plot for viewing options. Click the camera icon when hovering over the plot to download a static image. Or, click <b>download interactive plot</b> below to download an interactive .html plot.</p>
        <p>3. Click the arrows next to the headers in the data table to sort the data. Shift+click to sort by multiple columns.</p>
        <p>4. Click <b> Download data </b> to download the resulting sorted data (all entries) as a CSV, Excel, or PDF file.</p>
        </div>'
      ),

      # FEATURE 2: selecting one or multiple locations using selectizeInput(), allowing the user to compare the attacks and fatalities between locations by typing and searching
      selectizeInput("Location", "Select location(s):", choices = unique(shark_data$Location), selected = NULL, multiple = TRUE),

      # FEATURE 3: sliders for the user to select start and end year (separated so the buttons do not overlap) so the data can be filtered by the desired time range
      sliderInput("StartYear", "Select start year:", min = min(shark_data$Year),
                  max = max(shark_data$Year), value = min(shark_data$Year), step = 1),
      sliderInput("EndYear", "Select end year:", min = min(shark_data$Year),
                  max = max(shark_data$Year), value = max(shark_data$Year), step = 1),

      # NEW FEATURE 2: a download button for the user to download the plot as an interactive HTML file
      downloadButton("downloadPlot", "Download interactive plot")
    ),

    # show plot and table as the output
    mainPanel(
      # use plotlyOutput instead of plotOutput
      plotlyOutput("plot"),
      # Use DTOutput instead of tableOutput
      DTOutput("table")
    )
  )
)

# define server logic required to output the user guide, plot, table, and download buttons
server <- function(input, output) {

  # make output react to input to allow updates when the user changes the location(s)/time range
  data_filtered <- reactive({
    shark_data %>%
      filter(Location %in% input$Location, Year >= input$StartYear, Year <= input$EndYear)
  })

  # NEW FEATURE #3: reactive expression to create a interactive grouped bar plot using ggplot showing attacks and fatalities (fatalities is outlined in black within the same bar); translate into a plotly plot
  plotly_plot <- reactive({
    p <- ggplot(data_filtered(), aes(x = Year, fill = Location)) +
      geom_bar(aes(y = Attacks), position = "dodge", stat = "identity") +
      geom_bar(aes(y = Fatalities), position = "dodge", stat = "identity", color = "black") +
      labs(title = "Shark Attacks and Fatalities",
           y = "Count",
           x = "Year",
           fill = "Location") +
      theme_light()

    # hover over data to view the values for attacks and fatalities to make the plot more interactive and easier to interpret
    ggplotly(p, tooltip = "y")
  })

  # render interactive plot
  output$plot <- renderPlotly({ # change to use plotly to make an interactive plot
    plotly_plot()
  })

  # NEW FEATURE #4: create an interactive table
  output$table <- renderDT(server = FALSE, { # server set to FALSE so ALL rows are downloaded, not just page 1
    datatable(
      data_filtered(),
      extensions = "Buttons",
      options = list(
        pageLength = 10, # number of observations per page
        lengthMenu = c(10, 25, 50), # different page lengths
        dom = "Bltip", # features: (l = length changing input, t = table, i = information summary, p = pagination)
        buttons =
          list(list(
            extend = 'collection', # create a dropdown menu with data formats to download
            buttons = c('csv', 'excel', 'pdf'),
            text = 'Download data'))
      )
    )
  })

  # NEW FEATURE #2: downloadHandler() to create an interactive HTML file with the plot the user produces, with the current date saved in the file name
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste("shark_plot_", Sys.Date(), ".html", sep = "")
    },
    content = function(file) {
      saveWidget(plotly_plot(), file, selfcontained = TRUE)
    }
  )
}
# run the application
shinyApp(ui = ui, server = server)
