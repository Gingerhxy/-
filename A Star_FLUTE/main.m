% ���ļ�Ϊ��map.matΪ��ͼ�ļ���point.matΪ��ֹλ���ļ���
% ����A*�㷨·���滮��������
clc
clear all
close all;
disp('A Star ���ɵ�·���߿�ʼ!!')
h = msgbox('A Star ���ɵ�·���߿�ʼ!!');
uiwait(h,5);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
load map.mat                    % ���ص�ͼ
load point.mat                  % ������ֹλ�õ�
[map.XMAX,map.YMAX,map.ZMAX] = size(MAP); %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
obstacle = GetObstacle(map,MAP);% ��ȡ�߽����ݺ��ϰ�������
%������·
for i = 1:length(NODE)
    goalss = NODE{i};
    goals1 = [];
    goals1(1,:) = [0,0,0];
    for j = 1:(length(NODE{i})/3)
        goals1(j,:) = goalss(3*(j-1)+1:3*j);
    end
    GOALS{i} = goals1;%������·������
    if i>1
        obstacle = GetObstacle_path(obstacle,goals1);%��ȡ������·���ϰ�
    end
end


SuccessTime = 0;%�ֲ���·�ɹ�����
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

for k = 1:length(GOALS)
    goals = GOALS{k};
    for j = 1:length(goals(:,1))
        map.start = goals(j,:);
        % ���Ʊ߽���ϰ���
        plot3(obstacle(:,1)+.5,obstacle(:,2)+.5,obstacle(:,3)+.5,'rx');hold on;
        % ������ʼ��
        plot3(map.start(1)+.5,map.start(2)+.5,map.start(3)+.5,'bo');hold on;
        text(map.start(1)+.8,map.start(2)+.8,map.start(3)+.8,strcat(num2str(k),strcat('PIN',num2str(j))));
    end
end
SUCCESSTIME = 0;
% ����A*�㷨����·���滮
t1 = cputime;
for j = 1:length(GOALS)
    PATH(1,:) = [0,0,0];
    goals = GOALS{j};
    SUCCESSTIME = SUCCESSTIME + length(goals(:,1))-1;
    for i = 1:(length(goals(:,1))-1)
        map.start = goals(i,:);  %��ʼ�� ע������ڵ�ͼ��Χ��
        map.goal = goals(i+1,:);
        [SuccessTime,path] = AStar(obstacle,map,SuccessTime,j);% A*�㷨
        if length(path)>=1
            length_PATH = length(PATH(:,1));
            for k = 1:length(path(:,1))
                PATH(length_PATH+k,:) = path(k,:);
            end
        end
    end
    obstacle = GetObstacle_path(obstacle,PATH);
    if j<length(GOALS)
        obstacle=DeteleObstacle_path(obstacle, GOALS{j+1});
    end
end
t2 = cputime;
t = t2-t1;
disp(t);
%����·��
%
if SuccessTime == SUCCESSTIME
    h=msgbox('A Star ���е�·���߳ɹ�!!');
    disp('A Star ���е�·���߳ɹ�!!');
    uiwait(h,5);% 5s��ر���Ϣ��
    if ishandle(h) == 1
        delete(h);
    end
else
    h=msgbox('����ʧ��!!');
    uiwait(h,5);% 5s��ر���Ϣ��
    if ishandle(h) == 1
        delete(h);
    end
end

grid on;