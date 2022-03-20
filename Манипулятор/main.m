clc; clear; close all;
%%
clc; clear; close all;
%отображение поля точек манипулятора 1 из сохранённого mat
load('matlab_rob1 workspaceUpd.mat');
plot3(Points(:,1), Points(:,2), Points(:,3), '.');

%%
clc; clear; close all;
%отображение поля точек манипулятора 2 из сохранённого mat
load('matlab_rob2 workspaceUpd.mat');
plot3(Points(:,1), Points(:,2), Points(:,3), '.');

%%
clc; clear; close all;
%отображение поля точек манипулятора 3 из сохранённого mat
load('matlab_rob3 workspaceUpd.mat');
plot3(Points(:,1), Points(:,2), Points(:,3), '.');

%%
% %----------------
% %данная часть для проверки правильности составления манипулятора
% %задание углов поворота
% tetta_robot1_0 = [
%     0
%     0
%     0
%     0
%     0
%     0
%     0
%     ];
% 
% coordinate0 = Manipulator1(tetta_robot1_0);
% %----------------

%--------------------------------------
%стандартное количество точек
%%
clc; clear; close all;
%построение поля точек
Points = Manipulator1_workspace(1);
save('matlab_rob1 workspaceUpd.mat', 'Points');

Points = Manipulator2_workspace(1);
save('matlab_rob2 workspaceUpd.mat', 'Points');

Points = Manipulator3_workspace(1);
save('matlab_rob3 workspaceUpd.mat', 'Points');

%---------------------------------------
%расширенное количество точек
%%
clc; clear; close all;
%построение поля точек
Points = Manipulator1_workspace(2);
save('matlab_rob1 workspaceNewUpd.mat', 'Points');

Points = Manipulator2_workspace(2);
save('matlab_rob2 workspaceNewUpd.mat', 'Points');

Points = Manipulator3_workspace(2);
save('matlab_rob3 workspaceNewUpd.mat', 'Points');



%%
%для сохранения большого колиества точек
allDotes = 631688364;
Part = allDotes/10;
star = 1;
ende = Part;
Points_1_9 = Points(star:ende,:);
Points_2_9 = Points(star+Part:ende+Part,:);
Points_3_9 = Points(star+2*Part:ende+2*Part,:);
Points_4_9 = Points(star+3*Part:ende+3*Part,:);
Points_5_9 = Points(star+4*Part:ende+4*Part,:);
Points_6_9 = Points(star+5*Part:ende+5*Part,:);
Points_7_9 = Points(star+6*Part:ende+6*Part,:);
Points_8_9 = Points(star+7*Part:ende+7*Part,:);
Points_9_9 = Points(star+8*Part:ende+8*Part,:);

save('matlab_rob1 workspaceNew1_9.mat', 'Points_1_9');
save('matlab_rob1 workspaceNew2_9.mat', 'Points_2_9');
save('matlab_rob1 workspaceNew3_9.mat', 'Points_3_9');
save('matlab_rob1 workspaceNew4_9.mat', 'Points_4_9');
save('matlab_rob1 workspaceNew5_9.mat', 'Points_5_9');
save('matlab_rob1 workspaceNew6_9.mat', 'Points_6_9');
save('matlab_rob1 workspaceNew7_9.mat', 'Points_7_9');
save('matlab_rob1 workspaceNew8_9.mat', 'Points_8_9');
save('matlab_rob1 workspaceNew9_9.mat', 'Points_9_9');
save('matlab_rob1 workspaceNew10_9.mat', 'Points_9_9');


%%
close all;
%отображение поля точек
load('matlab_rob1 workspaceUpd.mat');
plot3(Points(:,1), Points(:,2), Points(:,3), '.');


%%
%какие-то улучшения
[K] = boundary(Points);
trisurf(K, Points(:, 1), Points(:, 2), Points(:, 3), 'Facecolor', 'red', 'FaceAlpha', 1, 'LineStyle', 'none');
