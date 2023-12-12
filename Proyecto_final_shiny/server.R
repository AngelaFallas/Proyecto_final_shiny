# server.R

server <- function(input, output, session) {
  
  # Crear un objeto reactivo para almacenar los datos filtrados
  datos_filtrados <- reactive({
    filter(menstruacion, 
           categoria == input$categoria_input,
           precio_por_unidad <= input$precio_input,
           presentacion == input$presentacion_input,
           marca %in% input$marca,
           sucursal == input$sucursal_input)
  })
  
  # Descargar datos según las selecciones
  output$download_data_btn <- downloadHandler(
    filename = function() {
      paste("datos_", input$comercio_input, ".csv", sep = "")
    },
    content = function(file) {
      datos_seleccionados <- datos_filtrados()
      write_csv(datos_seleccionados, file)
      shinyalert("Descarga Exitosa", "Los datos se han descargado correctamente.", type = "success")
    }
  )
  
  # Mostrar tabla de datos según todas las selecciones
  output$tabla_datos <- renderDataTable({
    datos_filtrados()
  })
  
  # Mostrar gráfico de barras según todas las selecciones
  output$grafico <- renderPlot({
    sucursal_seleccionada <- input$sucursal_input
    datos_grafico <- filter(menstruacion, sucursal == sucursal_seleccionada)
    
    ggplot(datos_grafico, aes(x = marca, y = precio_por_unidad, color = marca)) +
      geom_line() +
      labs(title = paste("Relación de marca - precio en la sucursal:", sucursal_seleccionada),
           x = "Marca",
           y = "Precio por Unidad") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  
}

shinyApp(ui, server)
