fprintf("This is orbital velocity/ delta V budget calculator for orbital transfers (Hohmann only).\n");
G = 6.6740831*10^-11;
%%earth data
Me = 5.97219*10^24;
Re = 6.371*10^6;
%moon data
Mm = 7.342*10^22;
Rm = 1.7374*10^6;
%%sun data
Ms = 1.9885*10^30;
Rs = 6.96342*10^8;
syms a;
a = input("Chose primary body.\nEarth - 1, Moon - 2, Sun - 3\n");


%Primary body choice
primaryBodyChoiceFlag = false;
while(primaryBodyChoiceFlag == false)
    syms x;
    x = input("Chose primary body.\nEarth - 1, Moon - 2, Sun - 3\n");
    if(x==1)
        R = Re;
        M = Me;
        primaryBodyChoiceFlag = true;
    elseif(x==2)
        R = Rm;
        M = Mm;
        primaryBodyChoiceFlag = true;
    elseif(x==3)
        R = Rs;
        M = Ms;
        primaryBodyChoiceFlag = true;
    else
        fprintf("Wrong input!\n\n");
    end
end
mi = M*G;

%orbit parameters setting
numberInputFlag = false;
while(numberInputFlag == false)
    Rp = str2double(input('Input peryapse (in km): ', 's'));
    Rp = R + 1000 * Rp;
    Ra = str2double(input('Input apoapse (in km): ', 's'));
    Ra = R + 1000 * Ra;
    Rf = str2double(input('Input final peryapse/apoapse (in km): ', 's'));
    Rf = R + 1000 * Rf;
    %check if input is numerical
    if isnan(Rp) || isnan(Ra) || isnan(Rf)
        fprintf("Wrong input! Numeric values only.\n\n");
    else
        %if imput is numerical exit while loop
        numberInputFlag = true;
    end
end

%establiching moment of injection. 
if Ra == Rp
    Ri = Ra;
else
    injectionFlag = false;
    while injectionFlag == false
        syms y;
        y = input("Chose moment of injection.\nPeryapse - 1, Apoapse - 2\n");
        if y == 1
            Ri = Rp;
            injectionFlag = true;
        elseif y == 2
            Ri = Ra;
            injectionFlag = true;
        else
            fprintf("Wrong input!\n\n");
        end
    end
end

%calculating orbit
a1 = (Rp + Ra)./2;
c1 = (Ra - Rp)./2;
e1 = c1./a1

%determining equations
if(e1 == 0)
    Vp = sqrt(mi./Rp);
    a2 = (Rf+ Rp)./2;
    Vk = sqrt((2*mi./Rp) - (mi./a2));
elseif (e1 > 0 && e1 < 1)
    Vp = sqrt((2*mi./Ri)-(mi./a1));
    a2 = (Rf+ Ri)./2;
    Vk = sqrt((2*mi./Ri) - (mi./a2));
elseif e1 == 1
    fprintf("Parabola.\n");
    return;
end



DV = Vk-Vp;
if DV > 1000
    DV = DV/1000;
    unit = "km/s";
else
     unit = "m/s";
end
fprintf("Delta V = " + DV + " " + unit);
%disp(DV);
fprintf("\nEnd of code!\n");


% accelerationFlag = false;
%     while(accelerationFlag == false)
%         syms z;
%         z = input("Transfer at peryapse - 1, apoapse - 2\n");
%         if(z==1)
%             Vp = sqrt((2*mi./Ri)-(mi./a1));
%             a2 = (Rf+ Ri)./2;
%             Vk = sqrt((2*mi./Ri) - (mi./a2));
%             accelerationFlag = true;
%         elseif(z==2)
%             Vp = sqrt((2*mi./Ri)-(mi./a1));
%             a2 = (Rf+ Ri)./2;
%             Vk = sqrt((2*mi./Ri) - (mi./a2));
%             accelerationFlag = true;
%         else
%             fprintf("Wrong input!\n\n");
%         end
%     end