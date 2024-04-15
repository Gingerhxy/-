function obstacle=GetObstacle(map,MAP)
%��õ�ͼ�ı߽���ϰ��������
    % ���ɱ߽������,�˴�XMAX��ʾMAP��������YMAX��ʾMAP������
    boundary=[];
    for i1=0:(map.YMAX+1)
        boundary=[boundary;[0 i1]];
    end
    for i2=0:(map.XMAX+1)
        boundary=[boundary;[i2 0]];
    end
    for i3=0:(map.YMAX+1)
        boundary=[boundary;[map.XMAX+1 i3]];
    end
    for i4=0:(map.XMAX+1)
        boundary=[boundary;[i4 map.YMAX+1]];
    end
    obstacle = boundary;
    % �����ϰ��������
    for i=1:map.XMAX
        for j=1:map.YMAX
            if MAP(i,j) == -1
                obstacle=[obstacle;[i j]];
            end
        end
    end
end