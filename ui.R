
#librerias cargadas
library(shiny)
library(janitor)
library(DT)
library(ggplot2)

#menu inicial donde se carga el documento

shinyUI(
  navbarPage(title="DatApp 2.0",tags$li(actionLink("openModal", label = "",
                                                   icon = icon("address-book")),class = "dropdown"),
             tabPanel("Cargar documento",
                      sidebarLayout(
                      sidebarPanel(
                        fileInput(inputId="archivo", label="Sube archivo:"),
                        actionButton("go","Cargar datos")
                      ),
                      mainPanel(
                        DT::DTOutput(outputId = "tabla")
                      )
             )
             
  ),
  #menu para graficar
  tabPanel("Graficador",
           sidebarPanel(
              selectInput(inputId = "varx","Variable 1",choices=NULL),
              selectInput(inputId = "vary","Variable 2",choices=NULL),
              selectInput(inputId = "col","Variable color",choices=NULL)
             ),
           mainPanel(
             plotOutput(outputId = "grafico")
           
                    )
          )
           )
    )

