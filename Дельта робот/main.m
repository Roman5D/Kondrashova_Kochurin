%%
%вывод рабочей зоны и карты ошибок из сохранённого mat
clc; clear; close all;
load('.\mat\matlab_deltarobot workSpace.mat');
figure;
hold on;
plot3(Points(:, 1), Points(:, 2), Points(:, 3), '.');
plot3(0, 0, 0, '.k');
hold off;

clc; clear;
load('.\mat\matlab_deltarobot errorSpace.mat');

%--------------------------
%Масштабирование в миллиметры только для вывода
%Если необходимо раскомментировать всё
%
for j = 1:2
    for i = 1:4
        boarderInterval(i, j) = 1000000 * boarderInterval(i, j);
    end
end

maxQuaPoints = 0;
for i = 1:4
    if (quaOfPointsInterval(i) > maxQuaPoints)
        maxQuaPoints = quaOfPointsInterval(i);
    end
end

for k = 1:4
    for j = 1:3
        for i = 1:maxQuaPoints
            PointsInterval(i, j , k) = 1000 * PointsInterval(i, j , k);
        end
    end
end
%
%--------------------------

figure;
hold on

for i = 1:quaOfInterval
    tempPointsInterval = PointsInterval(1:quaOfPointsInterval(i), :, i);
    simb1 = num2str(round(boarderInterval(i, 1), 2));
    simb2 = num2str(round(boarderInterval(i, 2), 2));
    simb = strcat(simb1, ', ', simb2, ' * 10^-^3');
    plot3(tempPointsInterval(:,1), tempPointsInterval(:,2), tempPointsInterval(:,3), colorOfInterval(i, :), 'DisplayName', simb);
end

legend;
plot3(0, 0, 0, '.k', 'DisplayName', 'Origin');
hold off;
clc; clear;

%%
%построение и сохранение рабочей зоны дельтаробота
clc; clear; close all;
path ('.\src',path);
BuildWorkArea();
rmpath ('.\src');
clc; clear; close all;

%%
%построение и сохранение карты ошибок дельтаробота
clc; clear; close all;
path ('.\src',path);
BuildErrorArea();
rmpath ('.\src');
clc; clear; close all;