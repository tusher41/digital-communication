clc;
clear all;
close all;

% Input Binary Data
x = [1 0 1 0 1 0 1 0 1];
bp = 0.000001;  % Bit period
disp('Binary Information at transmitter:');
disp(x);

% Representation of Binary Data as Digital Signal
bit = [];
for n = 1:length(x)
    if x(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit = [bit se];
end

t1 = bp/100 : bp/100 : 100*length(x)*(bp/100);
subplot(3, 1, 1);
plot(t1, bit, 'LineWidth', 2.5);
grid on;
axis([0 bp*length(x) -0.5 1.5]);
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Transmitting Information as Digital Signal');

% Binary PSK Modulation
A = 5;
br = 1 / bp;  % Bit rate
f = br * 2;   % Carrier frequency
t2 = bp/99 : bp/99 : bp;  % Time vector per bit
ss = length(t2);  % Samples per bit
m = [];

for i = 1:length(x)
    if x(i) == 1
        y = A * cos(2 * pi * f * t2);       % For bit 1
    else
        y = A * cos(2 * pi * f * t2 + pi);  % For bit 0 -> Phase shifted by π
    end
    m = [m y];  % Append modulated signal
end

t3 = bp/99 : bp/99 : bp*length(x);
subplot(3, 1, 2);
plot(t3, m);
grid on;
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Waveform for Binary PSK Modulation');

% BPSK Demodulation
mn = [];

for n = ss:ss:length(m)
    t = bp/99 : bp/99 : bp;
    y = cos(2 * pi * f * t);  % Reference carrier (for coherent detection)
    mm = y .* m((n - (ss - 1)) : n);  % Multiply with incoming signal
    z = trapz(t, mm);  % Integration
    zz = round(2 * z / bp);  % Decision

    if zz > 0
        a = 1;
    else
        a = 0;
    end
    mn = [mn a];
end

disp('Binary Information at Receiver After PSK Demodulation:');
disp(mn);

% Representation of Received Binary Data as Digital Signal
bit = [];
for n = 1:length(mn)
    if mn(n) == 1
        se = ones(1, 100);
    else
        se = zeros(1, 100);
    end
    bit = [bit se];
end

t4 = bp/100 : bp/100 : 100*length(mn)*(bp/100);
subplot(3, 1, 3);
plot(t4, bit, 'LineWidth', 2.5);
grid on;
axis([0 bp*length(mn) -0.5 1.5]);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Received Information as Digital Signal');
