---
name: nmrglue
description: The `nmrglue` skill enables the programmatic handling of Nuclear Magnetic Resonance (NMR) data within a Python environment.
homepage: http://www.nmrglue.com
---

# nmrglue

## Overview
The `nmrglue` skill enables the programmatic handling of Nuclear Magnetic Resonance (NMR) data within a Python environment. It is designed to bridge the gap between various proprietary NMR software formats by representing spectral data as standard NumPy ndarrays and metadata as Python dictionaries. This skill should be used for automating NMR workflows, such as batch processing raw FIDs into frequency-domain spectra, converting data for visualization in matplotlib, or performing complex analysis like multidimensional peak fitting that is difficult to achieve in GUI-based software.

## Core Usage Patterns

### Data Loading and Conversion
Nmrglue uses a consistent `read` and `write` API across different formats. Each reader returns a dictionary of spectral parameters (`dic`) and a NumPy array of the data (`data`).

- **NMRPipe**: `import nmrglue as ng; dic, data = ng.pipe.read("test.fid")`
- **Bruker**: `dic, data = ng.bruker.read("expno/")`
- **Agilent/Varian**: `dic, data = ng.agilent.read("sample.fid")`

To convert formats, read the source format and use the corresponding `write` function for the target format.

### Spectral Processing Pipeline
Processing is typically performed on the NumPy `data` object. Common operations include:

1.  **Apodization**: Apply window functions (e.g., exponential, sine-bell) to the FID.
    - `data = ng.proc_base.em(data, lb=0.1)` (Exponential multiplication)
    - `data = ng.proc_base.sp(data, off=0.5, end=1.0, pow=2)` (Sine-bell)
2.  **Fourier Transform**: Convert from time domain to frequency domain.
    - `data = ng.proc_base.fft(data)`
3.  **Phase Correction**: Adjust zero and first-order phase.
    - `data = ng.proc_base.ps(data, p0=45.0, p1=0.0)`
4.  **Baseline Correction**: Flatten the baseline using polynomial or median filters.
    - `data = ng.proc_bl.poly(data, order=1)`

### Analysis and Visualization
- **Peak Picking**: Use `ng.peakpick.pick()` to identify peaks based on threshold and segmentation.
- **Integration**: Calculate peak volumes using the `ng.peakpick` module or direct NumPy summation.
- **Plotting**: Integrate with `matplotlib`. Use `ng.pipe.make_uc` to create a unit conversion object for plotting in ppm or Hz instead of points.

## Expert Tips
- **Memory Mapping**: For very large datasets (e.g., 3D or 4D spectra), use the `low_mem=True` flag in readers to map the file on disk rather than loading it entirely into RAM.
- **Dictionary Manipulation**: The `dic` object contains the "universal" or "native" parameters. When converting between formats, you may need to use `ng.convert.converter` to translate metadata keys correctly.
- **Universal Converters**: Use `ng.uc_from_dic(dic)` to create a unit conversion object that handles the math for switching between points, Hz, and ppm automatically.

## Reference documentation
- [nmrglue Overview](./references/www_nmrglue_com_index.md)
- [Bioconda nmrglue Package](./references/anaconda_org_channels_bioconda_packages_nmrglue_overview.md)