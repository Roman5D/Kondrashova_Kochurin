clc; clear; close all;
%%
%вывод рабочей зоны из сохранённого mat
clc; clear; close all;
load('matlab_deltarobot workspace.mat');
plot3(Points(:, 1), Points(:, 2), Points(:, 3), '.');

%%
%вывод карты ошибок из сохранённого mat
clc; clear; close all;
load('matlab_deltarobot errorspace.mat');
plot3(0, 0, 0, '.');
hold on
for i = 1:quaOfInterval
    tempPointsInterval = PointsInterval(1:quaOfPointsInterval(i), :, i);
    plot3(tempPointsInterval(:,1), tempPointsInterval(:,2), tempPointsInterval(:,3), colorOfInterval(i, :));
end
hold off

%%
clc; clear; close all;
%построение, сохранение и вывод рабочей зоны дельтаробота
BuildWorkArea();

%%
clc; clear; close all;
%построение, сохранение и вывод карты ошибок дельтаробота
BuildErrorArea();

