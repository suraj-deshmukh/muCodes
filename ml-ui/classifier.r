k_fold<-function(x,y,input){  # k= no of fold, x = data,y = target
    folds = createFolds(y,k=input$cv)
    acc_matrix = NULL #confusion matrix variable
    c_matrix = as.data.frame(as.data.frame.matrix(confusionMatrix(y,y)$table)) * 0
    if(identical(input$class_algo,"c_svm")){
        for(i in folds){
            model = svm(x[-i,],y[-i],cost=input$cost,kernel=input$kernel,degree=input$degree,coef0 = input$coef0)
            pred = predict(model,x[i,])
            table = confusionMatrix(y[i],pred)
            c_matrix = c_matrix + as.data.frame(as.data.frame.matrix(table$table))
            acc_matrix = rbind(acc_matrix,table$overall[1:2])
        }
    }
    if(identical(input$class_algo,"c_rf")){
        for(i in folds){
            model = randomForest(x[-i,],y[-i],ntree=input$ntree)
            pred = predict(model,x[i,])
            table = confusionMatrix(y[i],pred)
            c_matrix = c_matrix + as.data.frame(as.data.frame.matrix(table$table))
            acc_matrix = rbind(acc_matrix,table$overall[1:2])
        }
    }
    if(identical(input$class_algo,"c_nb")){
        for(i in folds){
            model = naiveBayes(x[-i,],y[-i])
            pred = predict(model,x[i,])
            table = confusionMatrix(y[i],pred)
            c_matrix = c_matrix + as.data.frame(as.data.frame.matrix(table$table))
            acc_matrix = rbind(acc_matrix,table$overall[1:2])
        }
    }
    fold = 1:input$cv
    acc_matrix = cbind(fold,acc_matrix)
    out<-NULL
    out$acc_matrix <- as.data.frame(acc_matrix)
    out$confusion_matrix <- c_matrix
    return(out)
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
    if(identical(input$class_algo,"c_nb")){
        model = naiveBayes(x[train_index,],y[train_index])
        pred = predict(model,x[-train_index,])
        table = confusionMatrix(y[-train_index],pred)
        acc_matrix = rbind(acc_matrix,table$overall[1:2])
    }
    out<-NULL
    out$acc_matrix <- as.data.frame(acc_matrix)
    out$confusion_matrix <- as.data.frame(as.data.frame.matrix(table$table))
    return(out)
}

get_results<-function(input){
    if(input$cv>1){
        k_fold(x,y,input)
    }
    else{
        train_test(x,y,input)
    }
}