%Построение манипулятора 1
function[boolean] = PlatformCrash(coordinates1, coordinates2)

%задание размеров и точек платформы
lenght = 0.570;
width = 0.450;
height = 0.200;

numberPoints = 9;
% deltaCoordinates(1) = (coordinates1(1) + coordinates2(1))/(numberPoints - 1);
% deltaCoordinates(2) = (coordinates1(2) + coordinates2(2))/(numberPoints - 1);
% deltaCoordinates(3) = (coordinates1(3) + coordinates2(3))/(numberPoints - 1);
% for i = 1:numberPoints
%    coordinates(i,1) = coordinates1(1) + (i - 1) * deltaCoordinates(1);
%    coordinates(i,2) = coordinates1(2) + (i - 1) * deltaCoordinates(2);
%    coordinates(i,3) = coordinates1(3) + (i - 1) * deltaCoordinates(3);
% end
   
deltaCoordinates = (coordinates1 + coordinates2)/(numberPoints - 1);
for i = 1:numberPoints
   coordinates(i,:) = coordinates1 + (i - 1) * deltaCoordinates;
end

boolean = 0;   
for i = 1:numberPoints
    if((coordinates(i,1) <= (lenght/2)) && (coordinates(i,1) >= (-lenght/2)))
        if(((coordinates(i,2) <= (width/2)) && (coordinates(i,2) >= (-width/2))))
            if(((coordinates(i,3) <= 0) && (coordinates(i,3) >= (-height))))
                boolean = 1; 
                return;
            end
        end
    end
end
end
