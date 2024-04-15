clc;
clear all;
figure;
view(3);

% ������ʼ��
MAX_X=10;% ��������Ҫ��һ����ͼ�ĳ�
MAX_Y=10;% ��������Ҫ��һ����ͼ�Ŀ�
MAX_Z=5;% ��������Ҫ��һ����ͼ�ĸ�
p_obstacle = 0.2;% �ϰ���

% �����ϰ���
obstacle = ones(MAX_X,MAX_Y)*p_obstacle;%���ɾ���
% ��MAP�������ϰ�����Ϊ-1�����ϰ�����Ϊ9998
MAP=[];
for i=1:MAX_Z
   MAP1 = 9999*((rand(MAX_X,MAX_Y))>obstacle)-1;    % -1ֵ�����ϰ��rand���������
   MAP(:,:,i)=MAP1;
end
j=0;
axis([1 MAX_X+1 1 MAX_Y+1 1 MAX_Z+1])
set(gca,'ZTick',0:1:MAX_Z);
set(gca,'YTick',0:1:MAX_Y);
set(gca,'XTick',0:1:MAX_X);
grid on;
hold on;
% ���Ƴ���ͼ�ϵ��ϰ���
for z=1:MAX_Z
    for i=1:MAX_X
        for j=1:MAX_Y
            if MAP(i,j,z) == -1
                plot3(i+.5,j+.5,z+.5,'rx');
            end
        end
    end
end
%%��ͼ��ѡ����ʼλ��
pause(1);
xStart=2;%Starting Position
yStart=4;%Starting Position
zStart=2;%Starting Position
MAP(xStart,yStart,zStart) = 0;
plot3(xStart+.5,yStart+.5,zStart+.5,'bo');
text(xStart+.8,yStart+.8,zStart+.8,'S','FontSize',14,'FontWeight','bold');
%%��ͼ��ѡ��Ŀ���
pause(1);
xTargetA=7;%Target Position
yTargetA=8;%Target Position
zTargetA=4;%Target Position
MAP(xTargetA,yTargetA,zTargetA) = 9998;
plot3(xTargetA+.5,yTargetA+.5,zTargetA+.5,'go');
text(xTargetA+.8,yTargetA+.8,zTargetA+.8,'T','FontSize',14,'FontWeight','bold');
pause(1);
node = [xStart,yStart,zStart,xTargetA,yTargetA,zTargetA];
save map MAP;
save point node;
h=msgbox('��·3D����ģ��������');
uiwait(h,5);
if ishandle(h) == 1
    delete(h);
end