%#eml
function y = externalmfile1(u)

%   Copyright 2008 The MathWorks, Inc.

if u>1 && u<5
    a = 2;
else
    a = 3;
end

for i=1:5
    a = a+2;
end

y = a+localtest(a);

[x,y] = pol2cart(u,u);
[y2,y3] = cart2pol(x,y);

function y = localtest(u)

y = 0;
flg = true;
while flg
    u = u/2;
    y = y+1;
    flg = u>2;
end
