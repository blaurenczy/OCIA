function Hd = alphafilter
%ALPHAFILTER Returns a discrete-time filter object.

%
% M-File generated by MATLAB(R) 7.5 and the Signal Processing Toolbox 6.8.
%
% Generated on: 23-Jun-2009 16:23:11
%

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 100;  % Sampling Frequency

Fstop1 = 6;           % First Stopband Frequency
Fpass1 = 7;           % First Passband Frequency
Fpass2 = 14;          % Second Passband Frequency
Fstop2 = 15;          % Second Stopband Frequency
Astop1 = 60;          % First Stopband Attenuation (dB)
Apass  = 1;           % Passband Ripple (dB)
Astop2 = 80;          % Second Stopband Attenuation (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]
