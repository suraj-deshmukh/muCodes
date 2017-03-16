get_results<-function(){
    if(input$cv>1){
        if(identical(input$class_algo,"c_svm")){
            folds = createFolds(y,k=input$cv)
            c_matrix = NULL #confusion matrix variable
            for(i in folds){
                model = svm(x[-i,])
            }
        }
    }
    else{
        
    }
}