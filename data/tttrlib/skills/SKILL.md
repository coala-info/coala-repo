---
name: tttrlib
description: `tttrlib` is a high-performance library for processing time-resolved imaging and spectroscopy data using a vendor-independent API. Use when user asks to load and inspect time-resolved data, perform correlation analysis, generate FLIM or CLSM images, or perform multi-dimensional histogramming.
homepage: https://github.com/fluorescence-tools/tttrlib
---


# tttrlib

## Overview

`tttrlib` is a high-performance library designed to handle the complexities of time-resolved imaging and spectroscopy. By providing a vendor-independent API, it allows you to work with photon streams from various hardware manufacturers using a unified Python interface. Use this skill when you need to perform computationally intensive tasks like multi-dimensional histogramming, correlation analysis, or FLIM image reconstruction on large datasets where standard Python or NumPy implementations are too slow.

## Core Usage Patterns

### Loading and Inspecting Data
Initialize a `TTTR` object to open supported file formats. Accessing the header via JSON is the fastest way to inspect measurement parameters.

```python
import tttrlib

# Load a PicoQuant or Becker & Hickl file
data = tttrlib.TTTR('filename.ptu')

# Access photon arrays (macro_times, micro_times, routing_channels)
m_times = data.macro_times
u_times = data.micro_times
channels = data.routing_channels

# View metadata as a JSON string
print(data.json)
```

### Correlation Analysis (FCS)
The `Correlator` class handles the calculation of correlation functions. You must specify the routing channels for the correlation pairs.

```python
# Correlate photons between channel 1 and channel 2
correlator = tttrlib.Correlator(
    channels=([1], [2]), 
    tttr=data
)

# Retrieve results
lags = correlator.x_axis
correlation_amplitude = correlator.correlation
```

### FLIM and CLSM Image Generation
For Confocal Laser Scanning Microscopy (CLSM) data, use the `CLSM` class to transform the photon stream into spatial images.

```python
clsm = tttrlib.CLSM(data)

# Define channels and micro-time gates (in picoseconds/bins)
# Example: Channel 0, full micro-time range
clsm.fill(
    channels=[0], 
    micro_time_ranges=[[0, 16000]]
)

# Access the intensity image as a NumPy-compatible array
intensity_map = clsm.intensity
```

## Best Practices and Expert Tips

- **Memory Efficiency**: `tttrlib` is written in C++. It is designed to keep large datasets in memory for speed. When working with extremely large FLIM stacks, ensure your environment has sufficient RAM, as the library prioritizes performance over disk-swapping.
- **Micro-time Gating**: Use the `micro_time_ranges` parameter in the `CLSM.fill` method to perform hardware-independent time-gating. This is useful for removing prompt scattering or isolating specific lifetime components.
- **Vendor Independence**: Always use the `TTTR` object as the entry point. It automatically detects the file format (PTU, HT3, SPC, etc.), so you don't need to write format-specific parsers.
- **Performance**: For custom analysis loops, try to use the built-in methods (like `fill` or `Correlator`) rather than iterating over the macro/micro time arrays in pure Python, as the C++ implementation is approximately 40x faster than NumPy-based alternatives.

## Reference documentation

- [tttrlib GitHub Repository](./references/github_com_Fluorescence-Tools_tttrlib.md)
- [tttrlib Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tttrlib_overview.md)