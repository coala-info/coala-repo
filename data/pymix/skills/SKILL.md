---
name: pymix
description: The `pymix` skill (based on `pymixconsole`) provides a headless multitrack mixing environment.
homepage: https://github.com/csteinmetz1/pymixconsole
---

# pymix

## Overview
The `pymix` skill (based on `pymixconsole`) provides a headless multitrack mixing environment. It allows you to simulate a professional mixing console programmatically, applying complex signal chains to multiple audio tracks and summing them into a stereo output. Use this skill to automate the application of gain, panning, equalization, and dynamic processing to audio data represented as NumPy arrays.

## Core Workflow
To use the mixing console, follow this block-based processing pattern:

1.  **Initialization**: Create a console instance with specific audio parameters.
2.  **Data Preparation**: Ensure input audio is a NumPy array of shape `[samples, channels]`.
3.  **Processing Loop**: Iterate through the audio in blocks to manage memory and processing state.
4.  **Output**: Collect the returned stereo blocks into a final array.

```python
import numpy as np
import pymixconsole as pymc

# 1. Setup
rate = 44100
block_size = 512
num_tracks = 8
console = pymc.Console(block_size=block_size, sample_rate=rate, num_channels=num_tracks)

# 2. Process block-by-block
# input_data shape: (samples, num_tracks)
output = np.empty(shape=(input_data.shape[0], 2))

for i in range(input_data.shape[0] // block_size):
    start = i * block_size
    stop = start + block_size
    output[start:stop, :] = console.process_block(input_data[start:stop, :])
```

## Processor Management
Each channel in the console has a default chain: **Gain -> Polarity -> EQ -> Compressor -> Fader -> Panner**.

### Accessing and Modifying Parameters
Parameters are accessed through the channel's processor list.
```python
# Change the fader (post-gain) on the first channel
console.channels[0].processor.get("gain").parameters.gain.value = -6.0

# Adjust EQ settings
eq = console.channels[0].processor.get("equaliser")
eq.parameters.high_shelf_freq.value = 8000.0
eq.parameters.high_shelf_gain.value = 3.5
```

### Adding Custom Processors
You can extend the default chain by adding processors to the `core-processors` group.
```python
# Add a distortion effect to channel 2
dist = pymc.processors.Distortion(name="drive")
console.channels[2].processors.add(dist)

# Add a second compressor
comp2 = pymc.processors.Compressor(name="glue")
console.channels[2].processors.add(comp2)
```

## Processor Reference
| Processor | Key Parameters | Range/Notes |
| :--- | :--- | :--- |
| **Gain** | `gain` | -80.0 to 24.0 dB |
| **Panner** | `pan` | 0.0 (Left) to 1.0 (Right), Default 0.5 |
| **Equalizer** | `low_shelf_freq`, `first_band_gain`, `high_shelf_freq` | 5-band (Low/High shelf + 3 peaking) |
| **Compressor** | `threshold`, `attack_time`, `release_time`, `ratio` | Threshold: -80 to 0 dB |
| **Reverb** | `room_size`, `damping`, `dry_mix`, `wet_mix` | Algorithmic or Convolutional |
| **Delay** | `delay` (samples), `feedback`, `wet_mix` | Sample-accurate delay |

## Expert Tips
- **Master Bus**: The console includes a master bus that sums all channels. You can apply global processing (like a master limiter or EQ) by accessing `console.master`.
- **Effect Busses**: By default, the console initializes two effect busses (typically for Reverb and Delay). Use these for parallel processing across multiple tracks.
- **State Reset**: If processing multiple unrelated files with the same console instance, call `console.reset()` to clear the internal state (buffers) of processors like delays and compressors.
- **Data Types**: Use `float32` for audio data arrays to maintain compatibility with the default processor precision and optimize performance.

## Reference documentation
- [pymixconsole Main README](./references/github_com_csteinmetz1_pymixconsole.md)