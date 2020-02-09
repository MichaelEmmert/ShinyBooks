
dashboardPage(
  dashboardHeader(title = "Virtual Library"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Book Suggestor", tabName = "booksug",icon = icon("book")),
      menuItem("Genre Analysis", tabName = "genre", icon = icon("book-reader")),
      menuItem("Author", tabName = "author", icon = icon("Author"))
    )
    
  ),
  dashboardBody(
    tabItems(
      #BOOK Suggestor
      tabItem(tabName = "booksug",
    sidebarLayout(
      
      sidebarPanel(
        autocomplete_input("in1", "Your Favorite Book:", book_title, max_options = 10),
        width = 3
      ),
      
      
      
      
      mainPanel(
        fluidRow(
          column(6,
                 
                 htmlOutput('out1'),
                 hr(),
                 htmlOutput('out2'),
                 hr(),
                 textOutput('out3')
          ),
          column(6, 
                 htmlOutput('out4'),
                 hr(),
                 htmlOutput('out5'),
                 hr(),
                 textOutput('out6')
          )
        )
      )
    )
  
  ),
  #Genre Analysis
      tabItem(tabName = "genre",
              sidebarLayout(
                sidebarPanel(
                  autocomplete_input("in2", "Genre 1", genre_options, max_options = 5),
                  autocomplete_input("in3", "Genre 2", genre_options, max_options = 5),
                  width = 3
                ),

                
                   
                mainPanel(
                  fluidRow(
                    column(12,
                           plotOutput('out7'))
                    )
                  )
                )
              ),
  tabItem(tabName = "author",
          sidebarLayout(
            sidebarPanel(
              autocomplete_input("in4", "Author", authors, max_options = 10),
              width = 3
            ),
            
            
            
            mainPanel(
              fluidRow(
                column(12,
                       htmlOutput('out10'))
              ))))
      )
)

)

