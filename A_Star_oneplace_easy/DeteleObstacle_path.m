function obstacle=DeteleObstacle_path(obstacle,path)
%�������·�������꣬�����ϰ�
    for i = 1:length(path(:,1))
        obstacle(find(ismember(obstacle, [path(i,:)],'rows')),:)=[];
    end
end