library(shinydashboard)
library(shiny)
library(dplyr)
library(readr)
library(janitor)
library(ggplot2)

menstruacion <- read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-12-04/menstruaccion.csv") |>
  clean_names()

menstruacion$precio_por_unidad <- as.numeric(menstruacion$precio_por_unidad)

ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(
    title = "Menstruación Dashboard",
    titleWidth = 300,
    tags$li(
      class = "dropdown",
      tags$a(
        href = "#",
        tags$img(
          src = "https://img.freepik.com/vector-gratis/productos-higiene-femenina_52683-45403.jpg?w=826&t=st=1702598573~exp=1702599173~hmac=176dbda7505962070c1199c157c8c619d82315adf3f1da8432d755001670b8f8",
          height = "100px"
        )
      )
    )
  ),
  dashboardSidebar(
    width = 300,
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    radioButtons(
      "categoria_input", 
      "Seleccionar Categoría", 
      choices = unique(menstruacion$categoria),
      selected = unique(menstruacion$categoria)[1]
    ),
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    numericInput(
      "precio_input", 
      "Precio por unidad", 
      value = mean(menstruacion$precio_por_unidad, na.rm = TRUE),
      min = 0, max = 500
    ),
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    numericInput(
      "presentacion_input", 
      "Presentación", 
      value = median(menstruacion$presentacion, na.rm = TRUE),
      min = 1, max = 32, step = 1
    ),
    selectInput(
      "marca", 
      label = "Seleccionar Marca",
      choices = unique(menstruacion$marca),
      selected = unique(menstruacion$marca)[1],
      multiple = TRUE
    ),
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    selectInput(
      "sucursal_input", 
      "Seleccionar Sucursal", 
      choices = unique(menstruacion$sucursal),
      selected = unique(menstruacion$sucursal)[1]
    ),
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    column(3, offset = 1, align = "center",
           downloadButton("download_data_btn", "Descargar Datos", icon = icon("download"))
    )
  ),
  dashboardBody(
    fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
    tabsetPanel(
      tabPanel(
        "Tabla de datos",
        dataTableOutput("tabla_datos")
      ),
      fluidRow(tags$div(style = "margin-bottom: 20px;")),  # Espacio entre filas
      tabPanel(
        "Gráfico",
        plotOutput("grafico")
      )
    )
  )
)