---
name: r-music
description: The r-music tool provides functions for music theory experimentation in R, including building chords and scales, visualizing notes, and playing audio. Use when user asks to build musical structures, visualize notes on an ASCII piano, plot waveforms, or perform audio playback and frequency conversions.
homepage: https://cloud.r-project.org/web/packages/music/index.html
---

# r-music

name: r-music
description: Use the 'music' R package to learn and experiment with music theory. This skill helps with building chords, scales, and chord progressions, visualizing notes on an ASCII piano, plotting waveforms, and playing audio. Use this skill when a user needs to programmatically explore 12-note equal temperament (12-ET) or custom tunings in R.

# r-music

## Overview
The `music` package is a tool for music theory experimentation in R. It allows users to construct musical structures (chords, scales), visualize them via console-based ASCII piano plots or waveform graphics, and perform simple audio playback.

## Installation
To install the package from CRAN:
```r
install.packages("music")
```

## Core Workflows

### Building Scales and Chords
Use `build_scale` and `build_chord` to generate note sequences.
```r
library(music)

# Build a C Major scale
c_major <- build_scale(note = "C", major = TRUE)

# Build a G7 chord
g7_chord <- build_chord(note = "G", chord = "7")
```

### Visualization
The package provides two primary ways to visualize music:
1.  **ASCII Piano Plot**: Use `cplot` to see notes on a keyboard in the console.
2.  **Waveform Plot**: Use `mplot` to see the time-series waveform of a note or chord.

```r
# Visualize a D minor chord on the piano
d_minor <- build_chord("D", "m")
cplot(d_minor)

# Plot the waveform of an A4 note
mplot("A4")
```

### Audio Playback
If the `audio` package is installed, you can play notes and chords directly.
```r
# Play a sequence of notes
play_notes(c("C4", "E4", "G4", "C5"))

# Play a specific chord
play_chord(build_chord("A", "maj"))
```

### Note and Frequency Conversion
Convert between note names and frequencies (Hz).
```r
# Get frequency of A4
note_to_freq("A4")

# Find the closest note to a frequency
freq_to_note(440)
```

## Tips and Best Practices
- **Note Notation**: Use standard scientific pitch notation (e.g., "C4" for middle C).
- **Tuning**: The default is 12-ET (12-note equal temperament), but you can define custom tunings using the `tuning` parameter in building functions.
- **Vectorization**: Many functions accept vectors of notes, making it easy to process entire melodies or progressions.

## Reference documentation
- [README.md](./references/README.md)