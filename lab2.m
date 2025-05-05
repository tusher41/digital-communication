clc;
clear;

% Input binary data (you can change this)
data = [1 0 1 1 0 0 1];

% Parameters
bit_duration = 1;               % Each bit duration = 1 sec (for simplicity)
samples_per_bit = 100;         % Number of samples per bit
Fs = samples_per_bit / bit_duration;  % Sampling frequency

% Time vector
t = 0 : 1/Fs : bit_duration * length(data) - 1/Fs;

% Initialize polar NRZ signal
polar_nrz = zeros(1, length(t));

% Create polar NRZ signal: 1 -> +1, 0 -> -1
for i = 1:length(data)
    if data(i) == 1
        polar_nrz((i-1)*samples_per_bit + 1 : i*samples_per_bit) = 1;
    else
        polar_nrz((i-1)*samples_per_bit + 1 : i*samples_per_bit) = -1;
    end
end

% Plot the signal
figure;
stairs(t, polar_nrz, 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Polar NRZ Line Coding');
axis([0 length(data) -1.5 1.5]);
grid on;
