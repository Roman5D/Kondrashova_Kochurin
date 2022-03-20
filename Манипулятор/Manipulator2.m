%Построение манипулятора 2
function[coordinates] = Manipulator2(tetta)
%длины звеньев
l1 = 0.1;
l2 = 0.2;
l3 = tetta(3);
l4 = 0.15;
l5 = tetta(5);
l6 = tetta(6);

%Данные для матриц перехода
r = [0 l2 0 0 0 0];
alpha = [(pi/2) (pi/2) (pi/2) (-pi/2) (-pi/2) 0];
d = [l1 0 l3 l4 l5 l6];
tetta(1) = tetta(1) + (pi/2);
tetta(2) = tetta(2) + (pi/2);
tetta(3) = (pi/2);
tetta(4) = tetta(4) + 0;
tetta(5) = 0;
tetta(6) = tetta(7) + 0;

%Матрицы перехода
for i = 1:7
    A_temp = TransitionMatrix(r(i), alpha(i), d(i), tetta(i));
    A(:, :, i) = A_temp(:, :);
end

%Рассчёт координат

O0 = ([0 0 0 1]')';
for i = 1:7
    A_temp = eye(4);
    for j = 1:i
        A_temp_temp(:, :) = A(:, :, j);
        A_temp = A_temp * A_temp_temp;
    end
    OA(:, :, i) = A_temp(:, :);
    O_temp = (A_temp * O0')';
    O(i, :) = O_temp(:);
end

%Возвращение координат 
coordinates(1, :) = O0(1:3);
coordinates(2:8, :) = O(:, 1:3); 

%задание пределов входных переменных
q_max = [
    180     * (2*pi/360)
    170     * (2*pi/360)
    170     * (2*pi/360)
    170     * (2*pi/360)
    170     * (2*pi/360)
    170     * (2*pi/360)
    170     * (2*pi/360)
    ];

q_min = [
    -180    * (2*pi/360)
    -170    * (2*pi/360)
    -170    * (2*pi/360)
    -170    * (2*pi/360)
    -170    * (2*pi/360)
    -170    * (2*pi/360)
    -170    * (2*pi/360)
    ];

%разделить промежуток на .. точек
q_delta = 36;

%построение поля точек
Point(1,:) = [0 0 0];

quaOfPoint = 0;
for q1 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
    for q2 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
        for q3 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
            for q4 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
                for q5 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
                    for q6 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
                        for q7 = q_min(1):((q_max(1)-q_min(1))/q_delta):q_max(1)
                            tetta_robot1 = [q1 q2 q3 q4 q5 q6 q7];
                            coordinate = Manipulator1(tetta_robot1);
                            quaOfPoint = quaOfPoint + 1;
                            Point(quaOfPoint,:) = coordinate(:);
                        end
                    end
                end
            end
        end
    end
end

end
