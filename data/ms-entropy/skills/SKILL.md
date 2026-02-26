---
name: ms-entropy
description: The ms-entropy tool provides a Python implementation for calculating spectral entropy and performing information-theory-based mass spectrometry similarity analysis. Use when user asks to calculate spectral entropy, determine spectral similarity, or perform rapid library searches using the Flash Entropy Search algorithm.
homepage: https://github.com/YuanyueLi/MSEntropy
---


# ms-entropy

## Overview

The `ms-entropy` tool provides a specialized Python implementation for information-theory-based mass spectrometry analysis. Unlike traditional dot-product methods, this tool utilizes spectral entropy to measure the complexity of a spectrum and calculate similarity, which has been shown to be more effective for compound identification. It includes the Flash Entropy Search algorithm, designed to query large mass spectral libraries in real-time.

## Installation

Install the package via pip or conda:

```bash
pip install ms_entropy
# OR
conda install bioconda::ms-entropy
```

## Core Workflows

### 1. Calculating Spectral Entropy
Spectral entropy measures the information content of a spectrum. Always ensure the spectrum is "cleaned" (noise removed, peaks merged) before calculation for accurate results.

```python
import numpy as np
import ms_entropy as me

# Peaks format: [[mz, intensity], [mz, intensity], ...]
peaks = np.array([[69.071, 7.91], [86.066, 1.02], [86.096, 100.0]], dtype=np.float32)

entropy = me.calculate_spectral_entropy(
    peaks, 
    clean_spectrum=True, 
    min_ms2_difference_in_da=0.05
)
```

### 2. Spectral Similarity
Use entropy similarity to compare a query spectrum against a reference.

```python
# Calculate weighted entropy similarity
similarity = me.calculate_entropy_similarity(
    peaks_query, 
    peaks_reference, 
    ms2_tolerance_in_da=0.05
)

# Calculate unweighted entropy similarity
unweighted = me.calculate_unweighted_entropy_similarity(
    peaks_query, 
    peaks_reference, 
    ms2_tolerance_in_da=0.05
)
```

### 3. Flash Entropy Search
For large-scale library searching, use the `FlashEntropySearch` class to build an index and perform rapid queries.

```python
from ms_entropy import FlashEntropySearch

entropy_search = FlashEntropySearch()

# spectral_library should be a list of spectra dictionaries
entropy_search.build_index(spectral_library)

# Search using precursor m/z and peaks
results = entropy_search.search(
    precursor_mz=query_mz, 
    peaks=query_peaks
)
```

## Best Practices

- **Spectrum Cleaning**: Always set `clean_spectrum=True` or manually use the cleaning functions. Spectral entropy is sensitive to noise and redundant peaks within the same mass tolerance.
- **Tolerance Selection**: The default `ms2_tolerance_in_da` is often 0.02 or 0.05. Ensure this matches the resolution of your mass spectrometer (e.g., use smaller values for Orbitrap/Q-TOF data).
- **Data Types**: Use `np.float32` for peak arrays to ensure compatibility with the underlying C/Cython implementations for better performance.
- **Flash Search Efficiency**: When searching against thousands of spectra, `FlashEntropySearch` is significantly faster than iterating through `calculate_entropy_similarity` calls.

## Reference documentation
- [MSEntropy GitHub Repository](./references/github_com_YuanyueLi_MSEntropy.md)
- [Bioconda ms-entropy Overview](./references/anaconda_org_channels_bioconda_packages_ms-entropy_overview.md)