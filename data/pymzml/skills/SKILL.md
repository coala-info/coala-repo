---
name: pymzml
description: `pymzml` is a specialized Python library designed to act as a high-performance interface for mzML mass spectrometry data.
homepage: https://github.com/pymzml/pymzML
---

# pymzml

## Overview
`pymzml` is a specialized Python library designed to act as a high-performance interface for mzML mass spectrometry data. It allows for the rapid development of MS data analysis tools by providing a fast parser based on `cElementTree`. This skill should be used to automate the extraction of m/z and intensity arrays, filter spectra by MS level, and handle large, compressed datasets efficiently without needing to decompress them manually.

## Installation and Setup
Install the library along with specific feature sets depending on your requirements:

- **Standard**: `pip install pymzml`
- **With Plotting**: `pip install "pymzml[plot]"`
- **With Deconvolution**: `pip install "pymzml[deconvolution]"`
- **Full Suite**: `pip install "pymzml[full]"`

## Core Usage Patterns

### Basic Reader Initialization
The `run.Reader` object is the primary entry point. It handles both plain and compressed (.gz) mzML files.

```python
import pymzml
run = pymzml.run.Reader("data.mzml")
```

### Iterating Through Spectra
Iterate through the `run` object to process spectra sequentially. This is memory-efficient for large files.

```python
for spectrum in run:
    # Access MS level
    ms_level = spectrum.ms_level
    # Access numpy arrays of data
    mzs = spectrum.mz
    intensities = spectrum.i
    print(f"Spectrum {spectrum.ID} has {len(mzs)} peaks")
```

### Random Access
If the mzML file is indexed (standard for most mzMLs), you can access spectra directly by their ID.

```python
# Access spectrum with ID 100
spec = run[100]
```

### Extracting Metadata and Chromatograms
You can extract specific metadata or calculate the Total Ion Chromatogram (TIC) across the run.

```python
# Get TIC for the entire run
tic = run.info['TIC']

# Accessing specific spectrum metadata
rt = spec.scan_time_in_minutes()
base_peak_mz = spec.peaks("raw")[0][0] # Returns (mz, intensity)
```

## Expert Tips and Best Practices

- **Compressed Seekability**: For large datasets, use the "Blocked gzip" (bgzf) format. `pymzml` can seek within these files without decompressing the entire archive, significantly speeding up random access.
- **Memory Management**: Always prefer iterating over the `Reader` object rather than converting it to a list, as MS files can easily exceed available RAM.
- **Filtering on the Fly**: Use the `ms_level` attribute early in your loop to skip unnecessary processing of MS1 or MSn spectra depending on your analysis goals.
- **Numpy Integration**: Since `spectrum.mz` and `spectrum.i` return numpy arrays, leverage vectorized operations for peak picking, smoothing, or normalization to maintain high performance.
- **Handling Dependencies**: If you encounter installation issues with `pynumpress`, ensure `numpy` is installed in your environment first, as it is a build-time requirement for some C extensions.

## Reference documentation
- [pymzML GitHub Repository](./references/github_com_pymzml_pymzML.md)
- [Bioconda pymzml Overview](./references/anaconda_org_channels_bioconda_packages_pymzml_overview.md)