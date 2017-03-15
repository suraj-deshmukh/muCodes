library(shiny)
library(shinydashboard)
library(shinyBS)
library(e1071)
library(randomForest)
library(caret)

header <- dashboardHeader(title="MlR")

dynamic_ui <- fluidRow(
        box(background = "blue",width=5,selectInput("class_algo",'Algorithm List',choices=c("Support Vector Machine"="c_svm","Random Forest"="c_rf","K Nearest Neighbor"="c_knn")),numericInput("cv","Cross Validation",value=1,step=1),sliderInput("split","Train Size",min=0.0,max=1.0,value=0.8)),
        column(width=5,uiOutput("ui_class"))
    )


body <- dashboardBody(
    mainPanel(
        tabsetPanel(
            tabPanel("Classification",dynamic_ui,id="class"),
            tabPanel("Model Results",h2(textOutput("cross_or_split")),dataTableOutput("model_results"))
        )
    )
)

sidebar <- dashboardSidebar(
fileInput("file","Upload CSV",accept=c("text/csv",".csv")),
div(style="display:inline-block;width:54%;text-align: center;",actionButton("data", label = "View Data", icon = icon("table")))
)

ui <- dashboardPage(header,sidebar,body)

server <- function(input,output){
e <- new.env()
#output$table <- renderDataTable(iris, list(lengthMenu = c(5, 30, 50), pageLength = 5))


output$ui_class<-renderUI({
switch(input$class_algo,
     "c_svm" = box(width=15,background = "blue",title="Algorithm Parameters",numericInput("cost","Cost",value=1,step=0.5),
                    selectizeInput("kernel","Kernel",choices=c("radial","linear","polynomial","sigmoid")),
                    numericInput("degree","Degree",value=3,step=0.5),
                    numericInput("coef0","Coef",value=0,step=0.5)
                   ),
    "c_rf"  = box(width=15,background = "blue",title="Algorithm Parameters",numericInput("ntree","No of trees",value=500,step=1)),
    "c_knn" = box(width=15,background = "blue",title="Algorithm Parameters",numericInput("k", "K",value = 3,step=2))
)
})

observeEvent(input$file,{
   assign("data",read.csv(input$file$datapath), envir = e)
})

output$model_results<-renderDataTable({
if(is.null(input$file)) { return(NULL) }
df = get("data", envir = e)
y = as.factor(df[,ncol(df)])  #assuming last column as target variable
x = as.matrix(df[,1:ncol(df)-1])
if(identical(input$class_algo,"c_svm")){
    model = svm(x,y,cross=input$cv)
    Summary = summary(model)
    accuracies = Summary$accuracies
    fold = 1:length(accuracies)
    tab = cbind(fold,accuracies)
    print(tab)
    as.data.frame(tab)   #showing results
}
})


output$cross_or_split<-renderText({
if(is.null(input$file)) { return(NULL) }
if(input$cv>1){"Cross Validation Results"}
else{"Test Set Results"}
})

observeEvent(input$data,{
showModal(
    modalDialog(
        #renderDataTable(read.csv(input$file$datapath), list(lengthMenu = c(5, 30, 50), pageLength = 5)),
        if(is.null(input$file))
        { "Please Upload File" }
        else
        {renderDataTable(get("data", envir = e), list(lengthMenu = c(5, 30, 50), pageLength = 5))},
        size="l",
        title = "Dataset")
    )
})

}

shinyApp(ui,server)
