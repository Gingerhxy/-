clc;
clear all;
figure;

% ������ʼ��
MAX_X=50;% ��������Ҫ��һ����ͼ�ĳ�
MAX_Y=50;% ��������Ҫ��һ����ͼ�Ŀ�
p_obstacle = 0.3;% �ϰ���

% �����ϰ���
obstacle = ones(MAX_X,MAX_Y)*p_obstacle;
% ��MAP�������ϰ�����Ϊ-1�����ϰ�����Ϊ9998
MAP = 9999*((rand(MAX_X,MAX_Y))>obstacle)-1;    % -1ֵ�����ϰ���
j=0;
x_val = 1;
y_val = 1;
axis([1 MAX_X+1 1 MAX_Y+1])   %x�ᣬy�᷶Χ1-50��ͼ��
set(gca,'YTick',0:1:MAX_Y);   %x�ᣬy����Ϊ1
set(gca,'XTick',0:1:MAX_X);
grid on;
hold on;
% ���Ƴ���ͼ�ϵ��ϰ���
for i=1:MAX_X
    for j=1:MAX_Y
        if MAP(i,j) == -1
            plot(i+.5,j+.5,'rx');
        end
    end
end
%%��ͼ��ѡ����ʼλ��
pause(1);
h=msgbox('Please Select the Vehicle initial position using the Left Mouse button');
uiwait(h,5);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Vehicle initial position ','Color','black');
but=0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
    xval=floor(xval);
    yval=floor(yval);
end
xStart=xval;%Starting Position
yStart=yval;%Starting Position
MAP(xval,yval) = 0;
plot(xval+.5,yval+.5,'bo');
%%��ͼ��ѡ��Ŀ���
pause(1);
h=msgbox('Please Select the Target using the Left Mouse button in the space');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end
xlabel('Please Select the Target using the Left Mouse button','Color','black');
but = 0;
while (but ~= 1) %Repeat until the Left button is not clicked
    [xval,yval,but]=ginput(1);
end
xval = floor(xval);
yval = floor(yval);
xTarget = xval;
yTarget = yval;
MAP(xval,yval) = 9998;
plot(xval+.5,yval+.5,'gd');
text(xval+1,yval+.5,'Target');
node = [xStart,yStart,xTarget,yTarget];
save map MAP;
save point node;
close(figure(1));