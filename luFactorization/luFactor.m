function [L,U,P] = luFactor(A)
%This function calculates the lower, upper, and pivot matricies of a given
%square coefficient matrix
%   A= square coefficient matrix
%   L= Lower matrix
%   U= Upper matrix
%   P= Pivot matrix

[m,n]=size(A);%Testing for square matrix
if m~=n
    error('The number of rows should match the number of collumns.')
    end
U=A;%setting up base matricies
A2=A;
L=eye(n);
P=eye(n);

for k=1:n %first column pivoting
    if abs(U(1,1))<abs(U(k,1))
        pivot=U(1,:);
        U(1,:)=U(k,:);
        U(k,:)=pivot;
        
        Pvot=P(1,:);
        P(1,:)=P(k,:);
        P(k,:)=Pvot;
    end
end

for i=2:n %finding the new rows of U and starting L
    q=U(1,:);
    qi=U(i,:);
    l=U(i,1)./U(1,1);
    U(i,:)=qi-l.*q;
    L(i,1)=l;
end
count=0;
for s=2+count:n-1
    for x=2+count:n
        for j=2+count:n
            z=1:n;
            if abs(U(x,s))<abs(U(j,s))
                pivot=U(x,z);
                U(x,z)=U(j,z);
                U(j,z)=pivot;
                
                Pvot=P(x,z);
                P(x,z)=P(j,z);
                P(j,z)=Pvot;
                for w=2:n
                Lvot=L(w,s-1);
                L(w,s-1)=L(j,s-1);
                L(j,s-1)=Lvot;
                end
            end
        end
        if j==n
            break
        end
    end
    for y=3+count:n
    if U(x,s)==0
        (1);
    else
        q2=U(x,z);
        qx=U(j,z);
        a= U(x,s);
        l2=U(j,s)./a;
        U(y,z)=qx-(l2.*q2);
        L(y,s)=l2;
    end
    end
    count=count+1;
end


end

