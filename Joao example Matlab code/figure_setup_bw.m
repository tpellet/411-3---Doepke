N = 10;
% s = [0;.2;.4;.7;1];
loc = 'northwest';

map2 = gray(5);
map2(end,:) = [];

map(1,:) = map2(1,:);
map(2,:) = map2(3,:);
map(3,:) = map2(2,:);
map(4,:) = map2(4,:);

set(0,'DefaultLineLineWidth',2);
set(0,'defaultAxesLineStyleOrder','-|-.|:|-o|--o|:o|-^|--^|:^');
set(0,'defaulttextinterpreter','LaTex');
set(0,'defaultAxesColorOrder',map);
% set(0,'defaultAxesColorOrder',bone(20));
% C = repmat(linspace(1,0.1,N).',1,3);
% axes('ColorOrder',C,'NextPlot','replacechildren')
set(0,'DefaultAxesFontSize',30);
set(0,'DefaultTextFontSize',36);
set(0,'DefaultAxesFontName','Helvetica');
set(0,'DefaultTextFontName','Helvetica');
% set(0,'DefaultUipanelFontName','Helvetica');
set(0,'DefaultTextFontWeight','normal');
set(0,'defaulttextinterpreter','LaTex');
set(0,'DefaultLegendInterpreter','LaTex')

test = 0;
if test == 1
    plot(1:10,cumsum(rand(10,length(s))))
end

close all; clear test N C;