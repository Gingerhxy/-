function path=GetPath(close,start)

    ind=1;
    path=[];
    while 1
        path=[path; close(ind,1:2)];
        if isequal(close(ind,1:2),start)   
            break;
        end
        for io=1:length(close(:,1))
            if isequal(close(io,1:2),close(ind,4:5))   %close(1,4:5)����goal��ĸ��ڵ㣬������ȥ����һ��close(io,1:2)�����goal�ĸ��ڵ㣬�ҵ��Ժ��ڼ�������ȥ��˭����������ڵ�ĸ��ڵ㣬ֱ�����ڵ�Ϊstart.
                ind=io;
                break;
            end
        end
    end
end