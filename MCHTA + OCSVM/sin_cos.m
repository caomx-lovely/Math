function B1 = sin_cos(B,M,N)
x = B(:,1);
y = B(:,2);
L = 1/2*(max(x)-min(y));
H = 1/2*(max(y)-min(y));
B1 = [];
for m = 0:M
    for n = 0:N
        if m == 0 && n == 0
            lamda = 1/4;
            temp = cos(m*pi*x/L).*cos(n*pi*y/H);
            B1 = [B1,lamda*temp];
        elseif m == 0 && n > 0
            lamda = 1/2;
            temp = [cos(m*pi*x/L).*cos(n*pi*y/H), cos(m*pi*x/L).*sin(n*pi*y/H)];
            B1 = [B1,lamda*temp];
        elseif m > 0 && n == 0
            lamda = 1/2;
            temp = [cos(m*pi*x/L).*cos(n*pi*y/H), sin(m*pi*x/L).*cos(n*pi*y/H)];
            B1 = [B1,lamda*temp];
        elseif m*n > 0
            lamda = 1;
            temp = [cos(m*pi*x/L).*cos(n*pi*y/H), sin(m*pi*x/L).*cos(n*pi*y/H),...
                cos(m*pi*x/L).*sin(n*pi*y/H), sin(m*pi*x/L).*sin(n*pi*y/H)];
            B1 = [B1,lamda*temp];
        end
    end
end