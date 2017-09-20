function [Y1,k] = NewLDA(k)
    global Sb Sw X S_t
    S_p=Sb;
    S_l=Sw;
    [U,T,V] = svd(S_t);
    % ...
    T =T(T>0);
    m = size(T,1);
    sp_u=U'*S_p*U;
    st_u=U'*S_t*U;
    %k=31;
    V0= orth(randn(320,k));
    %V0 = randn(320,k);
    i=1;
    while true %i<=50
    %for i=1:50
        lambda(i)=(trace(V0'*sp_u*V0))/(trace(V0'*st_u*V0));

        V1=sp_u-lambda(i)*st_u;
        [eV,eD] = eig(V1);
        [~, indexED] = sort(diag(eD),'descend');
        eV = eV(:, indexED(1:k));

        st_v=eV*eV'*st_u*(eV*eV');

        [Un,Tn,Vn] = svd(st_v);
        [~, indexTn] = sort(diag(Tn),'descend');
        Un = Un(:, indexTn(1:k));

        err(i)=norm(Un-V0);
        V0=Un;
        
        condition=sqrt(k*m)*10^(-4);
        if err(i)<condition
            break;
        end
        i=i+1;
    end
    w2=U*V0;
    Y1=X*w2;
    figure
    plot(err);
    title('Error');
    figure
    plot(lambda);
    title('Lambda');
end
