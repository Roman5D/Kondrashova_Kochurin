%���������� ������������ 1
function[coordinates] = Manipulator1_workspace(state)

%������� �������� ������� ����������
q_max = [
        180     * (2*pi/360)
        90      * (2*pi/360)
        150     * (2*pi/360)
        150     * (2*pi/360)
        150     * (2*pi/360)
        150     * (2*pi/360)
        180     * (2*pi/360)
        ];

q_min = [
        -180    * (2*pi/360)
        -90     * (2*pi/360)
        -150    * (2*pi/360)
        -150    * (2*pi/360)
        -150    * (2*pi/360)
        -150    * (2*pi/360)
        -180    * (2*pi/360)
        ];

%��������� �� .. �����������
if state == 1
    numberInterval = [
                    12
                    9
                    10
                    10
                    10
                    10
                ];
elseif state == 2
    numberInterval = [
                    36
                    18
                    30
                    30
                    30
                    30
                ];
else
    numberInterval = [
                    12
                    9
                    10
                    10
                    10
                    10
                ];
end
        
numberPointsAll = numberInterval(1)*(numberInterval(2)+1)*(numberInterval(3)+1)*(numberInterval(4)+1)*(numberInterval(5)+1)*(numberInterval(6)+1);

q_delta = [
        (q_max(1) - q_min(1)) / numberInterval(1)
        (q_max(2) - q_min(2)) / numberInterval(2)
        (q_max(3) - q_min(3)) / numberInterval(3)
        (q_max(4) - q_min(4)) / numberInterval(4)
        (q_max(5) - q_min(5)) / numberInterval(5)
        (q_max(6) - q_min(6)) / numberInterval(6)
            ];

%���������� ���� �����
quaOfPoint = 0;
coordinates = zeros(numberPointsAll, 3);

l1 = 0.1;
l2 = 0.4;
l3 = 0.25;
l4 = 0.15;
l5 = 0.15;
l6 = 0.05;

r(7)        = 0;
alpha(7)    = 0;
d(7)        = l6;
tetta(7)    = 0 + 0;
A(:, :, 7) = TransitionMatrix(r(7), alpha(7), d(7), tetta(7));
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
        if (PlatformCrash(tempCoordinates(:,1), tempCoordinates(:,2)) == 0)
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
                if (PlatformCrash(tempCoordinates(:,2), tempCoordinates(:,3)) == 0)
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
                        if (PlatformCrash(tempCoordinates(:,3), tempCoordinates(:,4)) == 0)
                            for counter5 = 0:numberInterval(5)
                                q5 = q_min(5) + q_delta(5) * counter5;
                                r(5)        = l5;
                                alpha(5)    = 0;
                                d(5)        = 0;
                                tetta(5)    = q5 + 0;
                                A(:, :, 5) = TransitionMatrix(r(5), alpha(5), d(5), tetta(5));
                                A0n(:, :, 5) = A0n(:, :, 4) * A(:, :, 5);
                                temp_tempCoordinates = (A0n(:, :, 5) * [0 0 0 1]')';
                                tempCoordinates(:,5) = temp_tempCoordinates(1:3);

                                if (PlatformCrash(tempCoordinates(:,4), tempCoordinates(:,5)) == 0)
                                    for counter6 = 0:numberInterval(6)
                                        q6 = q_min(6) + q_delta(6) * counter6;
                                        r(6)        = 0;
                                        alpha(6)    = (-pi/2);
                                        d(6)        = 0;
                                        tetta(6)    = q6 + (-pi/2);
                                        A(:, :, 6) = TransitionMatrix(r(6), alpha(6), d(6), tetta(6));
                                        A0n(:, :, 6) = A0n(:, :, 5) * A(:, :, 6);
                                        tempCoordinates(:,6) = tempCoordinates(:,5);
                                        A0n(:, :, 7) = A0n(:, :, 6) * A(:, :, 7);
                                        temp_tempCoordinates = (A0n(:, :, 7) * [0 0 0 1]')';
                                        tempCoordinates(:,7) = temp_tempCoordinates(1:3);

                                        if (PlatformCrash(tempCoordinates(:,6), tempCoordinates(:,7)) == 0)
                                            quaOfPoint = quaOfPoint + 1;
                                            coordinates(quaOfPoint, :) = tempCoordinates(:,7);          
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end 
    end
end

%������������ ������� �����
coordinates = coordinates(1:quaOfPoint,:);

end
