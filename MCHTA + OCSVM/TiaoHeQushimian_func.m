function [a_par,b_par,d_par,num,U] = Main_func(A,B1,M,N,CL,newfolder)

[i,j] = size(A);    
[m,n] = size(B1);    

C = [A B1];
D =  1/m * C' * C;

S11 = D(1:j,1:j);
S12 = D(1:j,j+1:j+n);
S21 = D(j+1:j+n,1:j);
S22 = D(j+1:j+n,j+1:j+n);

Temp = inv(S22) * S21 * inv(S11) * S12;

[b,lamdaFang] = eig(Temp);

r = 0;
for e=1:1:n
    if(lamdaFang(e,e)>0 && isreal(lamdaFang(e,e)))
        r = r + 1;
        lamda(r) = sqrt(lamdaFang(e,e));
        bTemp(1:n,r) = b(1:n,e);
    end
end

for e=1:1:r
    K(e) = 100;    
end
for e=1:1:r
    bTemp(1:n,e) = K(e) * bTemp(1:n,e);
end
lamdaFinal = zeros(1,r);
bFinal = zeros(n,length(lamda));

for e=1:1:r
    [C,I] = max(lamda);
    lamdaFinal(e) =C;
    bFinal(1:n,e:e) =  bTemp(1:n,I:I);
    lamda(I)= 0;
end

a =   inv(S11) * S12 * bFinal;

for e=1:1:r
    for f=1:1:j
        a(f,e) = a(f,e) / lamdaFinal(e);
    end
end

[a,T] = rotatefactors(a);

r = length(lamdaFinal);
[n,m] = size(A);
[n,p] = size(B1);
P = 1 - CL;    
for k = 1:r
    lambda(k) = 1;
    for s = k:r
        lambda(k) = lambda(k) * (1 - lamdaFinal(s)^2);
    end
    Nu = n - 0.5 * (m + p + 1);
    Q(k) = - Nu * log(lambda(k));
    V(k) = (m - k + 1) * (p - k + 1);   
    Chi2(k) = chi2inv(P,V(k));
    num(k) = 0;
    if Q(k) > Chi2(k)
        num(k) = 1;
    end
end

inds = num > 0;
a_par = a(:,inds);
b_par = bFinal(:,inds);

U = A * a_par;
V = B1 * b_par;

d_par = sum(U .* V) ./ sum(U.^2);


for e=1:1:r
    lamdarate(e) = sum(lamdaFinal(1:e))/sum(lamdaFinal);
end

 secondfolder_name=['MCHTA-',num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N)];
 secondfolder=sprintf('%s/%s',newfolder,secondfolder_name);
 mkdir(secondfolder);


xlswrite([secondfolder,'\',[num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N),'lamda.xlsx']],lamdaFinal);
xlswrite([secondfolder,'\',[num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N),'Contribution.xlsx']],lamdarate);
xlswrite([secondfolder,'\',[num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N),'Coefficient.xlsx']],a_par);
xlswrite([secondfolder,'\',[num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N),'Score.xlsx']],U);
xlswrite([secondfolder,'\',[num2str(i),'-',num2str(j),'-',num2str(M),'-',num2str(N),'Test.xlsx']],[Q;Chi2;num]);








