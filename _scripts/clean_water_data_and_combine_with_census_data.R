library(tidyverse)

# loads in water insecurity and census data for both years
water_2022 <- read_csv("data/water_insecurity_2022.csv")
water_2023 <- read_csv("data/water_insecurity_2023.csv")
census_2022 <- read_csv("data/census_2022.csv")
census_2023 <- read_csv("data/census_2023.csv")

# removes Puerto Rico from the water insecurity datasets
water_2022 <- water_2022 |>
  filter(!str_starts(geoid, "72"))
water_2023 <- water_2023 |>
  filter(!str_starts(geoid, "72"))

# removes Bartow County, GA and Lafourche Parish, LA from the water insecurity datasets
# for whatever reason, these two county / county equivalent areas were in the
# dataset despite lacking plumbing data
water_2022 <- water_2022 |>
  filter(
    !name %in% c(
      "Lafourche Parish, Louisiana",
      "Bartow County, Georgia"
    )
  )
water_2023 <- water_2023 |>
  filter(
    !name %in% c(
      "Lafourche Parish, Louisiana",
      "Bartow County, Georgia"
    )
  )

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
