classdef Body<handle
    %% Attributes of particle class
    properties(SetAccess=protected)
        posX
        posY
        posZ
        velX
        velY
        velZ
        accX
        accY
        accZ
        mass
        N=0;
        tidx=0;
        dt
    end
     %% Constants of body class
    properties(Constant=true)
        G=6.67*10^-11;
    end
    %% Constructor
    methods
        function this=Body(varargin)
            this.dt=varargin{1};
            this.N=length(varargin{2});
            this.mass=varargin{2};
            this.tidx=1;
            if (nargin==2)
                for i=1:this.N
                    sign=1;
                    if (mod(randi(),2))
                        sign=-1;
                    end
                    this.posX(i)=rand()*10^10*sign;
                    sign=1;
                    if (mod(randi(),2))
                        sign=-1;
                    end
                    this.posY(i)=rand()*10^10*sign;
                    sign=1;
                    if (mod(randi(),2))
                        sign=-1;
                    end
                    this.posZ(i)=rand()*10^10*sign;
                end
                this.velX(1:this.N)=0;
                this.velY(1:this.N)=0;
                this.velZ(1:this.N)=0;  
               return;
            end
            if (nargin==3)
                pos=varargin{3};
                this.posX=pos(1,:);
                this.posY=pos(2,:);
                this.posZ=pos(3,:);
                this.velX(1:this.N)=0;
                this.velY(1:this.N)=0;
                this.velZ(1:this.N)=0;  
                return;
            end
            if (nargin==4)
                pos=varargin{3};
                this.posX=pos(1,:);
                this.posY=pos(2,:);
                this.posZ=pos(3,:);
                vel=varargin{4};
                this.velX=vel(1,:);
                this.velY=vel(2,:);
                this.velZ=vel(3,:);
            end
        end
    end
     %% Public methods
    methods (Access=public)  
        function runSimulation(this,tTotal)
            this.RK4(tTotal);
        end
        function [xPos, yPos, zPos]=getPosition(this)
            xPos=this.posX;
            yPos=this.posY;
            zPos=this.posZ;
        end
        function [xVel, yVel, zVel]=getVelocity(this)
            xVel=this.velX;
            yVel=this.velY;
            zVel=this.velZ;
        end
        function [xAcc, yAcc, zAcc]=getAcceleration(this)
            xAcc=this.accX;
            yAcc=this.accY;
            zAcc=this.accZ;
        end
        function t=getTime(this)
            t=(0:this.tidx-1)*this.dt;
        end
    end
    %% Protected
     methods (Access=protected)
        %% Calculate gravitational acceleration
        function [accX,accY,accZ]=calcAcc(this,posX,posY,posZ)
            accX=zeros(1,this.N);
            accY=zeros(1,this.N);
            accZ=zeros(1,this.N);
            for i=1:this.N
                for j=1:this.N
                   if (i==j)
                       continue;
                   end
                   dz=posZ(j)-posZ(i);
                   dy=posY(j)-posY(i);
                   dx=posX(j)-posX(i);
                   r=[dx dy dz];
                   a=this.G*this.mass(j)/norm(r)^3*r;   
                   accX(i)=accX(i)+a(1);
                   accY(i)=accY(i)+a(2);
                   accZ(i)=accZ(i)+a(3);
                end
            end    
        end
         %% Runge-Kutta
         function RK4(this,tTotal)
            for i=this.tidx+1:this.tidx+tTotal
                fprintf('%d\n',i);
                xPosPrev=this.posX(i-1,:);
                yPosPrev=this.posY(i-1,:);
                zPosPrev=this.posZ(i-1,:);
                xVelPrev=this.velX(i-1,:);
                yVelPrev=this.velY(i-1,:);
                zVelPrev=this.velZ(i-1,:);
                [vx0,vy0,vz0,ax0,ay0,az0]=this.dxdt(xPosPrev,yPosPrev,zPosPrev,xVelPrev,yVelPrev,zVelPrev);
                this.accX(i-1,:)=ax0;
                this.accY(i-1,:)=ay0;
                this.accZ(i-1,:)=az0;
                xPosTmp=xPosPrev+this.dt/2*vx0;
                yPosTmp=yPosPrev+this.dt/2*vy0;
                zPosTmp=zPosPrev+this.dt/2*vz0;
                xVelTmp=xVelPrev+this.dt/2*ax0;
                yVelTmp=yVelPrev+this.dt/2*ay0;
                zVelTmp=zVelPrev+this.dt/2*az0;
                [vx1,vy1,vz1,ax1,ay1,az1]=this.dxdt(xPosTmp,yPosTmp,zPosTmp,xVelTmp,yVelTmp,zVelTmp);
                xPosTmp=xPosPrev+this.dt/2*vx1;
                yPosTmp=yPosPrev+this.dt/2*vy1;
                zPosTmp=zPosPrev+this.dt/2*vz1;
                xVelTmp=xVelPrev+this.dt/2*ax1;
                yVelTmp=yVelPrev+this.dt/2*ay1;
                zVelTmp=zVelPrev+this.dt/2*az1;
                [vx2,vy2,vz2,ax2,ay2,az2]=this.dxdt(xPosTmp,yPosTmp,zPosTmp,xVelTmp,yVelTmp,zVelTmp);
                xPosTmp=xPosPrev+this.dt*vx2;
                yPosTmp=yPosPrev+this.dt*vy2;
                zPosTmp=zPosPrev+this.dt*vz2;
                xVelTmp=xVelPrev+this.dt*ax2;
                yVelTmp=yVelPrev+this.dt*ay2;
                zVelTmp=zVelPrev+this.dt*az2;
                [vx3,vy3,vz3,ax3,ay3,az3]=this.dxdt(xPosTmp,yPosTmp,zPosTmp,xVelTmp,yVelTmp,zVelTmp);
                xPosCurr=xPosPrev+this.dt/6.*(vx0+vx3+2*(vx1+vx2));
                yPosCurr=yPosPrev+this.dt/6.*(vy0+vy3+2*(vy1+vy2));
                zPosCurr=zPosPrev+this.dt/6.*(vz0+vz3+2*(vz1+vz2));
                xVelCurr=xVelPrev+this.dt/6.*(ax0+ax3+2*(ax1+ax2));
                yVelCurr=yVelPrev+this.dt/6.*(ay0+ay3+2*(ay1+ay2));
                zVelCurr=zVelPrev+this.dt/6.*(az0+az3+2*(az1+az2));
                this.posX(i,:)=xPosCurr;
                this.posY(i,:)=yPosCurr;
                this.posZ(i,:)=zPosCurr;
                this.velX(i,:)=xVelCurr;
                this.velY(i,:)=yVelCurr;
                this.velZ(i,:)=zVelCurr;
            end
            this.tidx=this.tidx+tTotal;
         end
         %% ODEs
         function [vx,vy,vz,ax,ay,az]=dxdt(this,xPosPrev,yPosPrev,zPosPrev,xVelPrev,yVelPrev,zVelPrev)
            vx=xVelPrev;
            vy=yVelPrev;
            vz=zVelPrev;
            [ax,ay,az]=this.calcAcc(xPosPrev,yPosPrev,zPosPrev);
         end
   
     end
end