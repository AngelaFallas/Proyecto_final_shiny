

server <- function(input, output, session) {
  output$output_text <- renderText({
    paste("Categoría seleccionada:", input$categoria_input)
  })
  
  output$output_text_body <- renderText({
    paste("Texto en el cuerpo del panel")
  })
}

shinyApp(ui, server)

