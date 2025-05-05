clc;
clear all;
close all;

% Binary information at transmitter
x = [1 1 0 1 0 1];
bp = 0.000001;  % bit period
disp('Binary information at transmitter');
disp(x);

% Representation of Transmitting binary information as digital signal
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
title('Transmitting information as digital signal');

% Binary FSK Modulation
A = 5;  % Amplitude
br = 1 / bp;  % bit rate
f1 = br * 8;  % Frequency for bit 1
f2 = br * 2;  % Frequency for bit 0
t2 = bp/99 : bp/99 : bp;
ss = length(t2);
m = [];

for i = 1:length(x)
    if x(i) == 1
        y = A * cos(2 * pi * f1 * t2);  % Modulation for bit 1
    else
        y = A * cos(2 * pi * f2 * t2);  % Modulation for bit 0
    end
    m = [m y];  % Append modulated signal
end

t3 = bp/99 : bp/99 : bp * length(x);
subplot(3, 1, 2);
plot(t3, m);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Waveform for binary FSK modulation corresponding binary information');

% Binary FSK Demodulation
mn = [];
for n = ss : ss : length(m)
    t = bp/99 : bp/99 : bp;
    y1 = cos(2 * pi * f1 * t);  % Carrier for bit 1
    y2 = cos(2 * pi * f2 * t);  % Carrier for bit 0
    mm = y1 .* m((n - (ss - 1)) : n);  % Multiply with modulated signal
    mmm = y2 .* m((n - (ss - 1)) : n);  % Multiply with modulated signal

    t4 = bp/99 : bp/99 : bp;
    z1 = trapz(t4, mm);  % Integration for f1
    z2 = trapz(t4, mmm);  % Integration for f2
    zz1 = round(2 * z1 / bp);  % Decision threshold for f1
    zz2 = round(2 * z2 / bp);  % Decision threshold for f2

    if zz1 > A / 2  % Logic level decision for bit 1
        a = 1;
    elseif zz2 > A / 2  % Logic level decision for bit 0
        a = 0;
    end
    mn = [mn a];
end

disp('Binary information at Receiver');
disp(mn);

% Representation of Binary Information as digital signal
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
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Received Information as digital signal after binary FSK demodulation');
