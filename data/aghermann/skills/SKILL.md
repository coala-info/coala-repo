---
name: aghermann
description: Aghermann is a specialized tool for sleep researchers to model the homeostatic regulation of sleep and manage complex EEG datasets. Use when user asks to model Process S based on slow-wave activity, visualize EDF files, perform artifact removal, or detect specific EEG patterns like K-complexes.
homepage: https://github.com/BackupTheBerlios/aghermann
---


# aghermann

## Overview
Aghermann is a specialized tool designed for sleep researchers to model the homeostatic regulation of sleep (Process S) based on Slow-Wave Activity (SWA) profiles. It facilitates the management of complex sleep study datasets organized by subject, session, and episode. Beyond simulation, it provides robust utilities for EEG/EOG/EMG visualization in the European Data Format (EDF), artifact removal, and automated pattern detection for specific sleep EEG features like K-complexes.

## Aghermann usage and best practices

### Data organization and EDF management
Aghermann expects a specific directory hierarchy to manage experimental designs effectively.
- **Directory Structure**: Organize files by `Subject > Session > Episode`. This allows the tool to correctly associate multiple recordings from the same individual across different experimental conditions.
- **Header Inspection**: Use the `edfhed` utility to verify EDF metadata before importing. This ensures that sampling rates and channel labels are consistent across your dataset.
- **Channel Mapping**: Ensure EEG, EOG, and EMG channels are correctly identified during the initial scan to enable specialized filters like the Unfazer.

### Artifact handling and 'Unfazer'
Clean data is critical for accurate Power Spectral Density (PSD) analysis.
- **Manual Filtering**: Always perform artifact rejection on epochs before running PSD analysis. Aghermann calculates spectral power only on "clean" epochs to prevent noise from skewing the SWA profile.
- **The Unfazer Tool**: Use this to remove EOG artifacts (like blinks) from EEG signals. It works by subtracting a fraction of the EOG signal from the affected EEG channel. 
    - **Tip**: Adjust the subtraction factor iteratively until the blink deflection in the EEG signal is minimized without distorting the underlying brain activity.

### Process S simulation
The primary goal of Aghermann is to produce sleep homeostat parameters.
- **SWA Profiles**: Generate SWA profiles for specific frequency ranges (typically 0.5–4.0 Hz) to serve as the input for Process S modeling.
- **Parameter Differentiation**: Use the resulting homeostat parameters to differentiate between phenotypes, such as short vs. long sleepers or early vs. late chronotypes.

### Pattern finding (K-complexes)
Aghermann uses a multi-criteria approach to find specific EEG patterns.
- **Low-Frequency Component**: Set the cutoff and filter order to isolate the slow wave of the K-complex.
- **Envelope Tightness**: Adjust the "tightness" of the lines connecting local extrema to define the shape of the expected pattern.
- **Zero-Crossing Density**: Fine-tune the sigma and sampling interval for the derivative of the signal to match the specific morphology of the target waveform.

### Signal processing filters
- **Butterworth Filters**: Use the built-in Low-pass, High-pass, and Band-pass filters for general signal conditioning.
- **Phase Difference**: Use this feature to investigate the direction of EEG wave propagation between channels, though results should be interpreted as tentative.

## Reference documentation
- [Project Aghermann README](./references/github_com_BackupTheBerlios_aghermann.md)
- [Commit History (edfhed details)](./references/github_com_BackupTheBerlios_aghermann_commits_master.md)