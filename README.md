# Delta V calculator (Matlab)
Calculator for orbital velocity and delta V (only Hohman transfer)

Requirements:
- Hohman transfer only
- injection only at apoapse or peryapse


'''Matlab
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
'''
