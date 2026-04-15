---
name: cava
description: CAVA is a bar spectrum audio visualizer that provides responsive music visualization in the terminal or via SDL. Use when user asks to install the visualizer, configure audio capture methods like Pipewire or PulseAudio, or customize visual output settings such as colors and smoothing.
homepage: https://github.com/karlstav/cava
metadata:
  docker_image: "biocontainers/cava:v1.1.1_cv2"
---

# cava

## Overview
CAVA is a bar spectrum audio visualizer designed specifically for aesthetic and responsive music visualization rather than scientific analysis. It functions primarily in the terminal but also supports desktop output via SDL. This skill assists in setting up the visualizer, selecting the correct audio input source for your operating system, and fine-tuning the visual output through its configuration system.

## Installation Quick Start
CAVA is available in most major package managers:
- **Linux**: `sudo apt install cava` (Debian/Ubuntu), `pacman -S cava` (Arch), `dnf install cava` (Fedora).
- **macOS**: `brew install cava`.
- **FreeBSD**: `pkg install cava`.

## Audio Capture Configuration
The most critical step is ensuring CAVA can "hear" your system audio. Edit the config file (usually `~/.config/cava/config`) to set the `method`:

### Pipewire (Modern Linux Default)
```ini
[input]
method = pipewire
source = auto
```
Use `wpctl status` to find specific `object.path` if `auto` fails.

### PulseAudio
```ini
[input]
method = pulse
source = auto
```
If no bars appear, the source might be set to your microphone. Use `pactl list sources` to find the monitor of your output device.

### ALSA (Legacy/Minimal Linux)
Requires a loopback interface to capture output:
1. Run `sudo modprobe snd_aloop`.
2. Set `method = alsa` and `source = hw:Loopback,1`.

## Visual Customization
CAVA is highly configurable via the `[color]` and `[general]` sections:
- **Smoothing**: Adjust `monstercat` or `waves` in the `[smoothing]` section to change how "fluid" the bars look.
- **Colors**: Use hex codes or terminal color names.
- **Orientation**: Supports `bottom`, `top`, `left`, or `right` bar alignment.
- **Stereo**: Enable `mode = stereo` for split-channel visualization.

## Common CLI Usage
- `cava`: Start the visualizer with default config.
- `cava -p /path/to/config`: Start with a specific configuration file.
- `cava -v`: Display version information.

## Troubleshooting
- **No output**: Ensure the audio source is playing and not muted. Check the `[input]` method in the config.
- **Latency**: Lower the `framerate` in the config or check if your audio buffer is too high.
- **Terminal artifacts**: If using a "dumb" terminal, ensure `ncurses` is installed and set as the output method.

## Reference documentation
- [CAVA Main Documentation](./references/github_com_karlstav_cava.md)