clc;
clear;

% Input binary data
data = [1 0 1 1 0 0 1]; % You can change this sequence

% Parameters
bit_duration = 1;              % 1 second per bit
samples_per_bit = 100;         % Number of samples per bit
Fs = samples_per_bit / bit_duration;  % Sampling frequency

% Time vector
t = 0:1/Fs:length(data)*bit_duration;

% Unipolar NRZ signal initialization
nrz_signal = zeros(1, length(t));

% Generate NRZ signal
for i = 1:length(data)
    if data(i) == 1
        nrz_signal((i-1)*samples_per_bit + 1 : i*samples_per_bit) = 1;
    else
        nrz_signal((i-1)*samples_per_bit + 1 : i*samples_per_bit) = 0;
    end
end

% Plot the signal
figure;
stairs(t, nrz_signal, 'LineWidth', 2);
axis([0 length(data) -0.5 1.5]);
xlabel('Time');
ylabel('Amplitude');
title('Unipolar NRZ Line Coding');
grid on;
