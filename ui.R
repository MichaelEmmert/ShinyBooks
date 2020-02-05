library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    
    sidebarUserPanel("Virtual Library",
                     image = "https://www.avl.lib.al.us/sites/avlcms.asc.edu/files/slideshow-images/avl_roundshelves_globe.jpg"),
    sidebarMenu(
      menuItem("Suggestor", tabName = "suggestor", icon = icon("book")),
      menuItem("Genre", tabName = "genre", icon = icon("book-reader")),
      dashboardBody(
        

    )
    )
  )
)