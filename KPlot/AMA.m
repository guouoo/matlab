function AMAvalue = AMA(Price, len, fastlen, slowlen)
% 卡夫曼自适应移动平均线 函数
% Last Modified by LiYang 2014/5/1
% Email:faruto@163.com

%% 输入参数检查
error(nargchk(1, 4, nargin))
if nargin < 4
    slowlen = 30;
end
if nargin < 3
    fastlen = 2;
end
if nargin < 2
    len = 10;
end

%% 指定AMA系数
fast = 2/(fastlen + 1);
slow = 2/(slowlen + 1);

%% 计算EMAvalue
AMAvalue = zeros(length(Price), 1);
AMAvalue(1:len) = Price(1:len);

for i = len+1:length(Price)
    
    direction = abs( Price(i)-Price(i-len) );
    p1 = Price( (i-len+1):i );
    p2 = Price( (i-len):(i-1) );
    volatility = sum( abs(p1-p2) );
    % Efficiency_Ratio
    ER = direction/volatility;
    
    smooth = ER*(fast-slow) + slow;
    c = smooth*smooth;
    
    AMAvalue(i) = AMAvalue(i-1) + c*( Price(i)-AMAvalue(i-1) );
end
