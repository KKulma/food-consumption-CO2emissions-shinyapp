library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(leaflet)
library(dplyr)
library(readr)
library(rgdal)
library(DT)
library(RColorBrewer)

## load data
final_table <- readRDS("data/consumption-CO2emissions-data.rds")

final_table <- final_table %>%
  mutate(consumption = parse_number(consumption),
         co2_emmission = parse_number(co2_emmission))

# country name cleaning
final_table$country[final_table$country == "USA"] <- "United States"
final_table$country[final_table$country == "Congo"] <-
  "Dem. Rep. Congo"

##  data matching data

# add consumption & emission data to polygon data
countries <- readOGR("data", "TM_WORLD_BORDERS-0.3")

map <-
  merge(
    countries,
    final_table,
    by.x = "NAME",
    by.y = "country",
    duplicateGeoms = TRUE
  )

map2 <- map[!is.na(map@data$food_category), ]
