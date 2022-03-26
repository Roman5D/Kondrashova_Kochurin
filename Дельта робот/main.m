%%
%вывод рабочей зоны и карты ошибок из сохранённого mat
clc; clear; close all;
load('.\mat\matlab_deltarobot workspace.mat');
figure;
hold on;
plot3(Points(:, 1), Points(:, 2), Points(:, 3), '.');
plot3(0, 0, 0, '.k');
hold off;

%вывод карты ошибок из сохранённого mat
load('.\mat\matlab_deltarobot errorspace.mat');
figure;
hold on

for i = 1:quaOfInterval
    tempPointsInterval = PointsInterval(1:quaOfPointsInterval(i), :, i);
    simb1 = num2str(round(boarderInterval(i, 1), 4));
    simb2 = num2str(round(boarderInterval(i, 2), 4));
    lenSimb = length(simb1) + length(simb2) + 2;
    simb(1:lenSimb) = strcat(simb1, ', ' ,simb2);
    plot3(tempPointsInterval(:,1), tempPointsInterval(:,2), tempPointsInterval(:,3), colorOfInterval(i, :), 'DisplayName', simb);
end

legend;
plot3(0, 0, 0, '.k', 'DisplayName', 'Origin');
hold off;

%%
%построение, сохранение и вывод рабочей зоны дельтаробота
clc; clear; close all;
path ('.\src',path);
BuildWorkArea();
rmpath ('.\src');

%построение, сохранение и вывод карты ошибок дельтаробота
clc; clear; close all;
path ('.\src',path);
BuildErrorArea();
rmpath ('.\src');

%%
clc; clear;
load('.\mat\matlab_deltarobot errorspaceDebug.mat');
figure;
hold on;
plot3(Points(numberMaxMistake, 1), Points(numberMaxMistake, 2), Points(numberMaxMistake, 3), '.g');
plot3(coordinateMaxMistake(1), coordinateMaxMistake(2), coordinateMaxMistake(3), '.r');
hold off;

figure;
hold on;
plot3(Points(numberMinMistake, 1), Points(numberMinMistake, 2), Points(numberMinMistake, 3), '.g');
plot3(coordinateMinMistake(1), coordinateMinMistake(2), coordinateMinMistake(3), '.r');
hold off;