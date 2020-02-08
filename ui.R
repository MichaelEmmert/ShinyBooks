fluidPage(
  setBackgroundColor(
    color = "AliceBlue",
    gradient =  "radial",
    direction = "bottom",
    shinydashboard = FALSE
  ),
  titlePanel("Virtual Library"),
  sidebarLayout(
    sidebarPanel(
      autocomplete_input("in1", "Your Favorite Book:", book_title, max_options = 10),
      submitButton()
    ),
    mainPanel(
      fluidRow(
        column(6, 
               htmlOutput('out1'),
               htmlOutput('out2'),
               textOutput('out3')
               ),
        column(6, 
               htmlOutput('out4'),
               htmlOutput('out5'),
               textOutput('out6'))
      )
    )
  )
)
