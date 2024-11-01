#!/bin/bash
# File: trim.sh

: <<'info'
    description
        Trims all .wav files in the present working directory
        to be 1 second long (the first second of audio)

    required packages
        ffmpeg
info

for file in *.wav; do
    ffmpeg -i "$file" -ss 0 -to 1 "${file%.*}1.wav"
    rm -f "$file"
    mv "${file%.*}1.wav" "$file"
done
