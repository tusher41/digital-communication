clc;
clear;

% Input binary data
data = [1 0 1 1 0 0 1];

% Parameters
bit_duration = 1;                % Duration of each bit in seconds
samples_per_bit = 100;          % Number of samples per bit
Fs = samples_per_bit / bit_duration;  % Sampling frequency

% Time vector
t = 0 : 1/Fs : bit_duration * length(data) - 1/Fs;

% Initialize signal
bipolar_rz = zeros(1, length(t));

% Set initial polarity
polarity = 1;

% Generate Bipolar RZ signal
for i = 1:length(data)
    start_idx = (i-1)*samples_per_bit + 1;
    mid_idx   = start_idx + floor(samples_per_bit / 2) - 1;

    if data(i) == 1
        bipolar_rz(start_idx:mid_idx) = polarity;
        polarity = -polarity;  % Alternate the polarity for next '1'
    end
    % data(i) == 0 --> stays 0
end

% Plot the signal
figure;
stairs(t, bipolar_rz, 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Bipolar Return to Zero (RZ) Line Coding');
axis([0 length(data) -1.5 1.5]);
grid on;
