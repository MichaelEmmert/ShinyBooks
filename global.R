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
desc <- read.csv('data/description_with_pointer.csv')
books <- read.csv('data/clean_books.csv')

#BOOK TITLES
book_title <- desc$book_title

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
                        title="Number of Pages vs Rating", vAxis="{title:'Number of Pages'}",
                        hAxis="{title:'Book Rating'}", width=500, height=400)

scatter_options$explorer <- "{actions:['dragToZoom', 'rightClickToReset']}"
