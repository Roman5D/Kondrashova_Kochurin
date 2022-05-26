%%
% прямая кинематика: (theta(1), theta(2), theta(3)) -> (x0, y0, z0)
% возвращаемый статус: 0=OK, -1=несуществующая позиция
function[boolean, coordinates1, coordinates2] = DirectTask(theta)
e = 0.040*1; %сторона подвижной платформы
f = 0.200*1; %сторона неподвижной платформы
re = 0.100*1; % длина звена подвижной платформы
rf = 0.025*1; % длина звена неподвижной платформы

sin30 = sin(pi/6);
tan30 = tan(pi/6);
tan60 = tan(pi/3);

t = (f-e)*tan30/2;

y1 = -(t + rf*cos(theta(1)));
z1 = -rf*sin(theta(1));

y2 = (t + rf*cos(theta(2)))*sin30;
x2 = y2*tan60;
z2 = -rf*sin(theta(2));

y3 = (t + rf*cos(theta(3)))*sin30;
x3 = -y3*tan60;
z3 = -rf*sin(theta(3));

dnm = (y2-y1)*x3-(y3-y1)*x2;

w1 = y1*y1 + z1*z1;
w2 = x2*x2 + y2*y2 + z2*z2;
w3 = x3*x3 + y3*y3 + z3*z3;

% x = (a1*z + b1)/dnm
a1 = (z2-z1)*(y3-y1)-(z3-z1)*(y2-y1);
b1 = -((w2-w1)*(y3-y1)-(w3-w1)*(y2-y1))/2.0;

% y = (a2*z + b2)/dnm;
a2 = -(z2-z1)*x3+(z3-z1)*x2;
b2 = ((w2-w1)*x3 - (w3-w1)*x2)/2.0;

% a*z^2 + b*z + c = 0
a = a1*a1 + a2*a2 + dnm*dnm;
b = 2*(a1*b1 + a2*(b2-y1*dnm) - z1*dnm*dnm);
c = (b2-y1*dnm)*(b2-y1*dnm) + b1*b1 + dnm*dnm*(z1*z1 - re*re);

% дискриминант
d = b*b - 4.0*a*c;
if (d < 0)
    coordinates1(1) = 0;
    coordinates1(2) = 0;
    coordinates1(3) = 0;
    coordinates2(1) = 0;
    coordinates2(2) = 0;
    coordinates2(3) = 0;
    
    boolean = 0; % несуществующая позиция
else
    z0 = -0.5*(b+sqrt(d))/a;
    x0 = (a1*z0 + b1)/dnm;
    y0 = (a2*z0 + b2)/dnm;
    
    coordinates1(1) = x0;
    coordinates1(2) = y0;
    coordinates1(3) = z0;
    
    z0 = -0.5*(b-sqrt(d))/a;
    x0 = (a1*z0 + b1)/dnm;
    y0 = (a2*z0 + b2)/dnm;
    
    coordinates2(1) = x0;
    coordinates2(2) = y0;
    coordinates2(3) = z0;
    
    boolean = 1; % существующая позиция
end
end

% // обратная кинематика
% // вспомогательная функция, расчет угла theta(1) (в плоскости YZ)
% int delta_calcAngleYZ(float x0, float y0, float z0, float &theta) {
%     float y1 = -0.5 * 0.57735 * f; // f/2 * tg 30
%     y0 -= 0.5 * 0.57735 * e;       // сдвигаем центр к краю
%     // z = a + b*y
%     float a = (x0*x0 + y0*y0 + z0*z0 +rf*rf - re*re - y1*y1)/(2*z0);
%     float b = (y1-y0)/z0;
%     // дискриминант
%     float d = -(a+b*y1)*(a+b*y1)+rf*(b*b*rf+rf);
%     if (d < 0) return -1; // несуществующая точка
%     float yj = (y1 - a*b - sqrt(d))/(b*b + 1); // выбираем внешнюю точку
%     float zj = a + b*yj;
%     theta = 180.0*atan(-zj/(y1 - yj))/pi + ((yj>y1)?180.0:0.0);
%     return 0;
% }

% // обратная кинематика: (x0, y0, z0) -> (theta(1), theta(2), theta(3))
% // возвращаемый статус: 0=OK, -1=несуществующая позиция
% int delta_calcInverse(float x0, float y0, float z0, float &theta(1), float &theta(2), float &theta(3)) {
%     theta(1) = theta(2) = theta(3) = 0;
%     int status = delta_calcAngleYZ(x0, y0, z0, theta(1));
%     if (status == 0) status = delta_calcAngleYZ(x0*cos120 + y0*sin120, y0*cos120-x0*sin120, z0, theta(2));  // rotate coords to +120 deg
%     if (status == 0) status = delta_calcAngleYZ(x0*cos120 - y0*sin120, y0*cos120+x0*sin120, z0, theta(3));  // rotate coords to -120 deg
%     return status;
% }