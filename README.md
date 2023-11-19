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
