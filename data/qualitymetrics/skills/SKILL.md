---
name: qualitymetrics
description: This tool computes and assesses the quality of individual neural units from electrophysiology data. Use when user asks to calculate neural unit quality metrics.
homepage: https://github.com/SteinmetzLab/qualityMetrics
metadata:
  docker_image: "biocontainers/qualitymetrics:phenomenal-v2.2.11_cv1.0.11"
---

# qualitymetrics

---
## Overview
The `qualitymetrics` tool is designed to compute and assess the quality of individual neural units from electrophysiology data, with a specific focus on neuropixels recordings. It provides a suite of metrics to help researchers evaluate the reliability and characteristics of detected neuronal signals, aiding in data cleaning and analysis.

## Usage Instructions

The `qualitymetrics` tool is primarily used via its command-line interface. The core functionality involves processing electrophysiology data to generate quality metrics for detected neuronal units.

### Core Functionality

The tool's main purpose is to calculate metrics that define the quality of neural units. This typically involves analyzing spike waveforms, signal-to-noise ratios, and other relevant electrophysiological features.

### Command-Line Interface (CLI)

While specific command-line arguments and options are not detailed in the provided documentation, the general usage pattern would involve specifying input data files and output destinations.

**General Structure:**

```bash
qualitymetrics --input <input_data_path> --output <output_directory> [options]
```

*   `<input_data_path>`: Path to the electrophysiology data file(s) (e.g., `.npy`, `.bin`, or other raw data formats).
*   `<output_directory>`: Directory where the computed quality metrics and associated files will be saved.

**Common Metrics (Inferred):**

Based on the repository's commit history and file structure, the tool likely computes metrics related to:

*   **Spike Amplitude:** Amplitude of detected spikes.
*   **Noise Cutoff:** Thresholds related to signal noise.
*   **Refractory Period Violations:** Metrics assessing the refractory period of neurons.
*   **Signal-to-Noise Ratio (SNR):** Measures the strength of the neural signal relative to background noise.
*   **Peak-to-Peak Amplitude:** The difference between the peak and trough of a spike waveform.

**Expert Tips:**

*   **Platform Specificity:** The repository indicates separate implementations for Python and MATLAB. Ensure you are using the correct version of the tool for your data and environment.
*   **Data Format:** Familiarize yourself with the expected input data format for the chosen implementation (Python or MATLAB).
*   **Output Interpretation:** Understand the meaning of each computed quality metric to effectively interpret the results and make informed decisions about unit selection. The README files within the repository's platform-specific folders (e.g., `python/`, `matlab/`) are crucial for this.

## Reference documentation
- [README.md](./references/github_com_SteinmetzLab_qualityMetrics.md)