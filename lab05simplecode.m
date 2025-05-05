clc;
clear;

data = [1 0 1 1 0 0 1];   % Input data
bit_duration = 1;
samples_per_bit = 100;
Fs = samples_per_bit / bit_duration;

% Time vector
t = 0 : 1/Fs : length(data)*bit_duration - 1/Fs;

% Expand data: each bit to two halves (split)
data_expanded = repelem(data, 2);  % Each bit will now be split in half

% Manchester logic: XOR with clock (101010...)
clock = repmat([1 0], 1, length(data));
manchester = xor(data_expanded, clock);  % XOR gives Manchester code

% Convert 0 -> -1 for plotting
manchester = 2*manchester - 1;

% Expand each value into samples
manchester_signal = repelem(manchester, samples_per_bit/2);

% Plot
stairs(t, manchester_signal, 'LineWidth', 2);
xlabel('Time');
ylabel('Amplitude');
title('Manchester Encoding (XOR method)');
axis([0 length(data) -1.5 1.5]);
grid on;
