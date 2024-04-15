function path=Dijkstra(obstacle,map)
% �ó���ΪA*�㷨

% ���ڴ洢·��
path = [];
%OpenList
open = [];
%CloseList
close = []; 
% findFlag�����ж�Whileѭ���Ƿ����
findFlag=false;%Ŀ���־

%===================1.����ʼ�����Openlist��======================
%open����ÿһ��  [�ڵ����꣬����ֵG,���ڵ�����]
open =[map.start(1), map.start(2) ,0 , map.start(1) , map.start(2)];

%����״̬--��һ�������ڵ�
next = MotionModel();

%=======================2.�ظ����¹���==============================
while ~findFlag

    %--------------------�����ж��Ƿ�ﵽĿ��㣬����·��-----
    if isempty(open(:,1))
        disp('No path to goal!!');
        return;
    end
    %------------------�ж�Ŀ����Ƿ������open�б���
    [isopenFlag,Id]=isopen(map.goal,open);
    if isopenFlag
        disp('Find Goal!!');
        close = [open(Id,:);close]
        findFlag=true;
        break;
    end
    %------------------a.����Openlist�еĵ����У����ۺ���F����������
    %--------------------����Fֵ��С�Ľڵ�
    [Y,I] = sort(open(:,3)); % ��OpenList�е���������
    open=open(I,:);%open�е�һ�нڵ���Fֵ��С��
    
    %------------------b.��Fֵ��С�Ľڵ�(��open�е�һ�нڵ�)���ŵ�close
    %--------------------��һ��(close�ǲ��ϻ�ѹ��)����Ϊ��ǰ�ڵ�
    close = [open(1,:);close];
    current = open(1,:);
    open(1,:)=[];% ��Ϊ�Ѿ���open���Ƴ��ˣ����Ե�һ����ҪΪ��
    
    %--------------------c.�Ե�ǰ�ڵ���Χ�����ڽڵ㣬�㷨�����壺------------------------
    for in=1:length(next(:,1))
        % ������ڽڵ������,����ֵF�ȵ���0,����ֵG�ȵ���0  ,��������ֵ��
        % �丸�ڵ������ֵ���ݶ�Ϊ��(��Ϊ��ʱ���޷��ж��丸�ڵ������Ƕ���)
        m = [current(1,1)+next(in,1) , current(1,2)+next(in,2) , 0 , 0 ,0]; 
        m(3) = current(1,3) + next(in,3); % m(4)  ���ڽڵ�Gֵ
        
        %>>��������ɴ��������������һ�����ڽڵ�  (ע�⣬obstacle�����
        %  �����ǰ����߽��)
        if isObstacle(m,obstacle)
            continue;
        end
        %flag == 1�����ڽڵ�  ��Closelist��  targetInd = close���к�
        %flag == 2�����ڽڵ㲻��Openlist��   targetInd = []
        %flag == 3�����ڽڵ�  ��Openlist��   targetInd = open���к�
        [flag,targetInd] = FindList(m,open,close);
        
        %>>�������Closelist�У����Դ����ڽڵ�
        if flag==1
            continue;
        %>>���������Openlist�У�����Openlist,���ѵ�ǰ�ڵ�����Ϊ���ĸ��ڵ�
        elseif flag==2
            m(4:5)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
            open = [open;m];%�������ڽڵ�ӷ�openlist��
        %>>ʣ�µ������������Openlist�У�����ɵ�ǰ�ڵ㵽���ڽڵ��Ƿ���ã�
        %  ��������򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������Gֵ�����򲻲���
        else
            %�ɵ�ǰ�ڵ㵽�����ڽڵ����(targetInd�Ǵ����ڽڵ���open�е��к� ���еĵ�3���Ǵ��ۺ���Gֵ)
            if m(3) < open(targetInd,3)
                %���ã��򽫴����ڽڵ�ĸ��ڵ�����Ϊ��ǰ�ڵ㣬����������
                m(4:5)=[current(1,1),current(1,2)];%����ǰ�ڵ���Ϊ�丸�ڵ�
                open(targetInd,:) = m;%�������ڽڵ���Openlist�е����ݸ���
            end
        end
    end
    plot_map(map,obstacle,open,close);
end
%׷��·��
path=GetPath(close,map.start);
end
