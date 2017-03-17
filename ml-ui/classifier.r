k_fold<-function(x,y,input){  # k= no of fold, x = data,y = target
    folds = createFolds(y,k=input$cv)
    acc_matrix = NULL #confusion matrix variable
    if(identical(input$class_algo,"c_svm")){
        for(i in folds){
            model = svm(x[-i,],y[-i],cost=input$cost,kernel=input$kernel,degree=input$degree,coef0 = input$coef0)
            pred = predict(model,x[i,])
            table = confusionMatrix(y[i],pred)
            acc_matrix = rbind(acc_matrix,table$overall[1:2])
        }
    }
    if(identical(input$class_algo,"c_rf")){
        for(i in folds){
            model = randomForest(x[-i,],y[-i],ntree=input$ntree)
            pred = predict(model,x[i,])
            table = confusionMatrix(y[i],pred)
            acc_matrix = rbind(acc_matrix,table$overall[1:2])
        }
    }
    fold = 1:input$cv
    acc_matrix = cbind(fold,acc_matrix)
    return(as.data.frame(acc_matrix))
}

train_test<-function(x,y,input){  # k= no of fold, x = data,y = target
    train_index = as.array(createDataPartition(y,p=input$split)$Resample1)
    acc_matrix = NULL #confusion matrix variable
    if(identical(input$class_algo,"c_svm")){
        model = svm(x[train_index,],y[train_index],cost=input$cost,kernel=input$kernel,degree=input$degree,coef0 = input$coef0)
        pred = predict(model,x[-train_index,])
        table = confusionMatrix(y[-train_index],pred)
        acc_matrix = rbind(acc_matrix,table$overall[1:2])
    }
    if(identical(input$class_algo,"c_rf")){
        model = randomForest(x[train_index,],y[train_index],ntree=input$ntree)
        pred = predict(model,x[-train_index,])
        table = confusionMatrix(y[-train_index],pred)
        acc_matrix = rbind(acc_matrix,table$overall[1:2])
    }
    return(as.data.frame(acc_matrix))
}

get_results<-function(input){
    if(input$cv>1){
        k_fold(x,y,input)
    }
    else{
        train_test(x,y,input)
    }
}