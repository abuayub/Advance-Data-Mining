%Name: Abu Ayub Ansari
%UTA ID: 1001297330
function STDSP1
    prompt1 = 'What is the char 1? ';
    char1 = input(prompt1,'s');
    prompt2 = 'What is the char 2? ';
    char2 = input(prompt2,'s');
    disp('Running SVM on :');disp(char1);disp(char2);
    [training_label_vector, training_instance_matrix, testing_label_vector,testing_instance_matrix] = getData(char1,char2);
    %Using SVM
    
    %SVM Train
    model = svmtrain(training_label_vector, training_instance_matrix, '-s 0 -t 0 -c 1 ');% [, 'libsvm_options']);%
    
    %SVM Test
    disp('__________Test training data____________');
    [pl, acc,decision_values] = svmpredict(training_label_vector, training_instance_matrix, model, [, 'libsvm_options']);
    disp('__________Test testing data__________');
    [predicted_label, accuracy,dv] = svmpredict(testing_label_vector, testing_instance_matrix, model, [, 'libsvm_options']);
    disp('__________SVM completed. Train Model: __________');
    disp(model);
    
    %?i{yi(xi · w + b) ? 1 + ?i} = 0
    
    %w = model.SVs' * model.sv_coef;
    %b = -model.rho;
    %y = predicted_label;
    %x = testing_instance_matrix;
    %wrong_indices = testing_label_vector==predicted_label;
    %wrong_label_index = find(wrong_indices==0);
    %disp(wrong_label_index);
    alpha = model.sv_coef; 
    %slack = |decision_value| / |w|
    XI = zeros(numel(model.sv_indices),1);
    for i=1:numel(model.sv_indices)
        index_of_sv = model.sv_indices(i,:);
        distance = pl(index_of_sv,:)*decision_values(index_of_sv,:); 
        XI(i,:) = 1- distance;
    end
    disp('Size of ? (ksi) is :');disp(size(XI));
    disp('XI(?i (ksi) ):');disp(XI);
end

function [training_label_vector, training_instance_matrix, testing_label_vector,testing_instance_matrix] = getData(value1, value2)
    filealpha = 'alpha.xlsx';
    [x,alpha] = xlsread(filealpha);
    [tf, index1]= ismember(value1, alpha);
    start1 = 39*(index1-1)+1;
    [tf, index2]= ismember(value2, alpha);
    start2 = 39*(index2-1)+1;
    %disp(index1);
    %disp(index2);
    disp('Start1:');disp(start1);
    disp('Start2:');disp(start2);
    file = 'Hand_Written_Data.csv';
    fulldata =csvread(file);%,0,0,[0 0 320 77]);
    disp(size(fulldata));
    
    %training_label_vector
    training_label_vector1 = ones(1,20);%fulldata(1,start1:start1+19); %
    training_label_vector2 = -ones(1,20);%fulldata(1,start2:start2+19); %
    training_label_vector = transpose( cat(2,training_label_vector1, training_label_vector2));
    disp(size(training_label_vector));
    
    %training_instance_matrix
    training_instance_matrix1 = fulldata(2:321,start1:start1+19); %21:39
    training_instance_matrix2 = fulldata(2:321,start2:start2+19); % 40:59
    training_instance_matrix = transpose( cat(2,training_instance_matrix1, training_instance_matrix2));
    disp(size(training_instance_matrix));
    
    %testing_label_vector
    testing_label_vector1 = ones(1,19);%fulldata(1,start1+20:start1+38); %
    testing_label_vector2 = -ones(1,19);%fulldata(1,start2+20:start2+38); %
    testing_label_vector = transpose( cat(2,testing_label_vector1, testing_label_vector2));
    disp(size(testing_label_vector));
    
    
    %testing_instance_matrix
    testing_instance_matrix1 = fulldata(2:321,start1+20:start1+38); %21:39
    testing_instance_matrix2 = fulldata(2:321,start2+20:start2+38); % 60:78
    testing_instance_matrix = transpose( cat(2,testing_instance_matrix1, testing_instance_matrix2));
    disp(size(testing_instance_matrix));
end