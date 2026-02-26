---
name: hinge
description: Hingemonium transforms a MacBook into a virtual harmonium by using the laptop's lid movement to simulate bellows. Use when user asks to install the application, configure keyboard and bellows controls, select musical scales, or troubleshoot hardware sensor issues.
homepage: https://github.com/Rocktopus101/Hingemonium
---


# hinge

## Overview

Hingemonium is a specialized macOS application that transforms a MacBook into a virtual harmonium. Unlike standard MIDI controllers, it uses the physical movement of the laptop's lid (the hinge) to simulate the bellows of a traditional harmonium. The velocity of the lid's movement determines the "air pressure," which directly affects the volume and sustain of the notes played. This skill is used to assist with the setup, performance controls, and troubleshooting of this unique hardware-integrated instrument.

## Installation and Setup

The most efficient way to install the tool is via Homebrew.

```bash
brew tap Rocktopus101/homebrew-personal
brew install hingemonium
```

For developers wishing to modify the source or build from scratch:
1. Clone the repository.
2. Open `Hingemonium.xcodeproj` in Xcode.
3. Use the "Play" button to build and run the application.

## Performance Controls

### The Keyboard (Keys)
The application maps the MacBook keyboard to a musical layout. The bottom two rows function as the primary keys:
- **White Keys**: The bottom row (e.g., `Z`, `X`, `C`, `V`, `B`, `N`, `M`).
- **Black Keys**: The row above the bottom row (e.g., `S`, `D`, `G`, `H`, `J`).
- **Legend**: The app interface provides a visual legend showing which note each key triggers based on the selected scale.

### The Bellows (Lid)
- **Volume Control**: Open and close the laptop lid to "pump" air.
- **Velocity**: Faster movement creates higher air pressure and louder sound.
- **Fading**: If lid movement stops, the sound naturally fades as the virtual air reservoir depletes.
- **Max Air Mode**: Use the "Max Air" toggle to simulate constant hinge movement if physical lid flapping is not desired or possible.

## Expert Tips and Best Practices

- **Scale Selection**: Use the dropdown menu to switch between Chromatic, Major, Minor, and Sargam (Sa Re Ga Ma...) modes to simplify melodic creation.
- **Hardware Compatibility**: The tool is optimized for M1 Pro and newer MacBooks. Users on 2020 M1 Air or Touchbar Pro models may experience sensor detection issues.
- **Responsiveness**: If notes hang, ensure "Max Air" mode is toggled off or check for "Note Overlap" fixes in the latest release.
- **Sargam Mode**: For Indian Classical music practitioners, switching to Sargam mode redefines the keyboard legend to traditional solfege.

## Reference documentation
- [Hingemonium README](./references/github_com_Rocktopus101_Hingemonium.md)
- [Hingemonium Commits](./references/github_com_Rocktopus101_Hingemonium_commits_main.md)
- [Hingemonium Issues](./references/github_com_Rocktopus101_Hingemonium_issues.md)