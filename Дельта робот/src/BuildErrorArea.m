%%
%карта ошибок для дельта робота
function[] = BuildErrorArea()

q_max = [
        135     * (2*pi/360)
        135     * (2*pi/360)
        135     * (2*pi/360)
        ];

q_min = [
        0       * (2*pi/360)
        0       * (2*pi/360)
        0       * (2*pi/360)
        ];

%разделить на .. промежутков
numberInterval = [
                60
                60
                60
            ];

%задание ошибок углов определения датчиков
q_mistake = [
            1   * (2*pi/360)
            1   * (2*pi/360)
            1   * (2*pi/360)
            ];

quaOfInterval = 4;
% colorOfInterval = [
%                     'green'
%                     'cyan'
%                     'yellow'
%                     'red'
%                 ];
colorOfInterval = [
                    '.g'
                    '.c'
                    '.y'
                    '.r'
                ];

%-------------------------------
%далее подсёт и ничего не менять
numberPointsAll = numberInterval(1)*numberInterval(2)*numberInterval(3);

q_delta = [
        (q_max(1) - q_min(1)) / numberInterval(1)
        (q_max(2) - q_min(2)) / numberInterval(2)
        (q_max(3) - q_min(3)) / numberInterval(3)
            ];

%вычисление поля точек

Points = zeros(numberPointsAll, 3);
quaOfPoints = 0;
mistakePoints = zeros(numberPointsAll, 1);
minMistake = 1000; %1000 метров
maxMistake = 0; %0 метров

for counter1 = 1:numberInterval(1)
    q(1) = q_min(1) + q_delta(1) * counter1;
    for counter2 = 1:numberInterval(2)
        q(2) = q_min(2) + q_delta(2) * counter2;
        for counter3 = 1:numberInterval(3)
            q(3) = q_min(3) + q_delta(3) * counter3;
            [flaq, tempCoordinates] = DirectTask(q);
            if (flaq == 0)
                quaOfPoints = quaOfPoints + 1;
                Points(quaOfPoints, :) = tempCoordinates(:);
                for mis1 = 0:1
                    q_temp(1) = q(1) - q_mistake(1) + 2 * q_mistake(1) * mis1;
                    for mis2 = 0:1
                        q_temp(2) = q(2) - q_mistake(2) + 2 * q_mistake(2) * mis2;
                        for mis3 = 0:1
                            q_temp(3) = q(1) - q_mistake(3) + 2 * q_mistake(3) * mis3;
                            [flaq, tempCoordinates] = DirectTask(q_temp);
                            if (flaq == 0)
                                temp_mistakeVector = Points(quaOfPoints, :) - tempCoordinates;
                                temp_mistake = temp_mistakeVector(1)^2 + temp_mistakeVector(2)^2 + temp_mistakeVector(3)^2;
                                temp_mistake = sqrt(temp_mistake);
                                if (temp_mistake > mistakePoints(quaOfPoints))
                                    mistakePoints(quaOfPoints) = temp_mistake;
                                    coordinateMistakePoint = tempCoordinates;
                                end
                            end
                        end
                    end
                end
                if (mistakePoints(quaOfPoints) > maxMistake)
                    maxMistake = mistakePoints(quaOfPoints);
                    numberMaxMistake = quaOfPoints;
                    coordinateMaxMistake = coordinateMistakePoint;
                else
                    if (mistakePoints(quaOfPoints) < minMistake)
                        minMistake = mistakePoints(quaOfPoints);
                        numberMinMistake = quaOfPoints;
                        coordinateMinMistake = coordinateMistakePoint;
                    end
                end
            end
        end
    end
end

%отбрасывание нулевых точек
Points = Points(1:quaOfPoints, :);
mistakePoints = mistakePoints(1:quaOfPoints);

PointsInterval = zeros(quaOfPoints, 3, quaOfInterval);
quaOfPointsInterval = zeros(quaOfInterval, 1);
PointsError = zeros(1, 3);
quaOfPointsError = 0;

deltaInterval = (maxMistake - minMistake) / quaOfInterval;
boarderInterval = zeros(quaOfInterval, 2);
for i = 1:quaOfInterval
    boarderInterval(i, 1) = minMistake + (i - 1) * deltaInterval;
    boarderInterval(i, 2) = minMistake + i * deltaInterval;
end

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

%удаление нулевых точек
largestMax = 0;
for i = 1:quaOfInterval
   if largestMax < quaOfPointsInterval(i)
      largestMax = quaOfPointsInterval(i);
   end
end
PointsInterval = PointsInterval(1:largestMax, :, :);

save('.\mat\matlab_deltarobot errorspace.mat', 'PointsInterval', 'quaOfPointsInterval', 'quaOfInterval', 'colorOfInterval', 'boarderInterval');
save('.\mat\matlab_deltarobot errorspaceDebug.mat', 'Points', 'numberMaxMistake', 'coordinateMaxMistake', 'numberMinMistake', 'coordinateMinMistake');

% plot3(0, 0, 0, '.');
% hold on
% for i = 1:quaOfInterval
%     tempPointsInterval = PointsInterval(1:quaOfPointsInterval(i), :, i);
%     plot3(tempPointsInterval(:,1), tempPointsInterval(:,2), tempPointsInterval(:,3), colorOfInterval(i, :));
% end
% hold off

end
