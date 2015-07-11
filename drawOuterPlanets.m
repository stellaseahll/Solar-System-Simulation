function drawOuterPlanets(xPos,yPos,zPos)

[x y z]=sphere;
imsun=imread('sun.jpg');
imjupiter=imread('jupiter.jpg');
imneptune=imread('neptune.jpg');
imsaturn=imread('saturn.jpg');
imuranus=imread('uranus.jpg');
impluto=imread('pluto.jpg');
idx=1:30:93806;
day=[0 9.9 10.7 -17.2 16.1 -153.3];
dtheta=360./day*4;
dtheta(1)=0;
for i=2029:3000
    i
    clf;
    clear h;
    h=figure;
    set(h, 'color', [0 0 0]);
    set(h,'Renderer','opengl');
    set(h,'Visible','Off');
    hold on;
    plot3(xPos(1:5000,7),yPos(1:5000,7),zPos(1:5000,7),'b');
    plot3(xPos(1:12000,8),yPos(1:12000,8),zPos(1:12000,8),'g');
    plot3(xPos(1:31000,9),yPos(1:31000,9),zPos(1:31000,9),'r');
    plot3(xPos(1:60500,10),yPos(1:60500,10),zPos(1:60500,10),'y');
    plot3(xPos(:,11),yPos(:,11),zPos(:,11),'c');
    axis equal;
    axis tight;
    axis([-4e12 6e12 -4e12 6e12 -2e12 1e12]);
    axis off;
    axis equal;
    view(-157,52);
    hold on;
     surf(x*radius(1)+xPos(idx(i),1),y*radius(1)+yPos(idx(i),1),z*radius(1)+zPos(idx(i),1), imsun,...
         'edgecolor', 'none','FaceColor','texturemap');
     Jupiter=surf(x*radius(7)+xPos(idx(i),7),y*radius(7)+yPos(idx(i),7),z*radius(7)+zPos(idx(i),7), imjupiter,...
         'edgecolor', 'none','FaceColor','texturemap');
     Saturn=surf(x*radius(8)+xPos(idx(i),8),y*radius(8)+yPos(idx(i),8),z*radius(8)+zPos(idx(i),8), imsaturn,...
       'edgecolor', 'none','FaceColor','texturemap');
     Uranus=surf(x*radius(9)+xPos(idx(i),9),y*radius(9)+yPos(idx(i),9),z*radius(9)+zPos(idx(i),9), imuranus,...
         'edgecolor', 'none','FaceColor','texturemap');
     Neptune=surf(x*radius(10)+xPos(idx(i),10),y*radius(10)+yPos(idx(i),10),z*radius(10)+zPos(idx(i),10), imneptune,...
         'edgecolor', 'none','FaceColor','texturemap');
     Pluto=surf(x*radius(11)+xPos(idx(i),11),y*radius(11)+yPos(idx(i),11),z*radius(11)+zPos(idx(i),11), impluto,...
         'edgecolor', 'none','FaceColor','texturemap');
     theta = pi * (0:2:2*100)/100 ;
     phi = 2*pi* (0:2:100)'/100;
    xdisc = (radius(8)*1.45 + radius(8)*0.08*cos(phi)) * cos(theta)+xPos(idx(i),8) ;
    ydisc = (radius(8)*1.45 + radius(8)*0.08*cos(phi)) * sin(theta)+yPos(idx(i),8) ;
    zdisc = radius(8)*0.08 * sin(phi) * ones(size(theta)) +zPos(idx(i),8);
          ring=surf(xdisc,ydisc,zdisc,'edgecolor', 'none');
          colormap('pink');
     theta=dtheta*(i-1);
%      rotate(Jupiter,[sind(tilt(2)) 0 cosd(tilt(2))], theta(2),[xPos(idx(i),2) yPos(idx(i),2) zPos(idx(i),2)]);
%      rotate(Saturn,[sind(tilt(3)) 0 cosd(tilt(3))], theta(3),[xPos(idx(i),3) yPos(idx(i),3) zPos(idx(i),3)]);
%      rotate(Uranus,[sind(tilt(4)) 0 cosd(tilt(4))], theta(4),[xPos(idx(i),4) yPos(idx(i),4) zPos(idx(i),4)]);
%      rotate(Neptune,[sind(tilt(5)) 0 cosd(tilt(5))], theta(5),[xPos(idx(i),5) yPos(idx(i),5) zPos(idx(i),5)]);
%      rotate(Pluto,[sind(tilt(6)) 0 cosd(tilt(6))], theta(6),[xPos(idx(i),6) yPos(idx(i),6) zPos(idx(i),6)]);
%     
          zoom(2)
    filename=strcat('frame',num2str(i),'.jpg');
    set(h, 'InvertHardCopy', 'off');
    saveas(h,filename);
end

    