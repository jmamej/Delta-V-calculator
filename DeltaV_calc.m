fprintf("\n\nThis is orbital velocity/ delta V budget calculator for orbital transfers (Hohmann only).\n");
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
while 1
    syms mode;
    mode = input("Calculate: orbital velocity - 1, delta V - 2, Exit - 3\n");
    if mode == 1
        fprintf("Orbital velocity calculator.\n");
        break;
    elseif mode == 2
        fprintf("Detla V calculator.\n");
        break;
    elseif mode == 3
        fprintf("Exit\n");
        return;
    else
        fprintf("Wrong input!\n\n");
    end
end
%Primary body choice
while 1
    syms x1;
    x1 = input("Chose primary body.\nEarth - 1, Moon - 2, Sun - 3\n");
    if(x1==1)
        R = Re;
        M = Me;
        break;
    elseif(x1==2)
        R = Rm;
        M = Mm;
        break;
    elseif(x1==3)
        R = Rs;
        M = Ms;
        break;
    else
        fprintf("Wrong input!\n\n");
    end
end
mi = M*G;
%orbit parameters setting
while 1
    while 1
        Rp = str2double(input('Input peryapse (in km): ', 's'));
        Rp = R + 1000 * Rp;
        Ra = str2double(input('Input apoapse (in km): ', 's'));
        Ra = R + 1000 * Ra;
        if Rp < R
            fprintf("Colision. Peryapse too low!\n");
        elseif Ra < R
            fprintf("Colision. Apoapse too low!\n");
        elseif Rp > Ra
            fprintf("Apoapse has to be higher than peryapse.\n");
        else 
            break;
        end
    end
    if mode == 1
        while 1
            Rx = str2double(input('Input injection radius (in km): ', 's'));
            Rx = R + 1000 * Rx;
            if Rx > Ra
                fprintf("Injection radius greater than apoapse.\n\n");
            elseif Rx < Rp
                fprintf("Injection radius smaller than peryapse.\n\n");
            else
                break;
            end
        end
    elseif mode == 2
        while 1
            Rx = str2double(input('Input final peryapse/apoapse (in km): ', 's'));
            Rx = R + 1000 * Rx;
            if Rx < 0
                fprintf("Colision.\n\n");
            else
                break;
            end
        end
    end
    %check if input is numerical
    if isnan(Rp) || isnan(Ra) || isnan(Rx)
        fprintf("Wrong input! Numeric values only.\n\n");
    else
        %if input is numerical exit while loop
        break;
    end
end
%establiching moment of injection. 
if mode == 1
    a = (Rp + Ra)./2;
    V = sqrt((2*mi./Rx) - (mi./a));
    if V > 1000
        V = V./1000;
        unitV = " km/s\n";
    else
        unitV = " m/s\n";
    end
    fprintf("Orbital velocity = " + V + unitV);
    fprintf("End of code");
elseif mode == 2
    while 1
       syms y;
        y = input("Chose moment of injection.\nPeryapse - 1, Apoapse - 2\n");
        if y == 1
            a = (Rp + Ra)./2;
            V0 = sqrt((2*mi./Rp) - (mi./a));
            a = (Rp + Rx)./2;
            V1 = sqrt((2*mi./Rp) - (mi./a));
            a = (Rp + Rx)./2;
            V2 = sqrt((2*mi./Rx) - (mi./a));
            a = (Rx + Rx)./2;
            V3 = sqrt((2*mi./Rx) - (mi./a));
            Vf = V1 - V0;
            Vc = V3 - V2;
            break;
        elseif y == 2
            a = (Rp + Ra)./2;
            V0 = sqrt((2*mi./Ra) - (mi./a));
            a = (Ra + Rx)./2;
            V1 = sqrt((2*mi./Ra) - (mi./a));
            a = (Ra + Rx)./2;
            V2 = sqrt((2*mi./Rx) - (mi./a));
            a = (Rx + Rx)./2;
            V3 = sqrt((2*mi./Rx) - (mi./a));
            Vf = V1 - V0;
            Vc = V3 - V2;
            break;
        else
            fprintf("Wrong input! You scrub.\n");
        end  
          
    end
if Vf > 1000
    Vf = Vf./1000;
    unitVf = " km/s\n";
else
    unitVf = " m/s\n";
end
if Vc > 1000
    Vc = Vc./1000;
    unitVc = " km/s\n";
else
    unitVc = " m/s\n";
end
fprintf("Delta V = " + Vf + unitVf);
fprintf("Injection into circular orbit = " + Vc + unitVc);
fprintf("End of code");     
else
    fprintf("Error! Wrong mode!\n");
end
%code updated