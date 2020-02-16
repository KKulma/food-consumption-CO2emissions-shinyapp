library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(shinycustomloader)
library(RColorBrewer)
library(leaflet)
library(rnaturalearth)
library(sp)
library(DT)
library(dplyr)
library(readr)

## load data
final_table <- readRDS("data/consumption-CO2emissions-data.rds")

# tidy up
final_table <- final_table %>%
  mutate(consumption = parse_number(consumption),
         co2_emmission = readr::parse_number(co2_emmission))

# country name cleaning
final_table$country[final_table$country == "USA"] <- "United States"
final_table$country[final_table$country == "Congo"] <- "Dem. Rep. Congo"
final_table$country[final_table$country == "Czech Republic"] <- "Czech Rep."
final_table$country[final_table$country == "Guinea"] <- "Eq. Guinea"
final_table$country[final_table$country == "South Korea"] <- "Korea" 
final_table$country[final_table$country == "Taiwan. ROC"] <- "Taiwan"

##  data matching
countries <- rnaturalearth::ne_countries()
names(countries)[names(countries) == "name"] <- "country"

# add consumption & emission data to polygon data

map <-
  sp::merge(
    countries,
    final_table,
    duplicateGeoms = TRUE
  )

# remove missing values
map2 <- map[!is.na(map@data$food_category), ]
