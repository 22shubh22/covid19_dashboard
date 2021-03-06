output$summaryTables <- renderUI({
  tabBox(
    tabPanel("State",
      div(
        dataTableOutput("summaryDT_country"),
        style = "margin-top: -10px")
    ),
    tabPanel("District",
      div(
        dataTableOutput("summaryDT_state"),
        style = "margin-top: -10px"
      )
    ),
    width = 12
  )
})

output$summaryDT_country <- renderDataTable(getSummaryDT(data_atDate(current_date), "State", selectable = TRUE))
proxy_summaryDT_country  <- dataTableProxy("summaryDT_country")
output$summaryDT_state   <- renderDataTable(getSummaryDT(data_atDate(current_date), "District", selectable = TRUE))
proxy_summaryDT_state    <- dataTableProxy("summaryDT_state")

observeEvent(input$timeSlider, {
  data <- data_atDate(input$timeSlider)
  replaceData(proxy_summaryDT_country, summariseData(data, "State"), rownames = FALSE)
  replaceData(proxy_summaryDT_state, summariseData(data, "District"), rownames = FALSE)
}, ignoreInit = TRUE, ignoreNULL = TRUE)

observeEvent(input$summaryDT_country_row_last_clicked, {
  selectedRow     <- input$summaryDT_country_row_last_clicked
  selectedCountry <- summariseData(data_atDate(input$timeSlider), "State")[selectedRow, "State"]
  location        <- data_evolution %>%
    distinct(`State`, Lat, Long) %>%
    filter(`State` == selectedCountry) %>%
    summarise(
      Lat  = mean(Lat),
      Long = mean(Long)
    )
  leafletProxy("overview_map") %>%
    setView(lng = location$Long, lat = location$Lat, zoom = 4)
})

observeEvent(input$summaryDT_state_row_last_clicked, {
  selectedRow     <- input$summaryDT_state_row_last_clicked
  selectedCountry <- summariseData(data_atDate(input$timeSlider), "District")[selectedRow, "District"]
  location <- data_evolution %>%
    distinct(`District`, Lat, Long) %>%
    filter(`District` == selectedCountry) %>%
    summarise(
      Lat  = mean(Lat),
      Long = mean(Long)
    )
  leafletProxy("overview_map") %>%
    setView(lng = location$Long, lat = location$Lat, zoom = 4)
})

summariseData <- function(df, groupBy) {
  df %>%
    group_by(!!sym(groupBy)) %>%
    summarise(
      "Confirmed" = sum(confirmed),
      "Recovered" = sum(recovered),
      "Deceased"  = sum(deceased),
      "Active"    = sum(active)
    ) %>%
    as.data.frame()
}

getSummaryDT <- function(data, groupBy, selectable = FALSE) {
  datatable(
    na.omit(summariseData(data, groupBy)),
    rownames  = FALSE,
    options   = list(
      order          = list(1, "desc"),
      scrollX        = TRUE,
      scrollY        = "37vh",
      scrollCollapse = T,
      dom            = 'ft',
      paging         = FALSE
    ),
    selection = ifelse(selectable, "single", "none")
  )
}