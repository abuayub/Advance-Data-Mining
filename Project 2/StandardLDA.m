filename = 'HandWrittenLetters.txt';
delimiterIn = ',';
headerlinesIn = 0;
no_dims=25;
M = importdata(filename,delimiterIn,headerlinesIn);
d=M';
% except col1 which is the class id get all other columns 
X=d(:,2:321);
% get first column
L=d(:,1);
% normalize data
X=normr(X);
% unique of claases in out data 26 different class
Classes=unique(L)';
% number of classes
k=numel(Classes);
% create a matrix of zeros 26*1
n=zeros(k,1);
%returns a 26-by-1 cell array
C=cell(k,1);
% calculate the mean for each column
M=mean(X);
S=cell(k,1);
Sw=0;
Sb=0;
for j=1:k
    Xj=X(L==Classes(j),:);
    n(j)=size(Xj,1);
    C{j}=mean(Xj);
    S{j}=0;
    for i=1:n(j)
        S{j}=S{j}+(Xj(i,:) - C{j})'*(Xj(i,:) - C{j});
    end
    Sw=Sw+S{j};
    Sb=Sb+n(j)*(C{j}-M)'*(C{j}-M);
end
S_t=Sw+Sb;
invSw=inv(Sw);
[E, lambda] = eig(Sb, Sw);
[lambda, ind] = sort(diag(lambda), 'descend');
W = E(:,ind(1:no_dims));
Y=X*W; 
