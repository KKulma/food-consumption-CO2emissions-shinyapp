library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(readr)
library(rgdal)
library(dashboardthemes)
library(DT)

## load data
final_table <- readRDS("consumption-CO2emissions-data.rds")
# source("01-scraping-food-country-co2-dataset.R")

final_table <- final_table %>%
  mutate(consumption = parse_number(consumption),
         co2_emmission = parse_number(co2_emmission))

# country name cleaning
final_table$country[final_table$country == "USA"] <- "United States"
final_table$country[final_table$country == "Congo"] <-
  "Dem. Rep. Congo"

##  data matching data

# add consumption & emission data to polygon data
countries <- readOGR("world-shapefiles-simple", "TM_WORLD_BORDERS-0.3")

map <-
  merge(
    countries,
    final_table,
    by.x = "NAME",
    by.y = "country",
    duplicateGeoms = TRUE
  )

map2 <- map[!is.na(map@data$food_category), ]
