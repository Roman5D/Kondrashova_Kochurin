%%
%����������� ������� ����������� ������������� ��� ����� ���������
clc; clear; close all;
load('.\mat\matlab_rob1 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 Without Platform');

%����������� ���� ����� ������������ 2 �� ����������� mat
load('.\mat\matlab_rob2 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 2 Without Platform');

%����������� ���� ����� ������������ 3 �� ����������� mat
load('.\mat\matlab_rob3 workspace.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 3 Without Platform');

%����������� ������� ����������� ������������� � ������ ���������
load('.\mat\matlab_rob1 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 1 With Platform');

%����������� ���� ����� ������������ 2 �� ����������� mat
load('.\mat\matlab_rob2 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 2 With Platform');

%����������� ���� ����� ������������ 3 �� ����������� mat
load('.\mat\matlab_rob3 workspaceUpd.mat');
figure;
plot3(Points(:,1), Points(:,2), Points(:,3), '.');
title('Manipulator 3 With Platform');

%%
%��������� �������� ������������ 1
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
%���������� ���� ����� ���� ������������� ��� ����� ���������
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
%���������� ���� ����� ���� ������������� � ������ ���������
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
%�����-�� ���������
[K] = boundary(Points);
trisurf(K, Points(:, 1), Points(:, 2), Points(:, 3), 'Facecolor', 'red', 'FaceAlpha', 1, 'LineStyle', 'none');
