# EuroCity package
R package providing statistical comparisons of European cities based on indicators of quality of life (life satisfaction, living expenses, environment, culture etc.). 
Includes an R shiny app which allows users to compare different European cities based on chosen indicators, to find the highest ranking cities in chosen indicators, and visualizing the results in interactive plots and maps. 

Data will be combined from the cost-of-living-and-prices API, as well as open data bases from the EU and "Our World in Data". 


## Design of the shiny app
The shiny app will include two tabs: One for comparing two cities with eachother regarding quality of life and life satisfaction, the other for comparing living expenses and prices of goods. 

In both tabs the user will choose the two cities to compare. To facilitate search, there will first be a dropdown menu for choosing the country and then, conditional on the country chosen, another dropdown menu for the cities within this country. Below that, checkboxes for the criteria will be displayed. Which criteria will be provided still depends on which data I can use. 


## Requirements
- a user interface containing html text, conditional dropdown menus, checkbox menus, the barplot, the interactive rank, and the ranking. 
- function to load data from different sources and combine them 
- function to filter data based on user input
- functions for each plot
- server function to combine ui input elements, backend-functions and ui-output elements




