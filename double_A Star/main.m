% ���ļ�Ϊ��map.matΪ��ͼ�ļ���point.matΪ��ֹλ���ļ���
% ����A*�㷨·���滮��������
clc
clear all
close all;
disp('A Star ���ɵ�·���߿�ʼ!!')
h=msgbox('A Star ���ɵ�·���߿�ʼ!!');
uiwait(h,5);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
load map.mat                    % ���ص�ͼ
load point.mat                  % ������ֹλ�õ�
[map.XMAX,map.YMAX,map.ZMAX] = size(MAP); %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
map.start = node(1:3);  %��ʼ�� ע������ڵ�ͼ��Χ��
map.goal = node(4:6);  %Ŀ��� ע������ڵ�ͼ��Χ��
obstacle = GetObstacle(map,MAP);% ��ȡ�߽����ݺ��ϰ�������
clear MAP node                  % ����������ʹ������������
%obstacle = [obstacle;4,1; 4,2; 4,3; 4,4; 3,4 ;2,4;];%ȫ�������������û��·��
 
% ������ͼ����ֹ��
figure(1)
if length(obstacle)>=1
    plot3(obstacle(:,1)+.5,obstacle(:,2)+.5,obstacle(:,3)+.5,'rx');hold on;
    % plot(obstacle(:,1),obstacle(:,2),'om');hold on;
end
pause(1);
h=msgbox('��·�ϰ�������');
uiwait(h,5);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
close 1
figure(1)
view(3);
axis([1 map.XMAX+1 1 map.YMAX+1 1 map.ZMAX+1])
set(gca,'YTick',0:1:map.YMAX);
set(gca,'XTick',0:1:map.XMAX);
set(gca,'ZTick',0:1:map.ZMAX);
grid on;hold on;
% ���Ʊ߽���ϰ���
plot3(obstacle(:,1)+.5,obstacle(:,2)+.5,obstacle(:,3)+.5,'rx');hold on;
% ������ʼ��
plot3(map.start(1)+.5,map.start(2)+.5,map.start(3)+.5,'bo');hold on;
text(map.start(1)+.8,map.start(2)+.8,map.start(3)+.8,'S');
% ������ֹ��
plot3(map.goal(1)+.5,map.goal(2)+.5,map.goal(3)+.5,'gd');hold on;
text(map.goal(1)+.8,map.goal(2)+.8,map.goal(3)+.8,'T');
% plot(map.start(1),map.start(2),'*r');hold on;
% plot(map.goal(1),map.goal(2),'*b');hold on;
 
% ����A*�㷨����·���滮
t1 = cputime;
path = AStar(obstacle,map);% A*�㷨
t2 = cputime;
t = t2-t1;
disp(t);
%����·��
%
if length(path)>=1
    plot3(path(:,1)+0.5,path(:,2)+0.5,path(:,3)+0.5,'-m','LineWidth',5);hold on;
%     h=msgbox('A Star ���߳ɹ�!!');
%     uiwait(h,5);% 5s��ر���Ϣ��
%     if ishandle(h) == 1
%         delete(h);
%     end
else
    h=msgbox('����ʧ��!!');
    uiwait(h,5);% 5s��ر���Ϣ��
    if ishandle(h) == 1
        delete(h);
    end
end

grid on;