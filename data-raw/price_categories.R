## code to prepare `price_categories` dataset

price_categories <- data.frame(
  category = c(rep("Housing", 7),
               rep("Groceries", 7),
               "Alcoholic Beverages",
               rep("Leisure time and going out", 4),
               rep("Transportation", 3)),
  item_name = c("Price per square meter to Buy Apartment Outside of City Center",
                "Price per square meter to Buy Apartment in City Center",
                "One bedroom apartment in city centre",
                "Three bedroom apartment in city centre",
                "One bedroom apartment outside of city centre",
                "Three bedroom apartment outside of city centre",
                "Basic utilities for 85 square meter Apartment including Electricity, Heating or Cooling, Water and Garbage",
                "Banana, 1 kg",
                "Lettuce, 1 head",
                "White Rice, 1 kg",
                "Potato, 1 kg",
                "Loaf of Fresh White Bread, 0.5 kg",
                "Eggs, 12 pack",
                "Milk, Regular,1 liter",
                "Bottle of Wine, Mid-Range Price",
                "Meal for 2 People, Mid-range Restaurant, Three-course",
                "Fitness Club, Monthly Fee for 1 Adult",
                "Cinema ticket, 1 Seat",
                "Cappuccino",
                "Gasoline, 1 liter",
                "Taxi, price for 1 km, Normal Tariff",
                "One-way Ticket, Local Transport"
  )
)

usethis::use_data(price_categories, overwrite = TRUE)
