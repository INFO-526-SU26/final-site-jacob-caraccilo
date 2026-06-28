library(tidyverse)

# loads in water insecurity and census data for both years
water_2022 <- read_csv("data/water_insecurity_2022.csv")
water_2023 <- read_csv("data/water_insecurity_2023.csv")
census_2022 <- read_csv("data/census_2022.csv")
census_2023 <- read_csv("data/census_2023.csv")

# combines the 2022 water insecurity and Census datasets together based on rows
# where geoid matches, which is the county identifier
water_census_2022 <- left_join(
  water_2022,
  census_2022 |>
    select(-year), # removes year column from census data to avoid two year columns
  by = "geoid"
)

# combines the 2023 water insecurity and Census datasets together based on rows
# where geoid matches, which is the county identifier
water_census_2023 <- left_join(
  water_2023,
  census_2023 |>
    select(-year), # removes year column from census data to avoid two year columns
  by = "geoid"
)

# creates new csv files out of the previously created dataframes and saves them
# in the data folder
write_csv(water_census_2022, "data/water_census_2022.csv")
write_csv(water_census_2023, "data/water_census_2023.csv")
