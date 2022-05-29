%����� ������ ��� ������ ������
function[] = BuildErrorArea()

q_min = [
        -0       * (pi/180)
        -0       * (pi/180)
        -0       * (pi/180)
        ];
%

q_max = [
        120    * (pi/180)
        120    * (pi/180)
        120    * (pi/180)
        ];
%
    
%��������� �� .. �����������
numberInterval = [
                60
                60
                60
            ];
%

%������� ������ ����� ����������� ��������
q_mistake = [
            1    * (pi/180)
            1    * (pi/180)
            1    * (pi/180)
            ];
%

quaOfInterval = 4; %������ ������ 4, �� ������

%����������� ������ ����������
deltaPercentInterval = [
                        60
                        20
                        15
                        05
                        ];
%

colorOfInterval = [
                    '.g'    %green
                    '.c'    %cyan
                    '.y'    %yellow
                    '.r'    %red
                ];
%

%-------------------------------
%����� ����� � ������ �� ������
numberPointsAll = numberInterval(1)*numberInterval(2)*numberInterval(3);

q_delta = [
        (q_max(1) - q_min(1)) / numberInterval(1)
        (q_max(2) - q_min(2)) / numberInterval(2)
        (q_max(3) - q_min(3)) / numberInterval(3)
            ];
%

%���������� ���� �����

Points = zeros(numberPointsAll, 3);
quaOfPoints = 0;
mistakePoints = zeros(numberPointsAll, 1);
minMistake = 1000; %1000 ������
maxMistake = 0; %0 ������

temp_mistake = zeros(8 * 2, 3);

for counter1 = 1:numberInterval(1)
    q(1) = q_min(1) + q_delta(1) * counter1;
    for counter2 = 1:numberInterval(2)
        q(2) = q_min(2) + q_delta(2) * counter2;
        for counter3 = 1:numberInterval(3)
            q(3) = q_min(3) + q_delta(3) * counter3;
            [flaq, tempCoordinates, waste] = DirectTask(q);
            if (flaq == 1)
                quaOfPoints = quaOfPoints + 1;
                Points(quaOfPoints, :) = tempCoordinates(:);
                quaMisPoint = 0;
                for mis1 = 0:1
                    q_temp(1) = q(1) - q_mistake(1) + 2 * q_mistake(1) * mis1;
                    for mis2 = 0:1
                        q_temp(2) = q(2) - q_mistake(2) + 2 * q_mistake(2) * mis2;
                        for mis3 = 0:1
                            q_temp(3) = q(3) - q_mistake(3) + 2 * q_mistake(3) * mis3;
                            [flaq, tempCoordinates1, tempCoordinates2] = DirectTask(q_temp);
                            if (flaq == 1)
                                quaMisPoint = quaMisPoint + 2;
                                temp_mistake(quaMisPoint - 1, :) = tempCoordinates1(:);
                                temp_mistake(quaMisPoint, :) = tempCoordinates2(:);
                            end
                        end
                    end
                end
                %��������� ���� ������
                if (quaMisPoint > 0)
                    mistakePoints(quaOfPoints) = filter(Points(quaOfPoints, :), temp_mistake, quaMisPoint);
                else
                    mistakePoints(quaOfPoints) = Points(quaOfPoints, :);
                end
                
                %����� ����� ����������� � ������������ ������
                if (mistakePoints(quaOfPoints) >= maxMistake)
                    maxMistake = mistakePoints(quaOfPoints);
                end
                if (mistakePoints(quaOfPoints) <= minMistake)
                    minMistake = mistakePoints(quaOfPoints);
                end
            end
        end
    end
end

%������������ ������� �����
Points = Points(1:quaOfPoints, :);
mistakePoints = mistakePoints(1:quaOfPoints);

%������ ������ ����������
deltaInterval = zeros(quaOfInterval, 1);
for i = 1:quaOfInterval
    deltaInterval(i) = (maxMistake - minMistake*1) * (deltaPercentInterval(i) / 100);
end

boarderInterval = zeros(quaOfInterval, 2);
boarderInterval(1, 1) = minMistake;
boarderInterval(1, 2) = minMistake + deltaInterval(1);
for i = 2:quaOfInterval
    boarderInterval(i, 1) = boarderInterval(i - 1, 2);
    boarderInterval(i, 2) = boarderInterval(i - 1, 2) + deltaInterval(i);
end

%������������� ����� �� ����������
PointsInterval = zeros(quaOfPoints, 3, quaOfInterval);
quaOfPointsInterval = zeros(quaOfInterval, 1);
PointsError = zeros(1, 3);
quaOfPointsError = 0;

for i = 1:quaOfPoints
    flaq = 0;
    for j = 1:quaOfInterval
       if ((mistakePoints(i) >= boarderInterval(j, 1)) && (mistakePoints(i) < boarderInterval(j, 2)))
          quaOfPointsInterval(j) = quaOfPointsInterval(j) + 1;
          PointsInterval(quaOfPointsInterval(j), :, j) = Points(i, :);
          flaq = 1;
       end
    end
    if flaq == 0
        if mistakePoints(i) < (minMistake + deltaInterval)
            quaOfPointsInterval(1) = quaOfPointsInterval(1) + 1;
            PointsInterval(quaOfPointsInterval(1), :, 1) = Points(i, :);
        elseif mistakePoints(i) > (maxMistake - deltaInterval)
            quaOfPointsInterval(quaOfInterval) = quaOfPointsInterval(quaOfInterval) + 1;
            PointsInterval(quaOfPointsInterval(quaOfInterval), :, quaOfInterval) = Points(i, :);
        else
            quaOfPointsError = quaOfPointsError + 1;
            PointsError(quaOfPointsError, :) = Points(i, :);
        end
    end
end

%�������� ������� �����
largestMax = 0;
for i = 1:quaOfInterval
   if largestMax < quaOfPointsInterval(i)
      largestMax = quaOfPointsInterval(i);
   end
end
PointsInterval = PointsInterval(1:largestMax, :, :);

save('.\mat\matlab_deltarobot errorSpace.mat', 'PointsInterval', 'quaOfPointsInterval', 'quaOfInterval', 'colorOfInterval', 'boarderInterval');

% plot3(0, 0, 0, '.');
% hold on
% for i = 1:quaOfInterval
%     tempPointsInterval = PointsInterval(1:quaOfPointsInterval(i), :, i);
%     plot3(tempPointsInterval(:,1), tempPointsInterval(:,2), tempPointsInterval(:,3), colorOfInterval(i, :));
% end
% hold off

end

function[finalMis] = filter(Point, pointMis, quaMis)
%���������� �������� � �������� ������
vectorMis = zeros(quaMis, 3);
mis = zeros(quaMis, 1);
for i = 1:quaMis
    vectorMis(i, :) = Point - pointMis(i, :);
    mis(i) = vectorMis(i, 1)^2 + vectorMis(i, 2)^2 + vectorMis(i, 3)^2;
    mis(i) = sqrt(mis(i));
end

%������������ �� ����
maxMis = 0;
for i = 1:quaMis/2
    num1 = i * 2 - 1;
    num2 = i * 2;
    if (mis(num1) > mis(num2))
        tempMis = mis(num2);
    else
        tempMis = mis(num1);
    end
    if (maxMis < tempMis)
        maxMis = tempMis;
    end
end
finalMis = maxMis;
end