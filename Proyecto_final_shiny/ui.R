library(shinydashboard)
library(shiny)
library(dplyr)
library(readr)
library(janitor)

menstruaccion <- read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-12-04/menstruaccion.csv") %>%
  clean_names()

ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Menstruacción Shiny App"),
  dashboardSidebar(
    radioButtons("categoria_input", "Seleccionar Categoría", 
                 choices = unique(menstruaccion$categoria)),
    numericInput("precio_max_input", "Precio Máximo", 
                 value = 100, min = 0, max = 500),
    sliderInput("calificacion_input", "Calificación", 
                value = c(1, 5), min = 1, max = 5, step = 0.1),
    selectInput("marca", 
                label = "Seleccionar Marca",
                choices = unique(menstruaccion$marca),
                selected = unique(menstruaccion$marca)[1],
                multiple = TRUE),
    selectInput("sucursal_input", "Seleccionar Sucursal", 
                choices = unique(menstruaccion$sucursal),
                selected = unique(menstruaccion$sucursal)[1])
    
  ),
  
  dashboardBody(
    textOutput("output_text_body"),
    textOutput("output_text")
  )
)
