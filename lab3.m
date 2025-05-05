clc;
clear;

% Input binary data
data = [1 0 1 1 0 0 1];

% Parameters
bit_duration = 1;               % Bit duration in seconds
samples_per_bit = 100;         % Number of samples per bit
Fs = samples_per_bit / bit_duration;  % Sampling frequency

% Time vector
t = 0 : 1/Fs : bit_duration * length(data) - 1/Fs;

% Initialize signal
rz_signal = zeros(1, length(t));

% Generate Unipolar RZ signal
for i = 1:length(data)
    if data(i) == 1
        % Half-bit duration high, rest low
        mid = (i-1)*samples_per_bit + floor(samples_per_bit/2);
        rz_signal((i-1)*samples_per_bit + 1 : mid) = 1;
    end
    % If data(i) == 0, it stays 0 (already initialized)
end

% Plotting the signal
figure;
stairs(t, rz_signal, 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Unipolar Return to Zero (RZ) Line Coding');
axis([0 length(data) -0.5 1.5]);
grid on;
