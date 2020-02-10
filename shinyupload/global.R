library(shiny)
library(dplyr)
library(googleVis)
library(rsconnect)
library(tidyr)
library(dqshiny)
library(shinyWidgets)
library(shinydashboard)
library(ggplot2)

#Data
books <- read.csv('data/Single_dataframe.csv')
#BOOK TITLES
book_title <- unique(books$book_title)

#GENRES
genre_options <- books %>% 
  group_by(genre) %>% 
  summarise(count_ = n()) %>% 
  arrange(desc(count_)) %>% 
  filter(count_ > 200) %>% 
  select(genre)
genre_options <- genre_options$genre

#Authors
authors <- unique(books$author)

scatter_options <- list(legend="none",
                        pointSize=3,
                        title="Number of Pages vs Rating", 
                        vAxis="{title:'Number of Pages'}",
                        hAxis="{title:'Book Rating'}", 
                        width=500, 
                        height=400,
                        backgroundColor = '#ECF0F5'
                        )

scatter_options$explorer <- "{actions:['dragToZoom', 'rightClickToReset']}"


bar_plot_options = list(legend="none",
                        title="Ratings by Genre",
                        vAxis="{title:'Genre'}",
                        hAxis="{title:'Rating'}",
                        width=400,
                        height=1000,
                        backgroundColor = '#ECF0F5'
                        )

bar_plot_options$explorer <- "{actions:['dragToZoom', 'rightClickToReset']}"






































