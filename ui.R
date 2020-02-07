fluidPage(
  titlePanel("Virtual Library"),
  sidebarLayout(
    sidebarPanel(
      autocomplete_input("in1", "Your Favorite Book:", book_title, max_options = 10)
    ),
    mainPanel(
      fluidRow(
        column(6, 
               textOutput('out1'),
               htmlOutput('out2'),
               textOutput('out3')
               ),
        column(6, 
               textOutput('out4'),
               htmlOutput('out5'),
               textOutput('out6'))
      )
    )
  )
)
