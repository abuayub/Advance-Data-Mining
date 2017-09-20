function task2 %New LDA and 5 fold KNN
    global c;
    c = 26;
    f= 1014;
    [f1,f0]=StandardLDA();
    [x,dim]=NewLDA(66); % 25,31,36,46,56,66
    acc =0;
    file= 'Labels.csv';
    y= csvread(file);
    for k=1:+2:10
        j=1;m=1;
        if(k==9)
            train=zeros((39-7)*c,dim);
            test=zeros(7*c,dim);
            trainLabels=zeros((39-7)*c,1);
            testLabels=zeros(7*c,1);
        else
            train=zeros((39-8)*c,dim);
            test=zeros(8*c,dim);
            trainLabels=zeros((39-8)*c,1);
            testLabels=zeros(8*c,1);
        end
        i=1;
        while i<f
            if( 33 == (mod(i,39)))
                if k == mod(i,39)&& k == round(((mod(i,39)/8)*2)+1)
                    test(j:j+6,:)= x(i:i+6,:);
                    testLabels(j:j+6,:)= y(i:i+6,:);
                    j= j+7;
                else
                    train(m:m+6,:)= x(i:i+6,:);
                    trainLabels(m:m+6,:)= y(i:i+6,:);
                    m=m+7;
                end
                i=i+7;
            else
                if k == mod(i,39)|| k == round(((mod(i,39)/8)*2)+1)
                    test(j:j+7,:)= x(i:i+7,:);
                    testLabels(j:j+7,:)= y(i:i+7,:);
                    j= j+8;
                else
                    train(m:m+7,:)= x(i:i+7,:);
                    trainLabels(m:m+7,:)= y(i:i+7,:);
                    m=m+8;
                end
                i=i+8;
            end
        end
        newacc = knn_lib(train,test,trainLabels,testLabels);
        acc= acc + newacc;
        disp('Finished Standard LDA-KNN for fold:');disp(round((k/2)+.99));
        disp('Train Data after LDA:');disp(size(train));
        disp('Test Data after LDA:');disp(size(test));
        disp('Accuracy:');disp(newacc);
        %disp('KFold:');disp(k);
        %disp('size of train:');disp(size(train));
        %disp('size of test:');disp(size(test));
    end
    disp('Final Accuracy');disp(acc/5);
    end