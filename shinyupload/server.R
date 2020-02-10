function(input, output){
  #BOOK 1
  book_title_1 <- reactive({
    input$in1
  })
  book_image_1 <- reactive({
    src <- books %>% filter(book_title == input$in1) %>% select(image_url) %>% top_n(1)
    image_src <- as.character(src[[1]][1])
    image_src
  })
  book_descrip_1 <- reactive({
    descript_1 <- books %>% filter(book_title == input$in1) %>% select(book_desc) %>% top_n(1)
    description_book_1 <- as.character(descript_1[[1]][1])
    description_book_1
  })
  #BOOK 2
  book_title_2 <- reactive({
    result_book_2 = books %>% filter(book_title == input$in1) %>% select(Pointer) %>% top_n(1)
    result_book_2 <- as.character(result_book_2[[1]][1])
    result_book_2
  })
  book_image_2 <- reactive({
    result_book_2 <- book_title_2()
    src_2 <- books %>% filter(book_title == as.character(result_book_2)) %>% select(image_url) %>% top_n(1)
    image_src_2 <- as.character(src_2[[1]][1])
    image_src_2
  })
  book_descrip_2 <- reactive({
    result_book_2 <- book_title_2()
    descript_2 <- books %>% filter(book_title == as.character(result_book_2)) %>% select(book_desc) %>% top_n(1)
    description_book_2 <- as.character(descript_2[[1]][1])
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
      geom_density(alpha=.3) +
      labs(title="Distribution for Number of Pages", y="Denisty", x="Page Count")
    Desnity
  })
  
  box_plot_genre <- reactive({
    box_plot <- books %>% 
      select(book_rating,genre) %>% 
      drop_na(book_rating) %>% 
      filter((genre == input$in2) | (genre == input$in3))
    
    g2 <- ggplot(box_plot,aes(x = genre, y = book_rating)) + 
      geom_boxplot() +
      scale_fill_manual(values=c("mistyrose", "powderblue")) +
      labs(title="Box plot of Ratings", y="Rating", x="Genre")
    g2
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
  
  Author_bar <- reactive({
    selected_author <- books %>% filter(author == input$in4)
    
    genre_grouping <- 
      selected_author %>% 
      drop_na(book_rating) %>% 
      group_by(genre) %>% 
      summarise(rating_average = mean(book_rating)) %>% 
      arrange(desc(rating_average))
    
    
    
    g2 <- gvisBarChart(genre_grouping, options = bar_plot_options)
  })
  author_rating <- reactive({
    rating <- books %>% 
      filter(author == input$in4) %>% 
      drop_na(book_rating) %>% 
      distinct(book_title,.keep_all = TRUE) %>% 
      summarise(avg = mean(book_rating)) %>% 
      select(avg) %>% 
      round(digits = 2)
    rating <- rating[[1]]
  })
  author_page_avg <- reactive({
    selected_author <- books %>% 
      filter(author == input$in4) %>% 
      drop_na(book_pages) %>% 
      distinct(book_title,.keep_all = TRUE) %>% 
      summarise(avg = mean(book_pages)) %>% 
      select(avg) %>% 
      round()
    rating <- selected_author[[1]]
  })
  author_top_rated <- reactive({
    top_book <- books %>% 
      filter(author == input$in4) %>% 
      drop_na(book_rating) %>% 
      distinct(book_title,.keep_all = TRUE) %>% 
      arrange(desc(book_rating)) %>% 
      select(book_title) %>% 
      top_n(1)
    Top_book <- as.character(top_book[[1]])
  })

  
  
##### OUTPUTS #####
  
  #BOOK 1
  output$out1 <- renderText({
    c('<H1>',book_title_1(),'</H1>')
  })
  output$out2 <- renderText({
    c('<img src="',book_image_1(),'"width="100%" height="500">')
  })
  output$out3 <- renderText({
    book_descrip_1()
  })
  
  #BOOK 2
  output$out4 <- renderText({
    c('<H1>',book_title_2(),'</H1>')
  })
  output$out5 <- renderText({
    c('<img src="',book_image_2(),'"width="100%" height="500">')
  })
  output$out6 <- renderText({
    book_descrip_2()
  })
  #GENRE
  output$out7 <- renderPlot({
    genre_density()
  })
  output$out8 <- renderPlot({
    box_plot_genre()
  })
  #AUTHOR
  output$out10 <- renderGvis({
    Author_scatter()
  })
  output$out11 <- renderGvis({
    Author_bar()
  })
  output$out12 <- renderText({
    author_rating()
  })
  output$out13 <- renderText({
    author_page_avg()
  })
  output$out14 <- renderText({
    author_top_rated()
  })
}
































