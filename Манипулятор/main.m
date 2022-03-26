%%
%отображение рабочих пространств манипуляторов без учёта платформы
clc; clear; close all;
load('.\mat\matlab_rob1 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 Without Platform');

%отображение поля точек манипулятора 2 из сохранённого mat
load('.\mat\matlab_rob2 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 2 Without Platform');

%отображение поля точек манипулятора 3 из сохранённого mat
load('.\mat\matlab_rob3 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 3 Without Platform');

%отображение рабочих пространств манипуляторов с учётом платформы
load('.\mat\matlab_rob1 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 With Platform');

%отображение поля точек манипулятора 2 из сохранённого mat
load('.\mat\matlab_rob2 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 2 With Platform');

%отображение поля точек манипулятора 3 из сохранённого mat
load('.\mat\matlab_rob3 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 3 With Platform');

%%
%вычитание графиков маниуплятора 1
clc; clear; close all;

load('.\mat\matlab_rob1 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 Without Platform');
PointsWithout = Points;

load('.\mat\matlab_rob1 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 With Platform');
PointsWith = Points;

L1 = length(PointsWithout);
L2 = length(PointsWith);
q2 = 1;
Points = zeros (L1, 3);
quaOfPoints = 0;
for q1 = 1:L1
    if ((PointsWithout(q1,1) == PointsWith(q2,1)) && (PointsWithout(q1,2) == PointsWith(q2,2)) && (PointsWithout(q1,3) == PointsWith(q2,3)))
        if (q2 < L2)
            q2 = q2 + 1;
        end
    else
        quaOfPoints = quaOfPoints + 1;
        Points(quaOfPoints, :) = PointsWithout(q1,:);
    end
end

Points = Points(1:quaOfPoints,:);
Delta = Points;

figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 Delta');

figure;
hold on;
plot3(PointsWith(:,1), PointsWith(:,2), PointsWith(:,3), '.g');
plot3(Delta(:,1), Delta(:,2), Delta(:,3), '.r');
hold off;
title('Manipulator 1 With + Delta');

%%
%построение поля точек всех манипуляторов без учёта платформы
clc; clear; close all;
path ('.\src',path);

Points = Manipulator1_workspace(0);
save('.\mat\matlab_rob1 workspace.mat', 'Points');

%%
Points = Manipulator2_workspace(0);
save('.\mat\matlab_rob2 workspace.mat', 'Points');

Points = Manipulator3_workspace(0);
save('.\mat\matlab_rob3 workspace.mat', 'Points');

rmpath ('.\src');

%%
%построение поля точек всех манипуляторов с учетом платформы
clc; clear; close all;
path ('.\src',path);

Points = Manipulator1_workspace(1);
save('.\mat\matlab_rob1 workspaceUpd.mat', 'Points');

%%
Points = Manipulator2_workspace(1);
save('.\mat\matlab_rob2 workspaceUpd.mat', 'Points');

Points = Manipulator3_workspace(1);
save('.\mat\matlab_rob3 workspaceUpd.mat', 'Points');

rmpath ('.\src');


%%
%какие-то улучшения
[K] = boundary(Points);
trisurf(K, Points(:, 1), Points(:, 2), Points(:, 3), 'Facecolor', 'red', 'FaceAlpha', 1, 'LineStyle', 'none');
