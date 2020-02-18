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
  book_author_1 <- reactive({
    author_1 <- books %>% filter(book_title == input$in1) %>% select(author) %>% top_n(1)
    author1 <- as.character(author_1[[1]][1])
    author1
  })
  book_genre_1 <- reactive({
    genre_1 <- books %>% filter(book_title == input$in1) %>% select(genre) %>% top_n(1)
    genre1 <- as.character(genre_1[[1]][1])
    genre1
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
  book_author_2 <- reactive({
    result_book_2 <- book_title_2()
    author_2 <- books %>% filter(book_title == result_book_2) %>% select(author) %>% top_n(1)
    author2 <- as.character(author_2[[1]][1])
    author2
  })
  book_genre_2 <- reactive({
    result_book_2 <- book_title_2()
    genre_2 <- books %>% filter(book_title == result_book_2) %>% select(genre) %>% top_n(1)
    genre2 <- as.character(genre_2[[1]])
    genre2
  })
  #GENRE 1 and 2 Denisty plot
  genre_density <- reactive({
    g3 <- books %>% 
      filter((genre == input$in2) | (genre == input$in3)) %>%
      select(genre,book_pages)
    
    g3_filter <- g3 %>% 
      drop_na(book_pages) %>%
      group_by(genre) %>% 
      summarise(filter = (mean(book_pages)+sd(book_pages)*input$in5)) %>% 
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
    
    box_plot_filter <- box_plot%>% 
      drop_na(book_rating) %>%
      group_by(genre) %>% 
      summarise(filter_high = (mean(book_rating)+sd(book_rating)*input$in5), filter_low = (mean(book_rating)-sd(book_rating)*input$in5)) %>% 
      arrange(desc(filter_high), desc(filter_low)) %>% select(filter_high,filter_low)
    
    box_plot <- box_plot %>% 
      filter((book_rating < box_plot_filter[[1]]) & (book_rating > box_plot_filter[[2]]) )
    
    g2 <- ggplot(box_plot,aes(y = book_rating, fill = genre)) + 
      geom_boxplot(alpha=.3) +
      labs(title="Ratings BoxPlot", y="Rating", x="Genre")

    g2
  })
  rating_by_page_count <- reactive({
    page_range_rating <- books %>% 
      select(genre,book_rating,book_pages) %>% 
      drop_na(book_rating) %>% 
      drop_na(book_pages) %>% 
      filter((genre == input$in2) | (genre == input$in3))
    
    range_bottom = input$in6[1]
    range_top = input$in6[2]
    interval = as.numeric(input$in7)
    
    page_range_rating <- page_range_rating %>% 
      group_by(genre, page_bucket=cut(book_pages, breaks= seq(range_bottom, range_top, by = interval)) ) %>% 
      summarise(rating_ave = mean(book_rating)) %>% 
      arrange(as.numeric(page_bucket)) %>% 
      drop_na(page_bucket)
    
    g2 <- ggplot(page_range_rating,aes(x= page_bucket, y = rating_ave)) + 
      geom_col(aes(fill = genre), position = 'dodge',alpha = 0.7) +
      labs(title="Rating vs page count", y="Average Rating", x="Number of pages")
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
    c('<img src="',book_image_1(),'"width="70%" height = "600">')
  })
  output$out3 <- renderText({
    book_descrip_1()
  })
  output$out15 <- renderText({
    book_author_1()
  })
  output$out16 <- renderText({
    book_genre_1()
  })
  
  #BOOK 2
  output$out4 <- renderText({
    c('<H1>',book_title_2(),'</H1>')
  })
  output$out5 <- renderText({
    c('<img src="',book_image_2(),'"width="70%" height = "600">')
  })
  output$out6 <- renderText({
    book_descrip_2()
  })
  output$out17 <- renderText({
    book_author_2()
  })
  output$out18 <- renderText({
    book_genre_2()
  })
  #GENRE
  output$out7 <- renderPlot({
    genre_density()
  })
  output$out8 <- renderPlot({
    box_plot_genre()
  })
  output$out9 <- renderPlot({
    rating_by_page_count()
  })
  #AUTHOR
  output$out10 <- renderGvis({
    Author_scatter()
  })
  output$out11 <- renderGvis({
    Author_bar()
  })
  output$out12 <- renderInfoBox({
    infoBox(
      "Avg Book Rating", author_rating(), icon = icon("thumbs-up"),
      color = "green", fill = T)
  })
  output$out13 <- renderInfoBox({
    infoBox(
      "Avg Page count", author_page_avg(), icon = icon("book"),
      color = "purple", fill = T)
  })
  output$out14 <- renderInfoBox({
    infoBox(
      "Top Book", author_top_rated(), icon = icon("trophy"),
      color = "blue", fill = T)
  })
}

