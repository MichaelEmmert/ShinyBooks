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
    result_book_2 = Book_similarity(input$in1)
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
  
}
































