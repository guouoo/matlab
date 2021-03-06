clear;clc;
conn = database('data','root','66196619','com.mysql.jdbc.Driver','jdbc:mysql://localhost:3306/data');
% curs1 = exec(conn,'select symbol from data.nav_etf group by symbol');
% curs1 = fetch(curs1);
% data2 = curs1.Data;

curs = exec(conn,'select clnav from data.nav_etf where symbol ="159902" and date > "2013-07-20" and date < "2016-03-08"order by date asc');
curs = fetch(curs);
data0 = curs.Data;
%num = rows(curs);
data1 = cell2mat(data0);
%data2 = data1(1:num,1);
dailyret = (data1(2:end)-data1(1:end-1))./data1(1:end-1);
excessRet = dailyret - 0.03/252;
sharpRatio = sqrt(252)*mean(excessRet)/std(excessRet);
sharpRatio
cumret = cumprod(1+dailyret)-1;
cumret(end)
plot(cumret);
[maxDrawdown maxDrawdownDuration]=calculateMaxDD(cumret); % count the maxdown and maxdown days
maxDrawdown
maxDrawdownDuration