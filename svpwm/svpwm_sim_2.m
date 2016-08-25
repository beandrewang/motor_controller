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

alpha = 20;
# determine which sector current in, the angle in current sector
angle = alpha / 360 * 2 * pi;
n = fix((angle / pi * 3)) + 1; # get the current sector
#a = angle - (n - 1) * pi / 3;  # angle in the current sector n < pi / 3
a = angle;

# calculate the T1, T2, T3
T1 = sqrt(3) * Tz * Vref * sin(n * pi / 3 - a) / Vdc
T2 = sqrt(3) * Tz * Vref * sin(a - (n - 1) * pi / 3) / Vdc
T0 = Tz - T1 - T2

Fs = 100;

t = 0 : 1/Fs : 2 * Tz - 1/Fs;
a = zeros(1, 2 * Tz * Fs);
b = zeros(1, 2 * Tz * Fs);
c = zeros(1, 2 * Tz * Fs);


switch n
  case {1}  #sector 1
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 1;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
  case {2}  # sector 2
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 1;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
  case {3}  # sector 3
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 1;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    b(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
  case {4}  #sector 4
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    b(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
  case {5}  #sector 5
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 0;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T1) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    b(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T1) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    c(fix((T0 / 2 + T1) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
  case {6}  #sector 6
    a(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    b(1 : fix(T0 / 2 * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    b(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    c(fix((2 * Tz - T0 / 2) * Fs + 1) : fix(2 * Tz * Fs)) = 0;
    
    a(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 1;
    b(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    c(fix(T0 / 2 * Fs + 1) : fix((T0 / 2 + T2) * Fs + 1)) = 0;
    a(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2) * Fs + 1)) = 0;
    
    a(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 0;
    c(fix((T0 / 2 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 0;
    c(fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T2) * Fs + 1)) = 1;
    
    a(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    b(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    c(fix((T0 / 2 + T1 + T2) * Fs + 1) : fix((T0 / 2 + T1 + T2 + T0 / 2) * Fs + 1)) = 1;
    a(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    b(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
    c(fix((2 * Tz - T0 / 2 - T1 - T2 - T0 / 2) * Fs + 1) : fix((2 * Tz - T0 / 2 - T1 - T2) * Fs + 1)) = 1;
end

# plot the curve in a period
figure 2;
plot(t, a + 1, 'r');
hold on;
plot(t, b, 'g');
hold on;
plot(t, c - 1, 'b');

# plot a periodic PWM curve
N = 20;
T = 0 : 1/Fs :  2 * N * Tz - 1/Fs;
for n = 0 : N - 1
  A(n * 2 * Tz * Fs + 1  : (n + 1) * 2 * Tz * Fs) = a;
  B(n * 2 * Tz * Fs + 1  : (n + 1) * 2 * Tz * Fs) = b;
  C(n * 2 * Tz * Fs + 1  : (n + 1) * 2 * Tz * Fs) = c;
end

figure 3;
plot(T, A + 1, 'r');
hold on;
plot(T, B, 'g');
hold on;
plot(T, C - 1, 'b');
