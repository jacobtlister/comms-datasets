% ---------------------------------------------------------------------------
% Jacob Lister
% STAT 490
% FM Data Generation - Task 1
% Task one is for you guys to detect if a given file has
% an FM signal being transmitted. It will either transmit during the
% entire file or for none of it.
% If a signal is being transmitted, it will be a FM signal with:
%     - Frequency Deviation      = 75    kHz
%     - Bandwidth                ~ 150   kHz
%     - Carrier/Center Frequency = 27.88 MHz
%     - Sampling Frequency       = 60    Mhz
%     - Initial Phase            = 0     degrees
% The signals that are being modulated are using voice recordings
% from the following open-souurce dataset:
%     https://github.com/jim-schwoebel/sample_voice_data
% This is not that useful for you guys, but I like keeping track
% of where I get stuff. I took the male and female voices, combined
% them, then trimmed them down to 1 sec long each.
% The modulated data is stored in .bin files. Each file contains
% 500,000 samples (so 500 kHz sample rate for the file) and is stored
% as single-precision floats.
% ---------------------------------------------------------------------------

clear;
clc;

f_dev = 75000;    % Hz
f_c   = 27880000; % Hz
f_s   = 60000000; % Hz

% for i = 1 : 100
%     file  = "/audio/" + num2str(i, "%03d") + ".wav";
%     audio = audioread(file);
%     % lowpass filter to make the signal bandlimited
%     audio = lowpass(audio, 7500, length(audio));
%     % upconvert the audio to 500kHz (for better spectral resolution)
%     audio = interp(audio, 250);
%     N     = length(audio);
% 
%     audio_fm       = fmmod(audio, f_c, f_s, f_dev);
%     audio_fm       = (10^(-5.5) / mean(audio_fm .^ 2)) * audio_fm;
%     noise          = 10^(-7) * randn(N, 1);
%     audio_fm_noisy = audio_fm + noise;
%     dead_air_noisy = 10^(-7) * randn(N, 1);
% 
%     % should be able to use this stack overflow page to get the data from these files
%     % https://stackoverflow.com/a/33320416
%     transmit_file  = fopen("./data/transmitting/transmitting_" + num2str(i, "%03d") + ".bin", "w");
%     fwrite(transmit_file, audio_fm_noisy, "float");
%     fclose(transmit_file);
%     disp("Wrote " + num2str(i) + "/100 transmitting data files")
%     dead_air_file  = fopen("./data/dead_air/dead_air_" + num2str(i, "%03d") + ".bin", "w");
%     fwrite(dead_air_file, dead_air_noisy, "float");
%     fclose(dead_air_file);
%     disp("Wrote " + num2str(i) + "/100 dead air data files")
% end

% test plot of 1 audio file and it's FM modulated version
% select all the lines and ctrl + r to comment them out
% or ctrl + t to uncomment them

file  = "/audio/" + num2str(1, "%03d") + ".wav";
audio = audioread(file);
% lowpass filter to make the signal bandlimited
audio = lowpass(audio, 7500, length(audio));
% upconvert the audio to 500kHz (for better spectrum resolution)
audio = interp(audio, 250);
N     = length(audio);

audio_fm       = fmmod(audio, f_c, f_s, f_dev);
% scale down audio_fm so the power is something resonable
% you would get at a reciever
audio_fm       = (10^(-5.5) / mean(audio_fm .^ 2)) * audio_fm;
noise          = 10^(-7) * randn(N, 1);
audio_fm_noisy = audio_fm + noise;
snr(audio_fm, noise)

audio_fft_fm       = 20 * log10(abs(fft(audio_fm)));
audio_fft_fm       = audio_fft_fm(1 : N / 2);
audio_fft_fm_noisy = 20 * log10(abs(fft(audio_fm_noisy)));
audio_fft_fm_noisy = audio_fft_fm_noisy(1 : N / 2);

% frequency scaling for the axes
f = (0 : N - 1) * f_s / N;
f = f(1 : N / 2)';

subplot(1, 2, 1)
plot(f(1666668 : end), audio_fft_fm(1666668 : end))

xlabel("Hertz [Hz]")
xticks([27700000 27750000 27800000 27850000 27900000 27950000 28000000 28050000])
xlim([27680000 28080000])
ylabel("Magnitude [dB]")
yticks([-110 -90 -70 -50 -30 -10 10 30])
ylim([-110 30])
title("Spectrum of FM Modulated Audio")

subplot(1, 2, 2)
plot(f(1666668 : end), audio_fft_fm_noisy(1666668 : end))

xlabel("Hertz [Hz]")
xticks([27700000 27750000 27800000 27850000 27900000 27950000 28000000 28050000])
xlim([27680000 28080000])
ylabel("Magnitude [dB]")
yticks([-110 -90 -70 -50 -30 -10 10 30])
ylim([-110 30])
title("Spectrum of Noisy FM Modulated Audio")

set(gcf, 'Position',  [100, 300, 1200, 550]);