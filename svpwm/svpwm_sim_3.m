clear;
# Parameters about the motor
Vdc = 12; % input voltage  of the VSI
f = 1000; % fundamental frequency Hz

# time used for running a cycle
Tcycle = 1 / f; 

# Parameters about the PWM
Fpwm = 1e6; % 10MHz

# time precision 
Tpwm = 1 / Fpwm; % 1us

# lapse time
t = 0 : Tpwm : Tcycle - Tpwm;

# calculate the angle theta
theta = 2 * pi * f * t;

# calculate the sector
sector = fix(theta / pi * 3) + 1;

# plot the time and angle
figure 1;
plot(t, theta, 'r'); 
hold on;
plot(t, sector, 'g');
legend('theta', 'sector');
title('relationship between t and theta, t and sector');

# calculate the Vref 
Vref = 0.577 * Vdc; 

# calculate the T1, T2, T3
Tpwm = 1 / Fpwm;
Tz = Tpwm / 2;
T1 = sqrt(3) * Tz * Vref * sin(sector * pi / 3 - theta) / Vdc;
T2 = sqrt(3) * Tz * Vref * sin(theta - (sector - 1) * pi / 3) / Vdc;
T0 = Tz - T1 - T2;

# plot the relationship between time and T1, T2, T3
figure 2;
plot(t, T1, 'r');
hold on;
plot(t, T2, 'g');
hold on;
plot(t, T0, 'b');
legend('T1', 'T2', 'T0');
title('relationship T1, T2, T0 and t');

# initialize the a, b, c vectors
Ts = 1 / 6 / f; % time spent in a sector

# how many Tpwm in a sector
Npwm = Ts / Tpwm;

# angle changed in a Tpwm period
Cangle = f * Tpwm * 360;

# pwm precision
Ppwm = 0.01;

for  t1 = 0 : Tpwm : Tcycle - Tpwm
  # calculate the angle theta
  theta = 2 * pi * f * t1;
  
  # calculate current pwm period
  period = fix(t1 / Tpwm);

  # calculate the sector
  sector = fix(theta / pi * 3) + 1;
  T1 = sqrt(3) * Tz * Vref * sin(sector * pi / 3 - theta) / Vdc;
  T2 = sqrt(3) * Tz * Vref * sin(theta - (sector - 1) * pi / 3) / Vdc;
  T0 = Tz - T1 - T2;
  
  start_index = period / Ppwm + 1;
  end_index = (period + 1) / Ppwm;
  
  switch(sector)
    case {1}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
    case {2}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
    case {3}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
    case {4}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
    case {5}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
    case {6}
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 0; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 0;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 0; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 0;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T1 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 0; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 0;
      c(end_index - points : end_index) = 1;
      
      start_index = start_index + points + 1;
      end_index = end_index - points - 1;
      points = fix(T0 / 2 / Tpwm / Ppwm);
      a(start_index : start_index + points) = 1; 
      b(start_index : start_index + points) = 1; 
      c(start_index : start_index + points) = 1; 
      a(end_index - points : end_index) = 1;
      b(end_index - points : end_index) = 1;
      c(end_index - points : end_index) = 1;
  end
end

figure 3;
t2 = 0 : Tpwm * Ppwm : Tcycle - Tpwm - Tpwm * Ppwm;
plot(t2, a + 1, 'r');
hold on;
plot(t2, b, 'g');
hold on;
plot(t2, c - 1, 'b');
title('SVPWM');
legend('a', 'b', 'c');

figure 4;
d = a - b;
plot(t2, d);

