function [SuccessTime,path,G_ALL]=AStar(obstacle,map,SuccessTime,j,G_ALL,o)
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
%open����ÿһ��  [�ڵ����꣬����ֵF=G+H,����ֵG,���ڵ�����]
open =[map.start(1), map.start(2) ,map.start(3) , 0+h(map.start,map.goal) , 0 , map.start(1) , map.start(2) ,map.start(3)];

%����״̬--��һ���İ˸���
[next1,next2] = MotionModel();

%=======================2.�ظ����¹���==============================
while ~findFlag

    %--------------------�����ж��Ƿ�ﵽĿ��㣬����·��-----
    if isempty(open(:,1))
        disp('����֮����·��������ʧ��!!');
        return;
    end
    %------------------�ж�Ŀ����Ƿ������open�б���
    [isopenFlag,Id]=isopen(map.goal,open);
    if isopenFlag
%         disp('A Star ���߳ɹ�!!');
        SuccessTime = SuccessTime + 1;
        close = [open(Id,:);close];
        G_ALL = G_ALL+open(Id,5);
        findFlag=true;
        break;
    end
    %------------------a.����Openlist�еĵ����У����ۺ���F����������
    %--------------------����Fֵ��С�Ľڵ�
    [Y,I] = sort(open(:,4)); % ��OpenList�е���������
    open=open(I,:);%open�е�һ�нڵ���Fֵ��С��
    
    %------------------b.��Fֵ��С�Ľڵ�(��open�е�һ�нڵ�)���ŵ�close
    %--------------------��һ��(close�ǲ��ϻ�ѹ��)����Ϊ��ǰ�ڵ�
    close = [open(1,:);close];
    current = open(1,:);
    open(1,:)=[];% ��Ϊ�Ѿ���open���Ƴ��ˣ����Ե�һ����ҪΪ��
    
    %--------------------c.�Ե�ǰ�ڵ���Χ��4�����ڽڵ㣬�㷨�����壺------------------------
    for in=1:length(next1(:,1))
        % ������ڽڵ������,����ֵF�ȵ���0,����ֵG�ȵ���0  ,��������ֵ��
        % �丸�ڵ������ֵ���ݶ�Ϊ��(��Ϊ��ʱ���޷��ж��丸�ڵ������Ƕ���)
        if o == 2
        if mod(current(1,3),2)==0 %������ѡ����
            next=next1;
        end
        if mod(current(1,3),2)==1
            next=next2;
        end
        end
        if o == 1
        if mod(current(1,3),2)==1 %������ѡ����
            next=next1;
        end
        if mod(current(1,3),2)==0
            next=next2;
        end
        end
        m = [current(1,1)+next(in,1) , current(1,2)+next(in,2) ,current(1,3)+next(in,3), 0 , 0 , 0 ,0]; 
        m(5) = current(1,5) + next(in,4); % m(4)  ���ڽڵ�Gֵ
        m(4) = m(5) + h(m(1:3),map.goal);% m(3)  ���ڽڵ�Fֵ
        
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
            m(6:8)=[current(1,1),current(1,2),current(1,3)];%����ǰ�ڵ���Ϊ�丸�ڵ�
            open = [open;m];%�������ڽڵ�ӷ�openlist��
        %>>ʣ�µ������������Openlist�У�����ɵ�ǰ�ڵ㵽���ڽڵ��Ƿ���ã�
        %  ��������򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������F,Gֵ�����򲻲���
        else
            %�ɵ�ǰ�ڵ㵽�����ڽڵ����(targetInd�Ǵ����ڽڵ���open�е��к� ���еĵ�3���Ǵ��ۺ���Fֵ)
            if m(4) < open(targetInd,4)
                %���ã��򽫴����ڽڵ�ĸ��ڵ�����Ϊ��ǰ�ڵ㣬����������
                m(6:8)=[current(1,1),current(1,2),current(1,3)];%����ǰ�ڵ���Ϊ�丸�ڵ�
                open(targetInd,:) = m;%�������ڽڵ���Openlist�е����ݸ���
            end
        end
    end
     plot_map(map,obstacle,open,close,o);
end
%׷��·��
path=GetPath(close,map.start);
if length(path)>=1
    if j==1
        plot3(path(:,1)+0.5,path(:,2)+0.5,path(:,3)+0.5,'-m','LineWidth',5);hold on;
    end
    if j==2
        plot3(path(:,1)+0.5,path(:,2)+0.5,path(:,3)+0.5,'-b','LineWidth',5);hold on;
    end
    if j==3
        plot3(path(:,1)+0.5,path(:,2)+0.5,path(:,3)+0.5,'-y','LineWidth',5);hold on;
    end
    if j==4
        plot3(path(:,1)+0.5,path(:,2)+0.5,path(:,3)+0.5,'-k','LineWidth',5);hold on;
    end
end

end
