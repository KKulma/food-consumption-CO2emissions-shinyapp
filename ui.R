
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    shinyDashboardThemes(theme = "grey_light"),
    
    tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
    
    navbarPage(
      "Food Carbon Footprint",
      id = "nav",
      tabPanel(
        "Interactive map",
        div(
          class = "outer",
          
          fluidRow(column(
            4,
            radioButtons(
              inputId = "map_var",
              label =  "Choose variable to map :",
              choices = c("CO2 emissions",
                          "Food Consumption"),
              inline = TRUE,
              selected = "CO2 emissions"
            )
          ),
          column(
            3,
            selectInput(
              inputId = "food",
              label = "Choose Food Type",
              choices = sort(unique(map2$food_category))
            )
          )),
          shinycustomloader::withLoader(leafletOutput("map", width = "100%", height = "100%"), loader = "loader4"),
        )
      ),
      tabPanel(
        "Data explorer",
        fluidRow(column(
          3,
          selectInput(
            inputId = "countries",
            label = "Countries",
            choices = c("All Countries", sort(unique(
              map2$country
            ))),
            selected = 'All Countries',
            multiple = TRUE
          )
        )),
        DT::dataTableOutput('datatable')
      )
    )
  )
)
