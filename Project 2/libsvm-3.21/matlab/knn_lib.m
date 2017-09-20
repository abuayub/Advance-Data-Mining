function [acc] = knn_lib(train,test,trainLabels,testLabels)
c=0;
n=size(testLabels,1);
class = knnclassify(test,train,trainLabels,5);
for i=1:n
    if class(i)== testLabels(i)
        c = c+1;        
    end
end
acc =(c/n)*100;
end