


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
              choices = unique(map2$food_category)
            )
          )),
          leafletOutput("map", width = "100%", height = "100%"),
          # absolutePanel(id = "info", class = "panel panel-default", fixed = TRUE,
          #               draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
          #               width = 330, height = "auto",
          #
          #               h2("Country Stats")
          
          # selectInput("color", "Color", vars),
          # selectInput("size", "Size", vars, selected = "adultpop"),
          # conditionalPanel("input.color == 'superzip' || input.size == 'superzip'",
          #                  # Only prompt for threshold when coloring or sizing by superzip
          #                  numericInput("threshold", "SuperZIP threshold (top n percentile)", 5)
          # ),
          #
          # plotOutput("histCentile", height = 200),
          # plotOutput("scatterCollegeIncome", height = 250)
          #)
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
              final_table$country
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
