function hcost = h( m,goal )

%����������������ֵ ����������������㷨
hcost =(10* abs(  m(1)-goal(1)  ))+(10*abs(  m(2)-goal(2)  ))+(10*abs(  m(3)-goal(3)  ));
hcost = 1*hcost;
%hcost = 0;
end