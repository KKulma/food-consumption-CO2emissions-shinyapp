

server <- server <- function(input, output, session) {
  
  
  output$datatable <- DT::renderDataTable({
    if(input$countries == 'All Countries') {
      output <- final_table
    } else {
      output <- filter(final_table, country %in% input$countries)
    }
    DT::datatable(output, filter = "top", options = list(scrollX = TRUE))
  })
  
  # output$filtered_map <- reactive({
  #   req(input$food)
  #   subset(map2, food_category == input$food)
  # })
  #
  # output$data_to_map <- reactive({
  #   req(input$map_var)
  #
  #   switch(input$map_var,
  #          "CO2 emissions" = filtered_map()$co2_emmission,
  #          "Food Consumption" = filtered_map()$consumption)
  # })
  
  
  
  
  output$map <- renderLeaflet({
    req(input$food)
    req(input$map_var)
    
    filtered_map <- subset(map2, food_category == input$food)
    
    # create over label
    filtered_map$labels <- paste0(
      "<strong> Country: </strong> ",
      filtered_map$NAME,
      "<br/> ",
      "<strong> Food type consumption in kg/per capita: </strong> ",
      filtered_map$consumption,
      "<br/> ",
      "<strong> Co2 emissions in ton/per capita: </strong> ",
      filtered_map$co2_emmission,
      "<br/> "
    ) %>%
      lapply(htmltools::HTML)
    
    
    
    pal <- colorBin(
      palette = "viridis",
      domain = filtered_map$co2_emmission,
      bins = 7
    )
    
    
    leaflet(filtered_map) %>%
      addTiles() %>%
      setView(lng = 0,
              lat = 30,
              zoom = 2) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(
        fillColor = ~ pal(filtered_map$co2_emmission),
        color = "white",
        fillOpacity = 0.7,
        label = ~ labels,
        highlight = highlightOptions(color = "black",
                                     bringToFront = TRUE)
      ) %>%
      leaflet::addLegend(
        pal = pal,
        values = ~ filtered_map$co2_emmission,
        opacity = 0.7,
        title = paste0(input$map_var)
      )
    
  })
  
  
  
}
