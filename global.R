library(shiny)
library(dplyr)
library(googleVis)
library(rsconnect)
library(dplyr)
library(dqshiny)
library(reticulate)

#trained python model load-in
source_python('Description_Model.py')

#books <-read.csv('data/clean_books.csv')
desc <- read.csv('data/descriptions.csv')
book_title <- desc$book_title