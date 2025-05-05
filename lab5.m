clc;
clear;

% Input binary data
data = [1 0 1 1 0 0 1];

% Parameters
bit_duration = 1;                  % Bit duration in seconds
samples_per_bit = 100;            % Samples per bit
Fs = samples_per_bit / bit_duration;  % Sampling frequency

% Time vector
t = 0 : 1/Fs : bit_duration * length(data) - 1/Fs;

% Initialize signal
manchester = zeros(1, length(t));

% Generate Manchester Code
for i = 1:length(data)
    start_idx = (i-1)*samples_per_bit + 1;
    mid_idx = start_idx + floor(samples_per_bit/2) - 1;
    end_idx = i*samples_per_bit;

    if data(i) == 1
        % 1 = High-to-Low
        manchester(start_idx:mid_idx) = 1;
        manchester(mid_idx+1:end_idx) = -1;
    else
        % 0 = Low-to-High
        manchester(start_idx:mid_idx) = -1;
        manchester(mid_idx+1:end_idx) = 1;
    end
end

% Plotting the waveform
figure;
stairs(t, manchester, 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Manchester Line Coding (Split Phase)');
axis([0 length(data) -1.5 1.5]);
grid on;
