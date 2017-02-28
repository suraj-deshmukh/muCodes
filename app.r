library(shiny)
library(shinydashboard)
library(shinyBS)

header <- dashboardHeader(title="MlR")

body <- dashboardBody(
    mainPanel(
        tabsetPanel(
            tabPanel("Classification")
        )
    )
)

sidebar <- dashboardSidebar(
fileInput("file","Upload CSV",accept=c("text/csv",".csv")),
div(style="display:inline-block;width:54%;text-align: center;",actionButton("data", label = "View Data", icon = icon("table")))
)

ui <- dashboardPage(header,sidebar,body)

server <- function(input,output){

#output$table <- renderDataTable(iris, list(lengthMenu = c(5, 30, 50), pageLength = 5))

observeEvent(input$data,{
showModal(
    modalDialog(
        renderDataTable(read.csv(input$file$datapath), list(lengthMenu = c(5, 30, 50), pageLength = 5)),
        size="l")
    )
})

}

shinyApp(ui,server)
