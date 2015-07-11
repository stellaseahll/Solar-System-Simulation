function T=binarySystem(dt)
%% binary 1
M1=1e30; M2=1e30; r=1e10;
pos=[0 r; 0 0; 0 0];
G=6.67*10^-11;
vel=[0 0;-sqrt(G/(M1+M2)/r)*M2 sqrt(G/(M1+M2)/r)*M1; 0 0];
test1=Body(dt,[M1 M2],pos,vel);
test1.runSimulation(10000);
[x1,y1,z1]=test1.getPosition;
t1=test1.getTime();
z=x1(:,1)/(max(x1(:,1))-min(x1(:,1)))*2-1;
A=solvePeriod2(t1',z,[544000, z(1)]);
T(1)=A(1);
%% binary 2
M1=2e30; M2=2e30; r=1e10;
pos=[0 r; 0 0; 0 0];
G=6.67*10^-11;
vel=[0 0;-sqrt(G/(M1+M2)/r)*M2 sqrt(G/(M1+M2)/r)*M1; 0 0];
test2=Body(dt,[M1 M2],pos,vel);
test2.runSimulation(10000);
[x2,y2,z2]=test2.getPosition;
t2=test2.getTime();
z=x2(:,1)/(max(x2(:,1))-min(x2(:,1)))*2-1;
A=solvePeriod2(t2',z,[444170, z(1)]);
T(2)=A(1);
%% binary 3
M1=3e30; M2=3e30; r=1e10;
pos=[0 r; 0 0; 0 0];
G=6.67*10^-11;
vel=[0 0;-sqrt(G/(M1+M2)/r)*M2 sqrt(G/(M1+M2)/r)*M1; 0 0];
test3=Body(dt,[M1 M2],pos,vel);
test3.runSimulation(10000);
[x3,y3,z3]=test3.getPosition;
t3=test3.getTime();
z=x3(:,1)/(max(x3(:,1))-min(x3(:,1)))*2-1;
A=solvePeriod2(t3',z,[384670, z(1)]);
T(3)=A(1);
end
