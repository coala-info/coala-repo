---
name: tttrlib
description: tttrlib is a high-performance library for analyzing time-resolved photon streams and bridging proprietary data formats with open-source pipelines. Use when user asks to read TTTR files, perform correlation analysis, generate FLIM images, or process large-scale fluorescence data.
homepage: https://github.com/fluorescence-tools/tttrlib
---


# tttrlib

## Overview

`tttrlib` is a high-performance, vendor-neutral library designed for the analysis of photon streams. It bridges the gap between proprietary data formats and open-source analysis pipelines by providing fast C++ implementations with accessible Python bindings. Use this skill to handle large-scale time-resolved data where pure Python performance is a bottleneck, particularly for tasks like multi-dimensional histogramming, burst selection, and fluorescence lifetime imaging (FLIM).

## Installation and Setup

The library is available via major package managers. For most analysis environments, use:

```bash
# Standard installation
pip install tttrlib

# For Windows users via Conda
mamba install -c tpeulen tttrlib

# For macOS/Linux users via Bioconda
mamba install -c conda-forge -c bioconda tttrlib
```

## Core Python Usage Patterns

### Reading TTTR Data
The `TTTR` class is the primary entry point for loading photon streams.

```python
import tttrlib

# Load a PicoQuant or Becker & Hickl file
data = tttrlib.TTTR("experiment.ptu")

# Access photon attributes as numpy-like arrays
macro_times = data.macro_times
micro_times = data.micro_times
routing_channels = data.routing_channels
```

### Metadata Inspection
Access hardware settings and file headers in structured formats.

```python
# Get header as JSON for easy parsing
header_json = data.header.json

# Export header to CSV for documentation
data.header.to_csv("metadata.csv")
```

### Correlation Analysis
Perform hardware-accelerated cross-correlation or auto-correlation.

```python
correlator = tttrlib.Correlator(
    channels=([1], [2]), # Cross-correlate channel 1 and 2
    tttr=data
)

lags = correlator.x_axis
correlation_amplitude = correlator.correlation
```

### CLSM and FLIM Imaging
Generate intensity and lifetime images from scanning data.

```python
# Initialize CLSM image from TTTR data
clsm = tttrlib.CLSMImage(data)

# Fill image using specific channels and micro-time windows
clsm.fill(channels=[0, 1], micro_time_ranges=[[0, 16000]])

# Access the intensity matrix
intensity_map = clsm.intensity
```

## Command Line Interface (CLI)

The `tttrlib` package includes a CLI tool for quick inspection and processing of TTTR files without writing scripts.

### Common CLI Tasks
- **Header Inspection**: Quickly view the metadata of a PTU or SPC file.
- **Format Conversion**: Convert vendor-specific formats to open standards like Photon-HDF5.
- **Diagnostic Checks**: Verify file integrity and photon counts.

## Expert Tips for Performance

- **Avoid Pure Python Loops**: When processing millions of photons, always use the built-in `tttrlib` methods (e.g., `get_fluorescence_decay`) rather than iterating over `micro_times` in Python. `tttrlib` is ~40x faster for histogramming.
- **Memory Management**: For extremely large files, access only the necessary arrays (e.g., just `routing_channels`) to minimize memory overhead.
- **Parallelization**: `tttrlib` supports OpenMP. Ensure your environment allows multi-threading to speed up correlation calculations.
- **Becker & Hickl Support**: When working with BH SPCM data, ensure the `.set` file is in the same directory as the `.spc` file for automatic dimension inference.



## Subcommands

| Command | Description |
|---------|-------------|
| image | Image processing (exporting, FLIM, ...) |
| trace | Trace processing (correlation, burst selection, burst analysis, ...) |

## Reference documentation
- [tttrlib Main Repository](./references/github_com_Fluorescence-Tools_tttrlib.md)
- [Building and Installation Guide](./references/github_com_Fluorescence-Tools_tttrlib_blob_main_BUILDING.md)
- [README and Quickstart](./references/github_com_Fluorescence-Tools_tttrlib_blob_main_README.md)