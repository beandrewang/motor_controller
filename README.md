# motor_controller

# svpwm
It was writtern in Octave and you also can run it in Matlab. By using the Park Transform and the inverse transform to tranform the motor coordinate from the x,y,z space to the D-Q plane coordinate. 

__svpwm_sim.m__ - a C style structure of the logistic.  
__svpwm_sim_1.m__ - calculate the duty cycle of the 3 phase swicher, and generate the PWM curve for the specified angle theta.  
__svpwm_sim_2.m__ - genearte the pwm curve in a cycle of the motor runs, the rotate angle is from (0, 2pi), calculate the real-time duty cycles and also got the phase voltages Va, Vb and Vc via the inverse transform. 
