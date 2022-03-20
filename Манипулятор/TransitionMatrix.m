%Рассчет матрицы перехода
function[A] = TransitionMatrix(r, alpha, d, tetta)
a1 = [  cos(tetta) -sin(tetta) 0 0;
        sin(tetta) cos(tetta) 0 0;
        0 0 1 0;
        0 0 0 1];
a2 = [  1 0 0 0;
        0 1 0 0;
        0 0 1 d;
        0 0 0 1];
a3 = [  1 0 0 r;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1];
a4 = [  1 0 0 0;
        0 cos(alpha) -sin(alpha) 0;
        0 sin(alpha) cos(alpha) 0;
        0 0 0 1];
A = a1 * a2 * a3 * a4;
end