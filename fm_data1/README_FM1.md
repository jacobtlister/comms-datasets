# FM Dataset 1

## Contents

This folder contains 100 1 second audio clips of voice data, the script used to crop the audio to 1 second, a MATLAB script for generating the modulated data, and empty directories for the destination of the data.

The audio files are sourced from the following dataset:

<https://github.com/jim-schwoebel/sample_voice_data>

The generated FM signals have the following characteristics:

 - 500kHz sample rate (for the files)
 - 60MHz sample rate (for the signal)
 - 27.88MHz Carrier Frequency
 - 75kHz Frequency Deviation
 - approx. 7.5 kHz bandwidth (for the original audio data)
 - approx. 150 kHz bandwidth (for the FM modulated signal)
 - 0 Degree initial phase
 - -110dBm noise floor (aka power of the noise)

Each output file is 1 second long (500,000 samples). Once the data is generated, all files in the `transmitting` folder will have data being transmitted throughout the entire file and all files in the `dead_air` folder will have no data being transmitted throughout the entire file (so just noise).

## Purpose

This dataset was created for students in a class I am TA-ing to do some basic machine learning work with comms-focu