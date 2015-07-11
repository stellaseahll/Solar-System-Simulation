function drawInnerPlanets(xPos,yPos,zPos)

[x y z]=sphere;
imsun=imread('sun.jpg');
imearth=imread('earth.jpg');
immoon=imread('moon.jpg');
immercury=imread('mercury.jpg');
imvenus=imread('venus.jpg');
immars=imread('mars.jpg');
idx=1:3000;
tilt=[0 23.4 6.7 177.4 0.01 25.2];
day=[0 23.9 655.7 -5832.5 1407.6 24.6];
dtheta=360./day*4;
dtheta(1)=0;
for i=1:3000
    clf;
    clear h;
    h=figure;
    set(h, 'color', [0 0 0]);
    set(h,'Renderer','opengl');
    set(h,'Visible','Off');
    plot3(xPos(1:5000,[2 4:6]),yPos(1:5000,[2 4:6]),zPos(1:5000,[2 4:6]));
    axis equal;
    axis tight;
    axis([-3e11 3e11 -3e11 3e11 -5e9 5e9]);
    axis off;
    view(-157,52);
    hold on;
     surf(x*radius(1)+xPos(idx(i),1),y*radius(1)+yPos(idx(i),1),z*radius(1)+zPos(idx(i),1), imsun,...
         'edgecolor', 'none','FaceColor','texturemap');
     Earth=surf(x*radius(2)+xPos(idx(i),2),y*radius(2)+yPos(idx(i),2),z*radius(2)+zPos(idx(i),2), imearth,...
         'edgecolor', 'none','FaceColor','texturemap');
     Moon=surf(x*radius(3)+xPos(idx(i),3),y*radius(3)+yPos(idx(i),3),z*radius(3)+zPos(idx(i),3), immoon,...
       'edgecolor', 'none','FaceColor','texturemap');
     Venus=surf(x*radius(4)+xPos(idx(i),4),y*radius(4)+yPos(idx(i),4),z*radius(4)+zPos(idx(i),4), imvenus,...
         'edgecolor', 'none','FaceColor','texturemap');
     Mercury=surf(x*radius(5)+xPos(idx(i),5),y*radius(5)+yPos(idx(i),5),z*radius(5)+zPos(idx(i),5), immercury,...
         'edgecolor', 'none','FaceColor','texturemap');
     Mars=surf(x*radius(6)+xPos(idx(i),6),y*radius(6)+yPos(idx(i),6),z*radius(6)+zPos(idx(i),6), immars,...
         'edgecolor', 'none','FaceColor','texturemap');
     theta=dtheta*(i-1);
     rotate(Earth,[sind(tilt(2)) 0 cosd(tilt(2))], theta(2),[xPos(idx(i),2) yPos(idx(i),2) zPos(idx(i),2)]);
     rotate(Moon,[sind(tilt(3)) 0 cosd(tilt(3))], theta(3),[xPos(idx(i),3) yPos(idx(i),3) zPos(idx(i),3)]);
     rotate(Venus,[sind(tilt(4)) 0 cosd(tilt(4))], theta(4),[xPos(idx(i),4) yPos(idx(i),4) zPos(idx(i),4)]);
     rotate(Mercury,[sind(tilt(5)) 0 cosd(tilt(5))], theta(5),[xPos(idx(i),5) yPos(idx(i),5) zPos(idx(i),5)]);
     rotate(Mars,[sind(tilt(6)) 0 cosd(tilt(6))], theta(6),[xPos(idx(i),6) yPos(idx(i),6) zPos(idx(i),6)]);
          zoom(2)
    filename=strcat('frameInner',num2str(i),'.jpg');
    set(h, 'InvertHardCopy', 'off');
    saveas(h,filename);
end
end

    