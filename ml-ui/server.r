server <- function(input,output){
e <- new.env()

output$ui_class<-renderUI({
switch(input$class_algo,
     "c_svm" = box(width=15,background = "blue",title="Algorithm Parameters",numericInput("cost","Cost",value=1,step=0.5),
                    selectizeInput("kernel","Kernel",choices=c("radial","linear","polynomial","sigmoid")),
                    numericInput("degree","Degree",value=3,step=0.5),
                    numericInput("coef0","Coef",value=0,step=0.5)
                   ),
    "c_rf"  = box(width=15,background = "blue",title="Algorithm Parameters",numericInput("ntree","No of trees",value=500,step=1))
)
})

observeEvent(input$file,{
   assign("data",read.csv(input$file$datapath), envir = e)
})

output$model_results<-renderDataTable({
if(is.null(input$file)) { return(NULL) }
df = get("data", envir = e)
y <<- as.factor(df[,ncol(df)])  #assuming last column as target variable
x <<- as.matrix(df[,1:ncol(df)-1])

output = result()
return(output)
})

notify_modal<-function(msg){
    showModal(
        modalDialog(
            msg,easyClose = TRUE
        )
    )
}

observeEvent(input$create_model,{
    notify_modal("Gathering Input parameters And Data")
    Sys.sleep(2)
    notify_modal("Generating Model")
    Sys.sleep(2)
    out <<- get_results(input)
    if(is.data.frame(out)){
        notify_modal("Done")
    }
}
    
)

result <- eventReactive(input$create_model,{
    return(out)
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
