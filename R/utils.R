# HELPER FUNCTIONS

# Define European cities included ---------------
european_cities <- c("Aalborg","Amsterdam","Ankara","Antalya","Antwerpen",
                     "Athens","Barcelona","Belfast",
                     "Belgrade","Berlin","Białystok","Bologna",
                     "Bordeaux","Braga","Bratislava","Brussels",
                     "Bucharest","Budapest","Burgas","Cardiff",
                     "Cluj-Napoca","Diyarbakir","Dortmund","Dublin",
                     "Essen","Gdańsk","Geneva","Glasgow",
                     "Graz","Groningen","Hamburg","Helsinki",
                     "Heraklion","Istanbul","Košice","Cracow",
                     "Copenhagen","Nicosia","Leipzig","Lille",
                     "Lisbon","Liège","Ljubljana","London",
                     "Madrid","Malmö","Manchester","Marseille",
                     "Miskolc","Munich","Málaga","Naples",
                     "Oslo","Ostrava","Oulu","Oviedo",
                     "Palermo","Paris","Piatra Neamt","Podgorica",
                     "Prague","Rennes","Reykjavík","Riga",
                     "Rome","Rostock","Rotterdam","Skopje",
                     "Sofia","Stockholm","Strasbourg","Tallinn",
                     "Tirana","Turin","Tyneside conurbation","Valletta",
                     "Verona","Vilnius","Warsaw","Vienna",
                     "Zagreb","Zurich","luxembourg")


# function to filter cities within one country ---------------------
filter_cities_by_country <- function(chosen_country, version = "QoL"){
  # return error if more than several countries chosen
  if(length(chosen_country) > 1){
    stop("Choose one country only.")
  }

  # if version = QoL: filter cities df by country and return city_english column
  if(version == "QoL"){
    filtered_cities <- cities %>%
      dplyr::filter(country == chosen_country) %>%
      dplyr::select(city_english)

    return(filtered_cities$city_english)

    # if version = "prices": filter city_prices df by country and return city column
  } else if(version == "prices"){
    filtered_cities <- city_prices %>%
      dplyr::filter(country == chosen_country) %>%
      dplyr::select(city)

    return(unique(filtered_cities$city))
  }
}

# translate internal category name to what is displayed to the user -------
variable_names <- data.frame(
  variable = c("LGBTQI", "air", "clean", "culture", "edu", "greenery",
               "health", "noise", "publicsp", "racial", "safety",
               "satisfaction", "sport", "transp"),
  display_name = c("LQBTQI+ friendliness", "Air quality", "Cleanness",
                   "Cultural Events & Activities", "Quality of Education",
                   "Green spaces", "the Health System", "Noise Level",
                   "Public spaces", "Quality of Life for ethnic minorities",
                   "Safety", "their City in General", "Sport facilities",
                   "Public Transport")
)

# function to filter products by price category ------------------
filter_products_by_category <- function(chosen_category){
  # return error if more than several categories chosen
  if(length(chosen_category) > 1){
    stop("Choose one category only.")
  }

  filtered_products <- price_categories %>%
    dplyr::filter(category == chosen_category) %>%
    dplyr::select(item_name)

  return(filtered_products$item_name)
}


