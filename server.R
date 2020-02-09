function(input, output){
  #BOOK 1
  book_title_1 <- reactive({
    input$in1
  })
  book_image_1 <- reactive({
    src <- desc %>% filter(book_title == input$in1) %>% select(image_url) %>% top_n(1)
    image_src <- as.character(src[[1]])
    image_src
  })
  book_descrip_1 <- reactive({
    descript_1 <- desc %>% filter(book_title == input$in1) %>% select(book_desc) %>% top_n(1)
    description_book_1 <- as.character(descript_1[[1]])
    description_book_1
  })
  #BOOK 2
  book_title_2 <- reactive({
    result_book_2 = desc %>% filter(book_title == input$in1) %>% select(Pointer) %>% top_n(1)
    result_book_2 <- as.character(result_book_2[[1]][1])
    result_book_2
  })
  book_image_2 <- reactive({
    result_book_2 <- book_title_2()
    src_2 <- desc %>% filter(book_title == as.character(result_book_2)) %>% select(image_url) %>% top_n(1)
    image_src_2 <- as.character(src_2[[1]])
    image_src_2
  })
  book_descrip_2 <- reactive({
    result_book_2 <- book_title_2()
    descript_2 <- desc %>% filter(book_title == as.character(result_book_2)) %>% select(book_desc) %>% top_n(1)
    description_book_2 <- as.character(descript_2[[1]])
    description_book_2
  })
  #GENRE 1 and 2 Denisty plot
  genre_density <- reactive({
    g3 <- books %>% 
      filter((genre == input$in2) | (genre == input$in3)) %>%
      select(genre,book_pages)
    
    g3_filter <- g3 %>% 
      drop_na(book_pages) %>%
      group_by(genre) %>% 
      summarise(filter = (mean(book_pages)+sd(book_pages)*2)) %>% 
      arrange(desc(filter)) %>% top_n(1) %>% select(filter)
    
    graph3 <- g3 %>% 
      drop_na(book_pages) %>% 
      filter(book_pages < g3_filter[[1]])
    
    Desnity <- ggplot(graph3, aes(x=book_pages, fill= genre)) + 
      geom_density(alpha=.3)
    Desnity
  })
  
  Author_scatter <- reactive({
    selected_author <- books %>% filter(author == input$in4)
    graph1 <- selected_author %>% 
      select(book_rating,book_pages,book_title) %>%
      distinct(book_title,.keep_all = TRUE) %>% 
      rename(book_title.html.tooltip = book_title,
             book_rating = book_rating,
             book_pages = book_pages)
    g1 <- gvisScatterChart(graph1, options = scatter_options)
  })

  
  
  #OUTPUTS
  
  #BOOK 1
  output$out1 <- renderText({
    c('<H1>',book_title_1(),'</H1>')
  })
  output$out2 <- renderText({
    c('<img src="',book_image_1(),'"width="350" height="500">')
  })
  output$out3 <- renderText({
    book_descrip_1()
  })
  
  #BOOK 2
  output$out4 <- renderText({
    c('<H1>',book_title_2(),'</H1>')
  })
  output$out5 <- renderText({
    c('<img src="',book_image_2(),'"width="350" height="500">')
  })
  output$out6 <- renderText({
    book_descrip_2()
  })
  #GENRE
  output$out7 <- renderPlot({
    genre_density()
  })
  #AUTHOR
  output$out10 <- renderGvis({
    Author_scatter()
  })
  
}
































