library(shiny)
library(rPython)

python.load("code.py")


server <- shinyServer(function(input, output) {

observe<-reactive({
if(is.null(input$files)) return(NULL)
})

output$images<- renderImage({
    file <- input$files
    outfile <- file$datapath
    name <- file$name
    upload_path = "/home/suraj/Documents/aparna/images/"
    file_path <<- paste(upload_path,name,sep="")
    command = paste("mv",outfile,file_path,sep=" ")
    if(is.null(input$files)==FALSE) system(command)
    list(src=file_path,width=300,height=400,alt="")
},deleteFile=FALSE)

output$prediction <- renderText({

if(is.null(input$files)) return(NULL)
python.call("scenes_predict",file_path)
})


})

ui <- shinyUI(fluidPage(
  titlePanel("Uploading Files"),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId = 'files', 
                label = 'Select an Image',
                multiple = FALSE,
                accept=c('image/png', 'image/jpeg'))
    ),
    mainPanel(
      imageOutput('images'),
      textOutput("prediction")
    )
  )
))

shinyApp(ui=ui,server=server)
