function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter);
%This function is used to find the approximate root of a function.
%   The alrgorithim uses false position to predict the x value of the root
%   of an inputed funtion
% Variables
% Inputs
%func- the funtion being evaluated
%xl- the lower guess
%xu- the upper guess
%es- the desired relative error (defaulted to 0.0001%)
%maxiter- number of iderations desired (defaulted to 200)
% Outputs
%root- the estimated root location
%fx- the funtion evaluated at the estimated root location
%ea- the approximate relative error (%)
%iter- how many interations were perfrormed

%The inputs
syms x Yes No iter maxiter xl xu root fx fu fl es ea
f=input('What is the equation you want to find the root of?\n(Use x as your variable)\n');
func=symfun(f,x);

%The lower braket and its errors
xl= input('What is your lower value guess?\n');
xlc=isnumeric(xl);
if xlc==0
    error('xl must be a number')
end

%The Upper bracket and its errors
xu= input('What is your higher value guess?\n');
xuc=isnumeric(xu);
if xuc==0
    error('xu must be a number')
end

%Testing the brakets
a1=double(subs(func(xl)));
b1=double(subs(func(xu)));
if sign(a1)==sign(b1)
    error('The inputed brakects do not boarder a root. Please choose different values.')
end

%Inputing the percent realative error and those errors
es= input('Do you have a desired relative error? Please input Yes or No.\n(If No realative error will default to 0.0001%)\n');
if es==Yes
    es= input('What is your desired percent relative error?\n');
    esc= isnumeric(es);
    if esc==0
        error('The percent value must be a number.')
    end
elseif es==No
    es=0.0001;
else
    error('You must enter Yes or No.')
end

%Inputing the max number of iterations and its errors
maxiter= input('Do you have a max number of iteration you want the algorithim to perform? \nPlease enter Yes or No.(If No the maximum number id iterations will default to 200)\n');
if maxiter==Yes
    maxiter= input('What is your desired number of iterations?\n')
    maxc=isnumeric(maxiter);
    if maxc==0
        error('The percent value must be a number.')
    end
elseif maxiter==No
    maxiter=200;
else
    error('You must enter Yes or No.')
end

%formating for accuracy
format long
iter=0;

%The calculation the root, approximate relative error, and number of
%integrations
ea=es+1;
while (1)
    iter=iter+1;
    fl=double(subs(func(xl))); %fl- the inputed function at the value xl
    if sign(fl)==1
        a=fl;
        ax=xl;
    elseif sign(fl)==-1
        b=fl;
        bx=xl;
    end
    fu=double(subs(func(xu)));%fu- the inputed function at the value xu
    if sign(fu)==1
        a=fu; %a is the value chosen to represent the positive f(x) value from here on out
        ax=xu;%ax is the x value of a
    elseif sign(fu)==-1
        b=fu;%b is the value chosen to represent the negative f(x) value from here on out
        bx=xu;%bx is the x value of b
    end
    root= xu-((fu*(xl-xu))/(fl-fu));
    fx=double(subs(func(root)));
    if sign(root)==1
        ea=abs(((a-fx)/a)*100);
        if sign(fl)==1
            xl=root;
        elseif sign(fu)==1
            xu=root;
        end
    elseif sign(root)==-1
        ea=abs(((b-fx)/b)*100);
        if sign(fl)==-1
            xl=root;
        elseif sign(fu)==-1
            xu=root;
        end
    end
    if ea<=es||iter>=maxiter
        break
    end
end
%printing the answers
fprintf('The estimated root value is %i.\n',root)
fprintf('The funtion evaluated at the root is %i.\n',fx)
fprintf('The approximate realtive error is %i%%.\n',ea)
fprintf('The number of iterations it took was %i.\n',iter)
end