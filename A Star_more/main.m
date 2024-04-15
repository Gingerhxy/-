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
for i = 1:length(NODE(:,1))
    map.start = NODE(i,1:3);  %��ʼ�� ע������ڵ�ͼ��Χ��
    map.goalA = NODE(i,4:6);  %Ŀ��� ע������ڵ�ͼ��Χ��
    map.goalB = NODE(i,7:9);  %Ŀ��� ע������ڵ�ͼ��Χ��
    map.goalC = NODE(i,10:12);  %Ŀ��� ע������ڵ�ͼ��Χ��
    goals1(1,:) = map.start;
    goals1(2,:) = map.goalA;
    goals1(3,:) = map.goalB;
    goals1(4,:) = map.goalC;
    GOALS(:,:,i) = goals1;%������·������
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

for k = 1:length(GOALS(1,1,:))
    map.start = GOALS(1,:,k);
    map.goalA = GOALS(2,:,k);
    map.goalB = GOALS(3,:,k);
    map.goalC = GOALS(4,:,k);
    % ���Ʊ߽���ϰ���
    plot3(obstacle(:,1)+.5,obstacle(:,2)+.5,obstacle(:,3)+.5,'rx');hold on;
    % ������ʼ��
    plot3(map.start(1)+.5,map.start(2)+.5,map.start(3)+.5,'bo');hold on;
    text(map.start(1)+.8,map.start(2)+.8,map.start(3)+.8,strcat('Դ��',num2str(k)));
    % ������ֹ��
    plot3(map.goalA(1)+.5,map.goalA(2)+.5,map.goalA(3)+.5,'gd');hold on;
    text(map.goalA(1)+.8,map.goalA(2)+.8,map.goalA(3)+.8,strcat('���A',num2str(k)));
    plot3(map.goalB(1)+.5,map.goalB(2)+.5,map.goalB(3)+.5,'gd');hold on;
    text(map.goalB(1)+.8,map.goalB(2)+.8,map.goalB(3)+.8,strcat('���B',num2str(k)));
    plot3(map.goalC(1)+.5,map.goalC(2)+.5,map.goalC(3)+.5,'gd');hold on;
    text(map.goalC(1)+.8,map.goalC(2)+.8,map.goalC(3)+.8,strcat('���C',num2str(k)));
end
 
% ����A*�㷨����·���滮
for j = 1:length(GOALS(1,1,:))
    goals = GOALS(:,:,j);
    for i = 1:(length(goals(:,1))-1)
        map.start = goals(i,:);  %��ʼ�� ע������ڵ�ͼ��Χ��
        map.goal = goals(i+1,:);
        if i == 1
            obstacle=[obstacle;[goals(3,:)]];
            obstacle=[obstacle;[goals(4,:)]];
        end
        if i == 2
            obstacle=[obstacle;[goals(4,:)]];
            obstacle=[obstacle;[goals(1,:)]];
        end
        if i == 3
            obstacle=[obstacle;[goals(1,:)]];
            obstacle=[obstacle;[goals(2,:)]];
        end
        [SuccessTime,path] = AStar(obstacle,map,SuccessTime,j);% A*�㷨
        obstacle(length(obstacle(:,1)),:)=[];
        obstacle(length(obstacle(:,1)),:)=[];
        if length(path)>=1
            obstacle = GetObstacle_path(obstacle,path);
        end
    end
    if j<length(GOALS(1,1,:))
        obstacle=DeteleObstacle_path(obstacle, GOALS(:,:,j+1));
    end
end

%����·��
%
if SuccessTime == 12
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