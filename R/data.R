# Documenting data sets

#' Report on the Quality of life in European Cities data
#'
#' Results of the Report on the Quality of life in European Cities, reported
#' in 2019 and published in 2020.
#'
#' @format A data frame with 1162 rows and 4 columns:
#' \describe{
#'   \item{country}{Country name}
#'   \item{city}{City name}
#'   \item{variable}{Criterion participants were asked to rate}
#'   \item{percentage}{percentage of participants reporting to be 'rather satisfied' or 'very satisfied' with the respective criterion in their city}
#' }
#' @source <https://ec.europa.eu/regional_policy/information-sources/maps/quality-of-life_en>
"qualityOL"


#' Cities dataset
#'
#' Overview of cities included in the shiny app, their respective countries and
#' city names in english. This data frame was created manually and is mainly used
#' for internal data wrangling.
#'
#' @format A data frame with 82 rows and 3 columns:
#' \describe{
#'   \item{country}{Country name}
#'   \item{city}{City name}
#'   \item{city_english}{City name in english as shown in the shiny user interface}
#' }
"cities"


#' World Happiness Report 2023 data for selected European countries
#'
#' This data frame contains a subset of the data of the World Happiness Report 2023.
#' Data were collected yearly from 2003 to 2021 and contain country-wide means
#' of self-reported life satisfaction on a scale of 0 to 10.
#'
#' @format A data frame with 1162 rows and 4 columns:
#' \describe{
#'   \item{Entity}{Country name}
#'   \item{Year}{Year of measurement}
#'   \item{Life_satisfaction}{Country mean of self-reported life satisfaction on a scale of 0 to 10}
#'   \item{Code}{Country Code (used for plotting map in shiny)}
#' }
#' @source Helliwell, J. F., Layard, R., Sachs, J. D., De Neve, J.-E., Aknin, L. B., & Wang, S. (Eds.). (2023).
#'     World Happiness Report 2023., <https://ourworldindata.org/grapher/happiness-cantril-ladder>
"life_satisfaction"


#' Living expenses & product prices of selected European countries
#'
#' This data frame contains prices of various goods in European cities.
#' Prices are reported in Euro and were retrieved in May 2023.
#' Data was taken from Cost of Living & Prices API. Copyright therefore
#' does not fall under the MIT license but belongs to Cost of Living & Prices API.
#'
#' @format A data frame with 1186 rows and 7 columns:
#' \describe{
#'   \item{country}{Country name}
#'   \item{city}{City name}
#'   \item{item_name}{Name of product}
#'   \item{category}{Category which the product belongs to. Values are "Housing", "Groceries", "Alcoholic Beverages", "Leisure time and going out", "Transportation"}
#'   \item{min}{lowest price of product in city; in EURO}
#'   \item{avg}{highest price of product in city; in EURO}
#'   \item{max}{average price of product in city; in EURO}
#' }
#' @source Cost of Living & Prices API: <https://cost-of-living-and-prices.p.rapidapi.com/prices>
"city_prices"


#' Price categories data set
#'
#' Overview over products contained in city_prices and the categories they belong to.
#' This data frame was created manually and is mainly used for internal data wrangling.
#'
#'@format A data frame with 23 rows and 2 columns:
#' \describe{
#'   \item{category}{Category which the product belongs to. Values are "Housing", "Groceries", "Alcoholic Beverages", "Leisure time and going out", "Transportation"}
#'   \item{item_name}{Name of product}
#' }
"price_categories"


