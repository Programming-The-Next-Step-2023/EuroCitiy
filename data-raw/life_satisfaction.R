## code to prepare `life_satisfaction` dataset

library(dplyr)

countries <- c("Denmark","Netherlands","Turkey","Belgium","Greece","Spain",
               "Northern Ireland","Serbia","Germany","Poland","Italy","France",
               "Portugal","Slovakia","Romania","Hungary","Bulgaria","Wales",
               "Ireland","Switzerland","Scotland","Austria","Finland","Cyprus",
               "Slovenia","England","Sweden","Norway","Czechia","Montenegro",
                "Iceland","Latvia","North Macedonia", "Estonia","Albania","Malta",
               "Lithuania","Croatia","Luxembourg")

life_satisfaction <- read.csv("happiness-cantril-ladder.csv") %>%
  filter(grepl(paste(countries, collapse="|"),
               Entity)) %>%
  select(Entity, Year, Cantril.ladder.score, Code)  %>%
  rename(Life_satisfaction = Cantril.ladder.score)

usethis::use_data(life_satisfaction, overwrite = TRUE)
