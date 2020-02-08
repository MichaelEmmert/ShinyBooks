#Connecting with Python
library(reticulate)
#virtualenv_create(envname = "python_environment",python= "python3")
#reticulate::use_virtualenv("python_environment", required = F)
#virtualenv_install("python_environment", packages = c("gensim","numpy","pandas"))
library(shiny)
library(dplyr)
library(googleVis)
library(rsconnect)
library(dplyr)
library(dqshiny)
library(shinyWidgets)
#py_install(c("gensim","numpy","pandas"))

#trained python model load-in
source_python('Description_Model.py')

#books <-read.csv('data/clean_books.csv')
desc <- read.csv('data/descriptions.csv')
book_title <- desc$book_title












