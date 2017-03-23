dynamic_ui <- fluidRow(
        box(background = "blue",width=5,selectInput("class_algo",'Algorithm List',choices=c("Support Vector Machine"="c_svm","Random Forest"="c_rf","Naive Bayes"="c_nb")),numericInput("cv","Cross Validation",value=1,step=1),sliderInput("split","Train Size",min=0.0,max=1.0,value=0.8)),
        column(width=5,uiOutput("ui_class"))
    )

header <- dashboardHeader(title="MlR")

body <- dashboardBody(div(style="min-height: 650px;",
    mainPanel(
        tabsetPanel(
            tabPanel("Classification",dynamic_ui,id="class"),
            tabPanel("Model Results",textOutput("cv_or_split"),dataTableOutput("model_results"),textOutput("confusion_matrix"),dataTableOutput("model_results2"))
        )
    ))
)

sidebar <- dashboardSidebar(
fileInput("file","Upload CSV",accept=c("text/csv",".csv")),
div(style="display:inline-block;width:54%;text-align: center;",actionButton("data", label = "View Data", icon = icon("table"))),
div(style="margin-left:12px;margin-top:40px",actionButton("create_model", label = "Create Model", icon = icon("recycle")))
)

ui <- dashboardPage(header,sidebar,body)
