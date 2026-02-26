---
name: mne
description: MNE-Python is a library designed for processing and analyzing neurophysiological data such as EEG, MEG, and fNIRS. Use when user asks to load raw sensor data, preprocess signals with filters, epoch events, or visualize brain activity maps and reports.
homepage: https://github.com/mne-tools/mne-python
---


# mne

## Overview
MNE-Python is a specialized library designed for the analysis of large-scale neurophysiological recordings. It provides a comprehensive suite of tools to transform raw sensor data into interpretable brain activity maps. This skill focuses on the core workflows of the MNE ecosystem, including handling various data formats (EDF, BDF, FIF, SNIRF), managing metadata through the `info` object, and utilizing the built-in command-line interface for system diagnostics and data visualization.

## Installation and Environment
Ensure the environment meets the minimum requirements (Python ≥ 3.10, NumPy, SciPy, Matplotlib).

```bash
# Install stable version
pip install --upgrade mne

# Install with full dependencies (recommended for visualization/3D)
pip install --upgrade mne[full]
```

## Command Line Interface (CLI)
MNE provides several high-utility CLI tools for quick data inspection and system management.

- **System Diagnostics**: Check versions and hardware acceleration (CUDA/OpenBLAS).
  ```bash
  mne sys_info
  ```
- **Data Browser**: Open a raw file for visual inspection without writing a script.
  ```bash
  mne browse_raw <filename.fif>
  ```
- **Report Generation**: Create an interactive HTML report from a data directory.
  ```bash
  mne report --path <data_folder> --extension .fif
  ```
- **Coregistration**: Launch the GUI for MEG/EEG-MRI alignment.
  ```bash
  mne coreg
  ```

## Core Workflow Best Practices

### 1. Data Loading and Anonymization
Always inspect the `info` object immediately after loading. Use the built-in anonymization tools for clinical data sharing.
- Use `mne.io.read_raw_<format>` for initial loading.
- Use `raw.info['bads']` to mark noisy channels early in the pipeline.
- **Anonymization**: `raw.anonymize()` removes PHI (Patient Health Information) like birthdates and names.

### 2. Preprocessing Essentials
- **Filtering**: Prefer `raw.filter(l_freq, h_freq)` for general use. Use `raw.notch_filter()` specifically for power line noise (50/60Hz).
- **Reference**: For EEG, always define a reference. Use `raw.set_eeg_reference('average', projection=True)` for an average reference projection.
- **Memory Management**: MNE uses "lazy loading." Use `raw.load_data()` only when you need to modify the data in place (e.g., filtering).

### 3. Epoching and Event Handling
- Extract events from stim channels: `events = mne.find_events(raw)`.
- Create Epochs: `epochs = mne.Epochs(raw, events, event_id, tmin, tmax, baseline=(None, 0))`.
- Use `epochs.drop_bad()` to remove segments exceeding peak-to-peak thresholds.

### 4. Visualization and Reporting
- **Interactive Plotting**: Use `raw.plot()` or `epochs.plot()` to manually mark bad segments or channels.
- **Automated Reports**: Use `mne.Report` to bundle plots, metadata, and analysis logs into a single shareable HTML file.

## Expert Tips
- **Channel Naming**: Ensure electrode names follow the 10-20 system for automated montage application using `raw.set_montage('standard_1020')`.
- **Data Frames**: For integration with Pandas or machine learning workflows, use `df = raw.to_data_frame()` to export signal data.
- **Scaling**: When plotting, use the `scalings` parameter (e.g., `scalings={'eeg': 20e-6}`) to adjust the visual amplitude of signals.

## Reference documentation
- [MNE-Python Repository Overview](./references/github_com_mne-tools_mne-python.md)
- [Security and Anonymization Policy](./references/github_com_mne-tools_mne-python_security.md)
- [MNE Wiki and Snippets](./references/github_com_mne-tools_mne-python_wiki.md)