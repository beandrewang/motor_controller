# prepar the input
Vdc = 12;  # 12V input voltage

# determine desired space vector Vref and angle a, Tz
# Vamax = 2/3 * Vdc * cos(pi/6) = 0.577 * Vdc
# Tz, the duration  of the PWM
Vref = 0.577 * Vdc; 
alpha = 0 : 360;
Tz = 1;

# determine which sector current in, the angle in current sector
angle = alpha / 360 * 2 * pi;
n = fix((angle / pi * 3)) + 1;
#a = angle - (n - 1) * pi / 3;  # angle in the current sector n < pi / 3
a = angle;

# calculate the T1, T2, T3
T1 = sqrt(3) * Tz * Vref * sin(n * pi / 3 - a) / Vdc;
T2 = sqrt(3) * Tz * Vref * sin(a - (n - 1) * pi / 3) / Vdc;
T0 = Tz - T1 - T2;

# plot the curve of alpha and T1, T2, T0
figure 1;
plot(alpha, T1, 'r');
hold on;
plot(alpha, T2, 'g');
hold on;
plot(alpha, T0, 'b');
hold on;
plot(alpha, n, 'k');
hold on
plot(alpha, a, 'y');

# generate symmetrical PWM 

alpha = 60;
# determine which sector current in, the angle in current sector
angle = alpha / 360 * 2 * pi;
n = fix((angle / pi * 3)) + 1;
#a = angle - (n - 1) * pi / 3;  # angle in the current sector n < pi / 3
a = angle;

# calculate the T1, T2, T3
T1 = sqrt(3) * Tz * Vref * sin(n * pi / 3 - a) / Vdc
T2 = sqrt(3) * Tz * Vref * sin(a - (n - 1) * pi / 3) / Vdc
T0 = Tz - T1 - T2

switch n
  case {1}  #sector 1
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T1 || t >= 2 * Tz - T0 / 2 - T1 )
        S1 = 1;
        S3 = 0;
        S5 = 0;
        Va = 2/3 * Vdc;
        Vb = -1/3 * Vdc;
        Vc = -1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 1;
        S3 = 1;
        S5 = 0;
        Va = 1/3 * Vdc;
        Vb = 1/3 * Vdc;
        Vc = -2/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
  case {2}  #sector 2
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T2 || t >= 2 * Tz - T0 / 2 - T2 )
        S1 = 0;
        S3 = 1;
        S5 = 0;
        Va = -1/3 * Vdc;
        Vb = 2/3 * Vdc;
        Vc = -1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 1;
        S3 = 1;
        S5 = 0;
        Va = 1/3 * Vdc;
        Vb = 1/3 * Vdc;
        Vc = -2/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
  case {3}
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T1 || t >= 2 * Tz - T0 / 2 - T1 )
        S1 = 0;
        S3 = 1;
        S5 = 0;
        Va = -1/3 * Vdc;
        Vb = 2/3 * Vdc;
        Vc = -1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 0;
        S3 = 1;
        S5 = 1;
        Va = -2/3 * Vdc;
        Vb = 1/3 * Vdc;
        Vc = 1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
  case {4}
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T2 || t >= 2 * Tz - T0 / 2 - T2 )
        S1 = 0;
        S3 = 0;
        S5 = 1;
        Va = -1/3 * Vdc;
        Vb = -1/3 * Vdc;
        Vc = 2/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 0;
        S3 = 1;
        S5 = 1;
        Va = -2/3 * Vdc;
        Vb = 1/3 * Vdc;
        Vc = 1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
  case {5}
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T1 || t >= 2 * Tz - T0 / 2 - T1 )
        S1 = 0;
        S3 = 0;
        S5 = 1;
        Va = -1/3 * Vdc;
        Vb = -1/3 * Vdc;
        Vc = 2/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 1;
        S3 = 0;
        S5 = 1;
        Va = 1/3 * Vdc;
        Vb = -2/3 * Vdc;
        Vc = 1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
  case {6}
    for t = 0 : 0.01 : 2 * Tz;
      if(t <= T0 / 2 || t >= 2 * Tz - T0)
        S1 = 0;
        S3 = 0;
        S5 = 0;
        Va = 0;
        Vb = 0;
        Vc = 0;
      elseif(t <= T0 / 2 + T2 || t >= 2 * Tz - T0 / 2 - T2 )
        S1 = 1;
        S3 = 0;
        S5 = 0;
        Va = 2/3 * Vdc;
        Vb = -1/3 * Vdc;
        Vc = -1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 || t >= 2 * Tz - T0 / 2 - T1 - T2)
        S1 = 1;
        S3 = 0;
        S5 = 1;
        Va = 1/3 * Vdc;
        Vb = -2/3 * Vdc;
        Vc = 1/3 * Vdc;
      elseif(t <= T0 / 2 + T1 + T2 + T0 / 2 || t >= Tz)
        S1 = 1;
        S3 = 1; 
        S5 = 1;
        Va = 0;
        Vb = 0;
        Vc = 0;
      end
    figure 2;
    plot(t, S1 + 2, 'r');
    hold on;
    plot(t, S3 + 1, 'g');
    hold on;
    plot(t, S5, 'b');
    hold on;
    figure 3;
    plot(t, Va, '*r');
    hold on;
    plot(t, Vb, '*g');
    hold on;
    plot(t, Vc, '*b');
    hold on;
    end
end
