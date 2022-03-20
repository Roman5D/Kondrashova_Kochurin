%Построение манипулятора 1
function[coordinates] = Manipulator1(tetta)
%длины звеньев
l1 = 0.1;
l2 = 0.4;
l3 = 0.25;
l4 = 0.15;
l5 = 0.15;
l6 = 0.05;

%Данные для матриц перехода
r = [0 l2 l3 l4 l5 0 0];
alpha = [(pi/2) 0 0 0 0 (-pi/2) 0];
d = [l1 0 0 0 0 0 l6];
tetta(1) = tetta(1) + (pi/2);
tetta(2) = tetta(2) + (pi/2);
tetta(3) = tetta(3) + 0;
tetta(4) = tetta(4) + 0;
tetta(5) = tetta(5) + 0;
tetta(6) = tetta(6) + (-pi/2);
tetta(7) = tetta(7) + 0;

%Матрицы перехода
for i = 1:7
    A_temp = TransitionMatrix(r(i), alpha(i), d(i), tetta(i));
    A(:, :, i) = A_temp(:, :);
end

%Рассчёт всех координат

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

%Возвращение всех координат 
coordinates(1, :) = O0(1:3);
coordinates(2:8, :) = O(:, 1:3);

end
