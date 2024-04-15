% ���ļ�Ϊ��map.matΪ��ͼ�ļ���point.matΪ��ֹλ���ļ���
% ����A*�㷨·���滮��������
clc
clear all
close all;
disp('A Star Integrated Circuit routing Begins!!')
h = msgbox('A Star ���ɵ�·���߿�ʼ!!');
uiwait(h,5);% 5s��ر���Ϣ��
if ishandle(h) == 1
    delete(h);
end
load map.mat                    % ���ص�ͼ
load point.mat                  % ������ֹλ�õ�
Glist = [];
for o =1:2 %������ͬ��Լ������������ѡ����
    [map.XMAX,map.YMAX,map.ZMAX] = size(MAP); %%��������Ҫ��һ����ͼ�ĳ��Ϳ�
    obstacle = GetObstacle(map,MAP);% ��ȡ�߽����ݺ��ϰ�������
    %������·
    for i = 1:length(NODE(:,1))
        map.start = NODE(i,1:3);  %��ʼ�� ע������ڵ�ͼ��Χ��
        map.goalA = NODE(i,4:6);  %Ŀ��� ע������ڵ�ͼ��Χ��

        goals1(1,:) = map.start;
        goals1(2,:) = map.goalA;

        GOALS(:,:,i) = goals1;%������·������
        if i>1
            obstacle = GetObstacle_path(obstacle,goals1);%��ȡ������·���ϰ�
        end
    end


    SuccessTime = 0;%�ֲ���·�ɹ�����
    G_ALL = 0;%�ܴ���
    %obstacle = [obstacle;4,1; 4,2; 4,3; 4,4; 3,4 ;2,4;];%ȫ�������������û��·��

    % ������ͼ����ֹ��
    figure(o)
    title(['figure',num2str(o)]);
    view(3);
    axis([1 map.XMAX+1 1 map.YMAX+1 1 map.ZMAX+1])
    set(gca,'YTick',0:1:map.YMAX);
    set(gca,'XTick',0:1:map.XMAX);
    set(gca,'ZTick',0:1:map.ZMAX);
    grid on;hold on;

    for k = 1:length(GOALS(1,1,:))
        map.start = GOALS(1,:,k);
        map.goalA = GOALS(2,:,k);

        % ���Ʊ߽���ϰ���
        plot3(obstacle(:,1)+.5,obstacle(:,2)+.5,obstacle(:,3)+.5,'rx');hold on;
        % ������ʼ��
        plot3(map.start(1)+.5,map.start(2)+.5,map.start(3)+.5,'bo');hold on;
        text(map.start(1),map.start(2),map.start(3)+.8,strcat('S',num2str(k)),'FontSize',13,'FontWeight','bold');
        % ������ֹ��
        plot3(map.goalA(1)+.5,map.goalA(2)+.5,map.goalA(3)+.5,'gd');hold on;
        text(map.goalA(1),map.goalA(2),map.goalA(3)+.8,strcat('T',num2str(k)),'FontSize',13,'FontWeight','bold');


    end

    % ����A*�㷨����·���滮
    for j = 1:length(GOALS(1,1,:))
        goals = GOALS(:,:,j);
        for i = 1:(length(goals(:,1))-1)
            map.start = goals(i,:);  %��ʼ�� ע������ڵ�ͼ��Χ��
            map.goal = goals(i+1,:);

            [SuccessTime,path,G_ALL] = AStar(obstacle,map,SuccessTime,j,G_ALL,o);% A*�㷨
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
    Glist = [Glist,G_ALL];
    disp(['The total cost is ',num2str(G_ALL)]);
    s=0;
    for j = 1:length(GOALS(1,1,:))   %�������ж����������
        goals = GOALS(:,:,j);
        s = s+length(goals(:,1))-1;
    end

    %����·��
    %
    if SuccessTime == s
        h=msgbox('A Star All circuits routed successfully!!');
        disp('A Star Integrated Circuit routing Begins!!');
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
end
disp(strcat(['The optimal solution is the ',num2str(find(Glist==min(Glist)))],'nd figure'))

grid on;