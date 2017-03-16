header <- dashboardHeader(title="MlR")

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

dynamic_ui <- fluidRow(
        box(background = "blue",width=5,selectInput("class_algo",'Algorithm List',choices=c("Support Vector Machine"="c_svm","Random Forest"="c_rf","K Nearest Neighbor"="c_knn")),numericInput("cv","Cross Validation",value=1,step=1),sliderInput("split","Train Size",min=0.0,max=1.0,value=0.8)),
        column(width=5,uiOutput("ui_class"))
    )

ui <- dashboardPage(header,sidebar,body)
