library(shinydashboard)
library(shiny)
library(dplyr)
library(readr)
library(janitor)
library(ggplot2)

menstruacion <- read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-12-04/menstruaccion.csv") %>%
  clean_names()

menstruacion$precio_por_unidad <- as.numeric(menstruacion$precio_por_unidad)

ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Menstruación Dashboard"),
  dashboardSidebar(
    radioButtons("categoria_input", "Seleccionar Categoría", 
                 choices = unique(menstruacion$categoria),
                 selected = unique(menstruacion$categoria)[1]),
    
    numericInput("precio_input", "Precio por unidad", 
                 value = mean(menstruacion$precio_por_unidad, na.rm = TRUE), 
                 min = 0, max = 500),
    
    numericInput("presentacion_input", "Presentación", 
                 value = median(menstruacion$presentacion, na.rm = TRUE),
                 min = 1, max = 32, step = 1),
    
    selectInput("marca", 
                label = "Seleccionar Marca",
                choices = unique(menstruacion$marca),
                selected = unique(menstruacion$marca)[1],
                multiple = TRUE),
    
    selectInput("sucursal_input", "Seleccionar Sucursal", 
                choices = unique(menstruacion$sucursal),
                selected = unique(menstruacion$sucursal)[1]),
    
    downloadButton("download_data_btn", "Descargar Datos")
  ),
  dashboardBody(
    tabsetPanel(
      tabPanel("Tabla de datos",
               dataTableOutput("tabla_datos")),
      
      tabPanel("Gráfico",
               plotOutput("grafico"))
    )
  )
)
