function obstacle=GetObstacle_path(obstacle,path)
%�������·�������꣬�����ϰ�
    for i = 1:length(path(:,1))
        obstacle=[obstacle;[path(i,:)]];
    end
end