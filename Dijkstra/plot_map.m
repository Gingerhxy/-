function  plot_map( map,obstacle,open,close )

% %�����ϰ��㡢��ʼ�㡢�յ�
%��������
% for i = 1:map.XMAX+3
%    line([-0.5,map.XMAX+1.5],[i-1.5,i-1.5]);
% end
% 
% for j = 1:map.YMAX+3
%    line([j-1.5,j-1.5],[-0.5,map.YMAX+1.5]);
% end
pause(0.1);
title('��ɫΪ�ϰ���ͱ߽�㣬��ɫΪclose�ڵ㣬��ɫΪopen�ڵ㣬����Ϊpath');
%���ƽڵ�
plot(close(:,1)+0.5,close(:,2)+0.5,'sr','MarkerFaceColor','r');
hold on;
%pause(0.1);
plot(open(:,1)+0.5,open(:,2)+0.5,'sg','MarkerFaceColor','g');
hold on;
%pause(0.1);
end
