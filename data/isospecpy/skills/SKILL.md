---
name: isospecpy
description: "isospecpy calculates the isotopic distribution and fine structure of molecules using the IsoSpec++ library. Use when user asks to calculate isotopic envelopes, determine mass spectrometry peak probabilities, or find the isotopic distribution of a chemical formula."
homepage: http://matteolacki.github.io/IsoSpec/
---


# isospecpy

## Overview

The `isospecpy` skill provides a Python interface to the IsoSpec++ library, a hyperfast isotopic structure calculator. It allows for the precise determination of a molecule's isotopic envelope—the collection of masses and their corresponding probabilities resulting from naturally occurring isotopes. This is critical for mass spectrometry analysis, where understanding the fine structure of isotopic distributions helps in identifying molecular compositions and verifying experimental data.

## Installation

Install the package via bioconda:

```bash
conda install bioconda::isospecpy
```

## Core Usage Patterns

### Calculating by Total Probability Coverage
Use `IsoTotalProb` when you need to capture a specific percentage of the total isotopic distribution (e.g., 99.9%). This is the preferred method for ensuring the accuracy of the simplified spectrum.

```python
import IsoSpecPy as iso

# Calculate 99.99% of the isotopic distribution for Bovine Insulin
sp = iso.IsoTotalProb(formula="C254H377N65O75S6", prob_to_cover=0.9999)

# Iterate through results
for mass, prob in sp:
    print(f"Mass: {mass}, Probability: {prob}")
```

### Calculating by Probability Threshold
Use `IsoThreshold` to obtain only the peaks that exceed a specific individual probability height.

```python
# Get peaks with individual probability higher than 0.01%
sp = iso.IsoThreshold(formula="C254H377N65O75S6", threshold=0.0001)
```

### Memory-Efficient Generation
For extremely large molecules or very high coverage requirements where storing all isotopologues in RAM is impractical, use the generator mode.

```python
# Memory-efficient iteration using a generator
for m, p in iso.IsoThresholdGenerator(formula="C254H377N65O75S6", threshold=0.0001):
    # Process each peak on the fly
    pass
```

## Expert Tips and Best Practices

- **Formula Syntax**: Ensure formulas follow standard chemical notation (e.g., "H2O1", "C6H12O6").
- **Direct Array Access**: For performance-critical applications, access the underlying cffi arrays directly via `sp.masses` and `sp.probs` instead of iterating over the object.
- **Visualization**: If `matplotlib` is installed, you can quickly inspect the distribution using `sp.plot()`.
- **Ordering**: The first isotopologue (index 0) returned by `IsoTotalProb` or `IsoThreshold` is always one of the modes (most probable peaks) of the distribution.
- **L1 Distance**: Using `IsoTotalProb` ensures that the L1 distance between the full isotopic distribution and your calculated subset is less than `1 - prob_to_cover`.

## Reference documentation
- [What is IsoSpec?](./references/matteolacki_github_io_IsoSpec.md)
- [isospecpy on Bioconda](./references/anaconda_org_channels_bioconda_packages_isospecpy_overview.md)