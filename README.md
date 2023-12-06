# sharkattacks2

### Description

Using the same data source, sharkattacks2 is an updated version of sharkattacks, featuring more options to visualize and download the data.

Link to the app: <https://eully-ao.shinyapps.io/sharkattacks2/>

Comparison between sharkattacks and sharkattacks2, highlighting new/improved features:

| Features             | sharkattacks                                                                                                                                                                  | sharkattacks2                                                                                                                                                                                                                                        |
|--------------|----------------------------|------------------------------|
| Location selection   | Users can select one or more locations.                                                                                                                                       | Users can select one or more locations.                                                                                                                                                                                                              |
| Time range selection | Users can select a year range. Negative numbers indicate BCE.                                                                                                                 | Users can select a year range. Negative numbers indicate BCE.                                                                                                                                                                                        |
| Plot                 | Grouped histogram updates as users select location(s) and time range.                                                                                                         | Grouped histogram updates as users select locations(s) and time range. Plot is interactive; hover over bars to view exact values, click to zoom in/out, compare multiple bars on hover                                                               |
| Data table           | Data table updates as users select location(s) and time range, and as users sort by one or more of the following: location, year, number of attacks, or number of fatalities. | Data table updates as users select location(s) and time range. Table is interactive; click to change how many rows are displayed, click to sort by location, year, number of attacks, or number of fatalities, or sort by multiple with Shift+click. |
| Download plot        | N/A                                                                                                                                                                           | Plot can be downloaded as a static PNG image or an interactive HTML file.                                                                                                                                                                            |
| Download data table  | Data can be downloaded as a CSV file reflecting the sorting options.                                                                                                          | Data can be downloaded as CSV, Excel, or PDF files reflecting the sorting options.                                                                                                                                                                   |
| Theme and layout     | Shiny theme "lumen".                                                                                                                                                          | Shiny theme "lumen", user guide.                                                                                                                                                                                                                     |

### Data source

The app uses data published by the Global Shark Attack File (GSAF), specifically a filtered dataset of attack and fatality count data for 183 locations, plus 1 summary count for `World`, spanning from 725 BCE to 2018. This data can be accessed [here](https://github.com/owid/owid-datasets/tree/master/datasets/Shark%20attacks%20and%20fatalities%20-%20Global%20Shark%20Attack%20File%20(GSAF)%20(2018)%20). The full published dataset can be accessed [here](https://docs.google.com/spreadsheets/d/1rH3O8JQ1v6tt7swPNbE5B5-AtVr9OtjhhmwpEuBQFbc/edit#gid=1632639634).

### Packages

sharkattacks2 was built with following packages: [shiny](https://shiny.posit.co/), [tidyverse](https://www.tidyverse.org/), [shinythemes](https://rstudio.github.io/shinythemes/), [plotly](https://plotly.com/r/), [DT](https://rstudio.github.io/DT/), [htmlwidgets](https://www.htmlwidgets.org/), and [rsconnect](https://rstudio.github.io/rsconnect/).

# sharkattacks

### Description

sharkattacks is a Shiny app that allows users to explore and visualize data on shark attacks and fatalities by location by producing a histogram plot (a black outline indicates fatalities) and a downloadable table.

Link to the app: <https://eully-ao.shinyapps.io/sharkattacks/>

### Features

1.  **Location selection**: Users can select one or multiple locations to compare
2.  **Time range selection**: Users can select a year range. Negative numbers indicate BCE.
3.  **Sorting**: Users can sort the resulting table by one or more of the following: location, year, number of attacks, or number of fatalities.
4.  **Download data**: Users can download the resulting table as a CSV file.

### Data source

The app uses data published by the Global Shark Attack File (GSAF), specifically a filtered dataset of attack and fatality count data for 183 locations, plus 1 summary count for `World`, spanning from 725 BCE to 2018. This data can be accessed [here](https://github.com/owid/owid-datasets/tree/master/datasets/Shark%20attacks%20and%20fatalities%20-%20Global%20Shark%20Attack%20File%20(GSAF)%20(2018)%20). The full published dataset can be accessed [here](https://docs.google.com/spreadsheets/d/1rH3O8JQ1v6tt7swPNbE5B5-AtVr9OtjhhmwpEuBQFbc/edit#gid=1632639634).

# 
