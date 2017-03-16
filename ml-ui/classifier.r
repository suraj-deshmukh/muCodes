get_results<-function(input){
    if(input$cv>1){
        folds = createFolds(y,k=input$cv)
        acc_matrix = NULL #confusion matrix variable
        if(identical(input$class_algo,"c_svm")){
            for(i in folds){
                model = svm(x[-i,],y[-i],cost=input$cost,kernel=input$kernel,degree=input$degree,coef0 = input$coef0)
                pred = predict(model,x[i,])
                table = confusionMatrix(y[i],pred)
                acc_matrix = rbind(acc_matrix,table$overall[1:2])
            }
            return(as.data.frame(acc_matrix))
        }
    }
    else{
        
    }
}
