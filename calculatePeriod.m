function T=calculatePeriod(Tidx,Tguess,idx,xPos,yPos,zPos,t)
costheta=findAngle(xPos,yPos,zPos,Tidx,idx);
A=solvePeriod2(t(Tidx)',costheta,[Tguess, costheta(1)]);
T=A(1);
end
function costheta=findAngle(xPos,yPos,zPos,Tidx,idx)
x=xPos(Tidx,idx)-xPos(Tidx,1);
y=yPos(Tidx,idx)-yPos(Tidx,1);
z=zPos(Tidx,idx)-yPos(Tidx,1);
R=sqrt(x.*x+y.*y+z.*z);
minIdx=find(R==min(R));
costheta=zeros(1,length(R));
    for i=1:length(R)
    a=[x(minIdx) y(minIdx) z(minIdx)];
    b=[x(i) y(i) z(i)];
    costheta(i)=(dot(a,b)/(norm(a)*norm(b)));
    end
end
function [A,f]=solvePeriod2(t,z,guess)
    function f=sumSqErr(A)
        f=sum((osc(A,t)-z).^2);
    end
    function zTheo=osc(A,t)
        %A(1)=period %A(2)=phase lag
        w=2*pi/A(1);
        zTheo=sin(w*t+A(2));
    end     
    [A f]=fminsearch(@sumSqErr,guess);
    clf;
    plot(t,z,t,osc(A,t));
end