%Построение манипулятора 3
function[coordinates] = Manipulator3(tetta)
%длины звеньев
l1 = tetta(2);
l2 = tetta(3);
l3 = 1;
l4 = 1;
l5 = 1;
l6 = 1;
l7 = 1;

%Данные для матриц перехода
r = [0 0 0 l4 l5 0 0];
alpha = [0 (-pi/2) (-pi/2) (-pi/2) 0 (pi/2) 0];
d = [l1 0 l2 l3 0 0 l6];
tetta(1) = tetta(1) + 0;
tetta(2) = 0;
tetta(3) = 0;
tetta(4) = tetta(4) + (-pi/2);
tetta(5) = tetta(5);
tetta(6) = tetta(6) + 0;
tetta(7) = tetta(7) + (pi/2);

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

%

end
