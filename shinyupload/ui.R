dashboardPage(
  dashboardHeader(title = "Virtual Library"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Book Suggester", tabName = "booksug",icon = icon("book")),
      autocomplete_input(id = "in1",
                         label = "Your Favorite Book:",
                         value = "The Hunger Games",
                         placeholder = "Title",
                         options = book_title, 
                         max_options = 10),
      menuItem("Author", tabName = "author", icon = icon("pen")),
      autocomplete_input(id = "in4",
                         label = "Author",
                         value = "Mark Twain",
                         placeholder = "Author Name",
                         options = authors,
                         max_options = 10),
      menuItem("Genre Analysis", tabName = "genre", icon = icon("book-reader")),
      h3('Genres'),
      hr(),
      numericInput("in5", "Range in standard Deviations", 1),
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
      hr(),
      h4("Ratings by Page Count"),
      hr(),
      sliderInput("in6", label = h2("Page Range"), min = 0, 
                  max = 2000, value = c(0, 200)),
      radioButtons('in7', label = h2("Interval"), c(25,50,100,200), selected = 50, inline = FALSE
      ),
     menuItem("About Me", tabName = "aboutme", icon = icon("user"))
    )
    
  ),
  dashboardBody(
    tabItems(
      #BOOK Suggestor
      tabItem(tabName = "booksug",
        fluidRow(
          column(6,
                 
                 htmlOutput('out1'),
                 
                 htmlOutput('out2'),
                 hr(),
                 box(
                   title = "Description:",
                   width = '100%',
                 textOutput('out3'),
                 h4("Author: "),
                 textOutput('out15'),
                 h4("Top Genre: "),
                 textOutput('out16')
                 )
          ),
          column(6, 
                 
                 htmlOutput('out4'),
                 htmlOutput('out5'),
                 hr(),
                 box(
                   title = "Description:",
                   width = '100%',
                 textOutput('out6'),
                 h4("Author: "),
                 textOutput('out17'),
                 h4("Top Genre: "),
                 textOutput('out18')
              
                 )
          )
        )
      
    
  
  ),
  #Genre Analysis
      tabItem(tabName = "genre",
                  fluidRow(
                           plotOutput('out7'),
                           plotOutput('out8'),
                           plotOutput('out9')
                          )
                  
                ),
  tabItem(tabName = "author",
              fluidRow(
                column(12,
                       infoBoxOutput("out12"),
                       infoBoxOutput("out13"),
                       infoBoxOutput("out14")
                       ),
                column(6, 
                       htmlOutput('out10')),
                column(6, 
                       htmlOutput('out11')
                       )
              )
              ),
  tabItem(tabName = "aboutme",

            h1("Michael Emmert"),
            h3("GitHub"),
         tags$a(href="https://github.com/MichaelEmmert?tab=repositories", "My Github"),
            h3("LinkedIn"),
         tags$a(href="https://www.linkedin.com/in/michael-emmert-13558014a/", "My LinkedIn")


          )
            
      )
)

)

