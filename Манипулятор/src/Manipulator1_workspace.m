%ѕостроение манипул€тора 1
function[coordinates] = Manipulator1_workspace(state)

%задание пределов входных переменных
q_max = [
        180     * (2*pi/360)
        90      * (2*pi/360)
        90      * (2*pi/360)
        90      * (2*pi/360)
        90      * (2*pi/360)
        180     * (2*pi/360)
        ];

q_min = [
        -180    * (2*pi/360)
        -90     * (2*pi/360)
        -90     * (2*pi/360)
        -90     * (2*pi/360)
        -90     * (2*pi/360)
        -180    * (2*pi/360)
        ];

%разделить на .. промежутков
numberInterval = [
                24
                18
                10
                10
                10
            ];
        
numberPointsAll = numberInterval(1)*(numberInterval(2)+1)*(numberInterval(3)+1)*(numberInterval(4)+1)*(numberInterval(5)+1);

q_delta = [
        (q_max(1) - q_min(1)) / numberInterval(1)
        (q_max(2) - q_min(2)) / numberInterval(2)
        (q_max(3) - q_min(3)) / numberInterval(3)
        (q_max(4) - q_min(4)) / numberInterval(4)
        (q_max(5) - q_min(5)) / numberInterval(5)
            ];

%вычисление пол€ точек
quaOfPoint = 0;
coordinates = zeros(numberPointsAll, 3);

l1 = 0.20;
l2 = 0.40;
l3 = 0.25;
l4 = 0.20;
l5 = 0.15;

r(6)        = 0;
alpha(6)    = 0;
d(6)        = l5;
tetta(6)    = 0 + 0;
A(:, :, 6) = TransitionMatrix(r(6), alpha(6), d(6), tetta(6));
tempCoordinates(:,1) = [0 0 0];
for counter1 = 1:numberInterval(1)
    q1 = q_min(1) + q_delta(1) * counter1;
    
    r(1)        = 0;
    alpha(1)    = (pi/2);
    d(1)        = l1;
    tetta(1)    = q1 + (pi/2);
    A(:, :, 1) = TransitionMatrix(r(1), alpha(1), d(1), tetta(1));
    A0n(:, :, 1) = A(:, :, 1);
    
    temp_tempCoordinates = (A0n(:, :, 1) * [0 0 0 1]')';
    tempCoordinates(:,1) = temp_tempCoordinates(1:3);
    
    temp(1) = q1 * (360 / (2*pi));
    for counter2 = 0:numberInterval(2)
        q2 = q_min(2) + q_delta(2) * counter2;
        
        r(2)        = l2;
        alpha(2)    = 0;
        d(2)        = 0;
        tetta(2)    = q2 + (pi/2);
        A(:, :, 2) = TransitionMatrix(r(2), alpha(2), d(2), tetta(2));
        A0n(:, :, 2) = A0n(:, :, 1) * A(:, :, 2);
        
        temp_tempCoordinates = (A0n(:, :, 2) * [0 0 0 1]')';
        tempCoordinates(:,2) = temp_tempCoordinates(1:3);
        
        temp(2) = q2 * (360 / (2*pi));
        if ((PlatformCrash(tempCoordinates(:,1), tempCoordinates(:,2)) == 0) || (state == 0))
            for counter3 = 0:numberInterval(3)
                q3 = q_min(3) + q_delta(3) * counter3;
                
                r(3)        = l3;
                alpha(3)    = 0;
                d(3)        = 0;
                tetta(3)    = q3 + 0;
                A(:, :, 3) = TransitionMatrix(r(3), alpha(3), d(3), tetta(3));
                A0n(:, :, 3) = A0n(:, :, 2) * A(:, :, 3);

                temp_tempCoordinates = (A0n(:, :, 3) * [0 0 0 1]')';
                tempCoordinates(:,3) = temp_tempCoordinates(1:3);

                temp(3) = q3 * (360 / (2*pi));
                temp
                if ((PlatformCrash(tempCoordinates(:,2), tempCoordinates(:,3)) == 0) || (state == 0))
                    for counter4 = 0:numberInterval(4)
                        q4 = q_min(4) + q_delta(4) * counter4;
                        r(4)        = l4;
                        alpha(4)    = 0;
                        d(4)        = 0;
                        tetta(4)    = q4 + 0;
                        A(:, :, 4) = TransitionMatrix(r(4), alpha(4), d(4), tetta(4));
                        A0n(:, :, 4) = A0n(:, :, 3) * A(:, :, 4);
                        temp_tempCoordinates = (A0n(:, :, 4) * [0 0 0 1]')';
                        tempCoordinates(:,4) = temp_tempCoordinates(1:3);

                        if ((PlatformCrash(tempCoordinates(:,3), tempCoordinates(:,4)) == 0) || (state == 0))
                            for counter5 = 0:numberInterval(5)
                                q5 = q_min(5) + q_delta(5) * counter5;
                                r(5)        = 0;
                                alpha(5)    = (-pi/2);
                                d(5)        = 0;
                                tetta(5)    = q5 + (-pi/2);
                                A(:, :, 5) = TransitionMatrix(r(5), alpha(5), d(5), tetta(5));
                                A0n(:, :, 5) = A0n(:, :, 4) * A(:, :, 5);
                                tempCoordinates(:,5) = tempCoordinates(:,4);
                                A0n(:, :, 6) = A0n(:, :, 5) * A(:, :, 6);
                                temp_tempCoordinates = (A0n(:, :, 6) * [0 0 0 1]')';
                                tempCoordinates(:,6) = temp_tempCoordinates(1:3);

                                if ((PlatformCrash(tempCoordinates(:,5), tempCoordinates(:,6)) == 0) || (state == 0))
                                    quaOfPoint = quaOfPoint + 1;
                                    coordinates(quaOfPoint, :) = tempCoordinates(:,6);          
                                end
                            end
                        end
                    end
                end
            end
        end 
    end
end

%отбрасывание нулевых точек
coordinates = coordinates(1:quaOfPoint,:);

end
