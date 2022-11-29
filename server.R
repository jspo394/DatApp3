#librerias cargadas
library(shiny)
library(janitor)
library(DT)
library(ggplot2)


shinyServer(function(input, output, session){
  
  
  
  
  #muestra el icono con información de los creadores
  observeEvent(input$openModal, {
    showModal(
      modalDialog(title = "Autores Dashboard",
                  p("Contacto:"),
                  p("Diana Marcela Velez Posso","-dmvelezp@unadvirtual.edu.co"),
                  p("Jhoan Sebastian Padilla Ortiz","-jspadillao@unadvirtual.edu.co"),
      )
    )
  })
  #lee los datos del archivo csv
  datos<-eventReactive(input$go,{
    tmp<-read.csv(input$archivo$datapath, encoding = "UTF-8")
    tmp<-janitor::clean_names(tmp)
    return(tmp)
  })
  
  #muestra la tabla
  output$tabla<-DT::renderDT({
    if(class(datos())!="data.frame") NULL
    DT::datatable(datos(),rownames = F,
                  options = list(scrollX=TRUE, fixedColumns=TRUE))
    
  })
  
  #trae los campos del archivo csv
  observe({

    updateSelectInput(session = session,inputId ="varx",choices = c("ninguna",names(datos())))
    updateSelectInput(session = session,inputId ="vary",choices = c("ninguna",names(datos())))
    updateSelectInput(session = session,inputId ="col",choices = c("ninguna",names(datos())))
  })
  #permite seleccionar de los campos del archivo csv
  g<-reactive({


    if (input$varx == "ninguna" & input$vary != "ninguna"){
      xval<-NULL
      yval<-input$vary

    }else if(input$varx!="ninguna" & input$vary == "ninguna"){
      xval<-input$varx
      yval<-NULL
    }else if(input$varx != "ninguna"&input$vary != "ninguna"){
      xval<-input$varx
      yval<-input$vary
    }

    if(input$col=="ninguna")col<-NULL
    if(input$col != "ninguna")col<-input$col

    tryCatch(data=datos(),xval=xval)

            
  })
#falta organizar la parte de la grafica para que se muestre lo que el usuario elige
    output$grafico<-renderPlot({
      ggplot(data = g(), aes_string(x = input$varx, y = input$vary,
                                    fill = input$col))+geom_bar()


  })

    
})
  
