% ���ļ�Ϊ��map.matΪ��ͼ�ļ���point.matΪ��ֹλ���ļ���
% ����A*�㷨·���滮��������
clc
clear all
close all;
disp('A Star Path Planing start!!')
load map.mat                    % ���ص�ͼ
load point.mat                  % ������ֹλ�õ�
[map.XMAX,map.YMAX] = size(MAP); %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
map.start = node(1:2);  %��ʼ�� ע������ڵ�ͼ��Χ��
map.goal = node(3:4);  %Ŀ��� ע������ڵ�ͼ��Χ��
obstacle = GetObstacle(map,MAP);% ��ȡ�߽����ݺ��ϰ�������
clear MAP node                  % ����������ʹ������������
%obstacle = [obstacle;4,1; 4,2; 4,3; 4,4; 3,4 ;2,4;];%ȫ�������������û��·��

% ������ͼ����ֹ��
figure(1)
if length(obstacle)>=1
    plot(obstacle(:,1)+.5,obstacle(:,2)+.5,'rx');hold on;
    % plot(obstacle(:,1),obstacle(:,2),'om');hold on;
end
pause(1);
h=msgbox('Please confirm the map information and click the buttion "confirm".');
uiwait(h,20);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
close 1
figure(1)
axis([1 map.XMAX+1 1 map.YMAX+1])
set(gca,'YTick',0:1:map.YMAX);
set(gca,'XTick',0:1:map.XMAX);
grid on;hold on;
% ���Ʊ߽���ϰ���
plot(obstacle(:,1)+.5,obstacle(:,2)+.5,'rx');hold on;
% ������ʼ��
plot(map.start(1)+.5,map.start(2)+.5,'bo');hold on;
% ������ֹ��
plot(map.goal(1)+.5,map.goal(2)+.5,'gd');hold on;
text(map.goal(1)+1,map.goal(2)+.5,'Target');
% plot(map.start(1),map.start(2),'*r');hold on;
% plot(map.goal(1),map.goal(2),'*b');hold on;
t1 = cputime;
% ����A*�㷨����·���滮
path = AStar(obstacle,map);% A*�㷨
t2 = cputime;
t = t2-t1;
disp(t);
%����·��
%
if length(path)>=1
    plot(path(:,1)+0.5,path(:,2)+0.5,'-m','LineWidth',5);hold on;
end
%}

grid on;
% img=gcf;
% print(img, '-dpng', '-r600', 'D:/�ҵ�����/A Star/img2.svg');