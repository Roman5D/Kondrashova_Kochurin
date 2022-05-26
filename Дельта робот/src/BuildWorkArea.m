%������� ���� ��� ������ ������
function[] = BuildWorkArea()

q_min = [
        -0    * (pi/180)
        -0    * (pi/180)
        -0    * (pi/180)
        ];

q_max = [
        120     * (pi/180)
        120     * (pi/180)
        120     * (pi/180)
        ];
    
%��������� �� .. �����������
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

%���������� ���� �����
quaOfPoint = 0;
Points = zeros(numberPointsAll, 3);

for counter1 = 1:numberInterval(1)
    q(1) = q_min(1) + q_delta(1) * counter1;
    for counter2 = 1:numberInterval(2)
        q(2) = q_min(2) + q_delta(2) * counter2;
        for counter3 = 1:numberInterval(3)
            q(3) = q_min(3) + q_delta(3) * counter3;
            [flaq, tempCoordinates, waste] = DirectTask(q);
            if (flaq == 1)
                quaOfPoint = quaOfPoint + 1;
                Points(quaOfPoint, :) = tempCoordinates(:);          
            end
        end
    end
end

%������������ ������� �����
Points = Points(1:quaOfPoint, :);

save('.\mat\matlab_deltarobot workSpace.mat', 'Points');

% plot3(Points(:,1), Points(:,2), Points(:,3), '.');

end
