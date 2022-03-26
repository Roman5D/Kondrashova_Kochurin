%рабочая зона для дельта робота
function[] = BuildWorkArea()
q_max = [
        180     * (2*pi/360)
        180     * (2*pi/360)
        180     * (2*pi/360)
        ];

q_min = [
        -180    * (2*pi/360)
        -180    * (2*pi/360)
        -180    * (2*pi/360)
        ];

%разделить на .. промежутков
numberInterval = [
                60
                60
                60
            ];

numberPointsAll = numberInterval(1)*numberInterval(2)*numberInterval(3);

q_delta = [
        (q_max(1) - q_min(1)) / numberInterval(1)
        (q_max(2) - q_min(2)) / numberInterval(2)
        (q_max(3) - q_min(3)) / numberInterval(3)
            ];

%вычисление поля точек
quaOfPoint = 0;
Points = zeros(numberPointsAll, 3);

for counter1 = 1:numberInterval(1)
    q(1) = q_min(1) + q_delta(1) * counter1;
    for counter2 = 1:numberInterval(2)
        q(2) = q_min(2) + q_delta(2) * counter2;
        for counter3 = 1:numberInterval(3)
            q(3) = q_min(3) + q_delta(3) * counter3;
            [flaq, tempCoordinates] = DirectTask(q);
            if (flaq == 0)
                quaOfPoint = quaOfPoint + 1;
                Points(quaOfPoint, :) = tempCoordinates(:);          
            end
        end
    end
end

%отбрасывание нулевых точек
Points = Points(1:quaOfPoint, :);

save('mat\matlab_deltarobot workspace.mat', 'Points');

% plot3(Points(:,1), Points(:,2), Points(:,3), '.');

end
