
dashboardPage(
  dashboardHeader(title = "Virtual Library"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Book Suggestor", tabName = "booksug",icon = icon("book")),
      menuItem("Genre Analysis", tabName = "genre", icon = icon("book-reader")),
      menuItem("Author", tabName = "author", icon = icon("typewriter", lib = "font-awesome"))
    )
    
  ),
  dashboardBody(
    tabItems(
      #BOOK Suggestor
      tabItem(tabName = "booksug",
    sidebarLayout(
      
      sidebarPanel(
        autocomplete_input(id = "in1",
                           label = "Your Favorite Book:",
                           value = "The Hunger Games",
                           placeholder = "Book Name Here",
                           options = book_title, 
                           max_options = 10),
        width = 3
      ),

      mainPanel(
        fluidRow(
          column(6,
                 
                 htmlOutput('out1'),
                 
                 htmlOutput('out2'),
                 box(
                   title = "Description:",
                   background = "light-blue",
                   width = '100%',
                 textOutput('out3')
                 )
          ),
          column(6, 
                 
                 htmlOutput('out4'),
                 htmlOutput('out5'),
                 box(
                   title = "Description:",
                   background = "light-blue",
                   width = '100%',
                 textOutput('out6'))
          )
        )
      )
    )
  
  ),
  #Genre Analysis
      tabItem(tabName = "genre",
              sidebarLayout(
                sidebarPanel(
                  autocomplete_input(id = "in2", 
                                     label = "Genre 1", 
                                     value = "Fiction",
                                     placeholder = "Pick a Genre",
                                     options = genre_options, 
                                     max_options = 5),
                  autocomplete_input(id = "in3", 
                                     label = "Genre 2", 
                                     value = "Young Adult",
                                     placeholder = "Pick a Genre",
                                     options = genre_options,
                                     max_options = 5),
                  width = 3
                ),

                
                   
                mainPanel(
                  fluidRow(
                    column(12,
                           plotOutput('out7'),
                           plotOutput('out8')
                    )
                    
                    )
                  )
                )
              ),
  tabItem(tabName = "author",
          sidebarLayout(
            sidebarPanel(
              autocomplete_input(id = "in4",
                                 label = "Author",
                                 value = "Mark Twain",
                                 placeholder = "Author Name",
                                 options = authors,
                                 max_options = 10),
              width = 3
            ),
            
            
            
            mainPanel(
              fluidRow(
                column(12,
                       box(      
                         title = "Average Book Rating",
                         background = "green",
                         width = 4,
                         textOutput('out12')
                       ),
                       box(      
                         title = "Average Number of Pages",
                         background = "blue",
                         width = 4,
                         textOutput('out13')
                       ),
                       box(      
                         title = "Top Rated Book",
                         background = "red",
                         width = 4,
                         textOutput('out14')
                       )
                       ),
                column(6,
                       htmlOutput('out11')),
                column(6,
                       htmlOutput('out10')
                       )
              )
              )
            )
          )
      )
)

)

