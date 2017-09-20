%Name: Abu Ayub Ansari
%UTA ID: 1001297330

%Name: Hoda Moradi
%UTA iD: 1001121261	

function [accuracy]=svm(training_label_vector, training_instance_matrix, testing_label_vector,testing_instance_matrix)
    %SVM Train
    model = svmtrain(training_label_vector, training_instance_matrix, '-s 0 -t 0 -c 1 ');% [, 'libsvm_options']);%
    
    %SVM Test
    %disp('__________Test training data____________');
    %[pl, acc,decision_values] = svmpredict(training_label_vector, training_instance_matrix, model, [, 'libsvm_options']);
    %disp('__________Test testing data__________');
    [predicted_label, accuracy,dv] = svmpredict(testing_label_vector, testing_instance_matrix, model, [, 'libsvm_options']);
    %disp('__________SVM completed. Train Model: __________');
    %disp(model);
    
end