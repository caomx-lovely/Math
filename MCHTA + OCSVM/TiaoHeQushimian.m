clear;clc;
[data,text] = xlsread('data.xlsx');
A0 = data(:,3:end);
text_elements = text(3:end);
B0 = data(:,1:2);
[a0,a1]=size(A0);
Current_Path=pwd;
newfolder=['MCHTA-',num2str(a0),'-',num2str(a1)];
mkdir(newfolder);

type0 = 21;    
type_A1 = 1;    
type_B1 = 1;    

M = 2;   
N = 2;   

CL = 0.01;    

B = xy_data_pretreating_func(B0,type0,type_B1);

A = geochemistral_data_pretreating_func(A0,type_A1);

B1 = sin_cos(B,M,N);

[a_par,b_par,d_par] = TiaoHeQushimian_func(A,B1,M,N,CL,newfolder);
