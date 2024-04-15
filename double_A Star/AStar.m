function path=AStar(obstacle,map)
% �ó���ΪA*�㷨

% ���ڴ洢·��
path = [];
%OpenList
open = [];
open_back = [];
%CloseList
close = []; 
close_back = []; 
% findFlag�����ж�Whileѭ���Ƿ����
findFlag=false;%Ŀ���־

%===================1.����ʼ�����Openlist��======================
%open����ÿһ��  [�ڵ����꣬����ֵF=G+H,����ֵG,���ڵ�����]
open =[map.start(1), map.start(2) ,map.start(3) , 0+h(map.start,map.goal) , 0 , map.start(1) , map.start(2) ,map.start(3)];
open_back =[map.goal(1), map.goal(2) ,map.goal(3) , 0+h(map.goal,map.start) , 0 , map.goal(1) , map.goal(2) ,map.goal(3)];
%����״̬--��һ���İ˸���
[next1,next2] = MotionModel();

%=======================2.�ظ����¹���==============================
while ~findFlag

    %--------------------�����ж��Ƿ�ﵽĿ��㣬����·��-----
    if isempty(open(:,1))
        disp('����֮����·��������ʧ��!!');
        return;
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
        if mod(current(1,3),2)==1
            next=next1;
        end
        if mod(current(1,3),2)==0
            next=next2;
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
 %%%%%%%%%%%%%%%%%%%%%%%%%%����A*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %--------------------�����ж��Ƿ�ﵽĿ��㣬����·��-----
    if isempty(open_back(:,1))
        disp('����֮����·��������ʧ��!!');
        return;
    end

    %------------------a.����Openlist�еĵ����У����ۺ���F����������
    %--------------------����Fֵ��С�Ľڵ�
    [Y_back,I_back] = sort(open_back(:,4)); % ��OpenList�е���������
    open_back=open_back(I_back,:);%open�е�һ�нڵ���Fֵ��С��
    
    %------------------b.��Fֵ��С�Ľڵ�(��open�е�һ�нڵ�)���ŵ�close
    %--------------------��һ��(close�ǲ��ϻ�ѹ��)����Ϊ��ǰ�ڵ�
    close_back = [open_back(1,:);close_back];
    current_back = open_back(1,:);
    open_back(1,:)=[];% ��Ϊ�Ѿ���open���Ƴ��ˣ����Ե�һ����ҪΪ��
    
    %--------------------c.�Ե�ǰ�ڵ���Χ��4�����ڽڵ㣬�㷨�����壺------------------------
    for in=1:length(next1(:,1))
        % ������ڽڵ������,����ֵF�ȵ���0,����ֵG�ȵ���0  ,��������ֵ��
        % �丸�ڵ������ֵ���ݶ�Ϊ��(��Ϊ��ʱ���޷��ж��丸�ڵ������Ƕ���)
        if mod(current_back(1,3),2)==1
            next_back=next1;
        end
        if mod(current_back(1,3),2)==0
            next_back=next2;
        end
        m_back = [current_back(1,1)+next_back(in,1) , current_back(1,2)+next_back(in,2) ,current_back(1,3)+next_back(in,3), 0 , 0 , 0 ,0]; 
        m_back(5) = current_back(1,5) + next_back(in,4); % m(4)  ���ڽڵ�Gֵ
        m_back(4) = m_back(5) + h(m_back(1:3),map.start);% m(3)  ���ڽڵ�Fֵ
        
        %>>��������ɴ��������������һ�����ڽڵ�  (ע�⣬obstacle�����
        %  �����ǰ����߽��)
        if isObstacle(m_back,obstacle)
            continue;
        end
        %flag == 1�����ڽڵ�  ��Closelist��  targetInd = close���к�
        %flag == 2�����ڽڵ㲻��Openlist��   targetInd = []
        %flag == 3�����ڽڵ�  ��Openlist��   targetInd = open���к�
        [flag_back,targetInd_back] = FindList(m_back,open_back,close_back);
        
        %>>�������Closelist�У����Դ����ڽڵ�
        if flag_back==1
            continue;
        %>>���������Openlist�У�����Openlist,���ѵ�ǰ�ڵ�����Ϊ���ĸ��ڵ�
        elseif flag_back==2
            m_back(6:8)=[current_back(1,1),current_back(1,2),current_back(1,3)];%����ǰ�ڵ���Ϊ�丸�ڵ�
            open_back = [open_back;m_back];%�������ڽڵ�ӷ�openlist��
        %>>ʣ�µ������������Openlist�У�����ɵ�ǰ�ڵ㵽���ڽڵ��Ƿ���ã�
        %  ��������򽫵�ǰ�ڵ�����Ϊ�丸�ڵ㣬������F,Gֵ�����򲻲���
        else
            %�ɵ�ǰ�ڵ㵽�����ڽڵ����(targetInd�Ǵ����ڽڵ���open�е��к� ���еĵ�3���Ǵ��ۺ���Fֵ)
            if m_back(4) < open_back(targetInd_back,4)
                %���ã��򽫴����ڽڵ�ĸ��ڵ�����Ϊ��ǰ�ڵ㣬����������
                m_back(6:8)=[current_back(1,1),current_back(1,2),current_back(1,3)];%����ǰ�ڵ���Ϊ�丸�ڵ�
                open_back(targetInd_back,:) = m_back;%�������ڽڵ���Openlist�е����ݸ���
            end
        end
    end
    
        %------------------�ж����������Ƿ񽻻�
    [isopenFlag,Id]=isopen(current_back,open);
    [isopenFlag_back,Id_back]=isopen(current,open_back);
    if isopenFlag
        disp('A Star forward���߳ɹ�!!');
        disp(open(Id,:));
        disp(current_back(1,:));
        close = [open(Id,:);close];
        findFlag=true;
        break;
    end
    if isopenFlag_back
        disp('A Star back���߳ɹ�!!');
        disp(open_back(Id_back,:));
        disp(current(1,:));
        close_back = [open(Id_back,:);close_back];
        findFlag=true;
        break;
    end
    
    plot_map(map,obstacle,open,close,open_back,close_back);
end
%׷��·��
path=GetPath(close,map.start,close_back,map.goal);
disp(length(open(:,1)));
disp(length(open_back(:,1)));
disp(length(close(:,1)));
disp(length(close_back(:,1)));
end
