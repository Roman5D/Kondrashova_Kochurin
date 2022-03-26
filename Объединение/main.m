%достаём необходимые файлы из других папок
clc; clear; close all;


%%
%
clc; clear; %close all;
%---------
load('.\mat\matlab_deltarobot workspace.mat');
lenDelta = length(Points);
PointsDelta = Points;
load('.\mat\matlab_rob1 workspaceUpd.mat');
lenManipul = length(Points);
PointsManipul = Points;
%---------

PointsDelta = - 28 * PointsDelta;%иттерационно

deltaHeight = 10;
for i = 1:lenDelta
    if ((sqrt(PointsDelta(i, 1)^2 + PointsDelta(i, 2)^2)) <= 0.00001) 
        if (PointsDelta(i, 3) < deltaHeight)
            deltaHeight = PointsDelta(i, 3);
        end
    end
end

PointsDelta(:, 3) = PointsDelta(:, 3) - deltaHeight;

Points = PointsDelta;
Points(:, 1) = PointsDelta (:, 1);
Points(:, 2) = - PointsDelta (:, 3);
Points(:, 3) = PointsDelta (:, 2);
PointsDelta = Points;

PointsDelta(:, 3) = PointsDelta(:, 3) + 0.15;%длина звена l1
PointsDelta(:, 3) = PointsDelta(:, 3) + 0.13;%иттерационно (вверх-вниз)
PointsDelta(:, 2) = PointsDelta(:, 2) + 0.45;%иттерационно (в сторону))

figure;
hold on;

[K] = boundary(PointsDelta);
trisurf(K, PointsDelta(:, 1), PointsDelta(:, 2), PointsDelta(:, 3), 'Facecolor', 'red', 'FaceAlpha', 0.2, 'LineStyle', 'none');
% plot3(PointsDelta(:, 1), PointsDelta(:, 2), PointsDelta(:, 3), '.b');

% [K] = boundary(PointsManipul);
% trisurf(K, PointsManipul(:, 1), PointsManipul(:, 2), PointsManipul(:, 3), 'Facecolor', 'green', 'FaceAlpha', 0.2, 'LineStyle', 'none');

% plot3(PointsDelta(:, 1), PointsDelta(:, 2), PointsDelta(:, 3), '.b');
plot3(PointsManipul(:, 1), PointsManipul(:, 2), PointsManipul(:, 3), '.g');

% plot3(0, 0, 0, '.k');
hold off;