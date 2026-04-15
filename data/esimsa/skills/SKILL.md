---
name: esimsa
description: esimsa is a utility for the deconvolution of ESI-MS data that identifies charge states by measuring the distance between isotopic peaks. Use when user asks to deconvolute mass spectrometry data, determine neutral masses from peak lists, or process ESI-MS spectra using isotopic resolution.
homepage: http://www.ms-utils.org/esimsa.html
metadata:
  docker_image: "quay.io/biocontainers/esimsa:1.0--0"
---

# esimsa

## Overview

`esimsa` is a specialized utility for the deconvolution of ESI-MS data. It operates on a fundamental principle: identifying charge states by measuring the distance between isotopic peaks rather than relying on complex mathematical modeling of isotopic envelopes. This makes it a robust, "simple" deconvolution tool that is effective for processing mass spectra where isotopic resolution is available. It is particularly useful in proteomics and small molecule analysis workflows where a lightweight, command-line driven approach to mass determination is required.

## Installation

The most efficient way to access `esimsa` is via the Bioconda channel:

```bash
conda install bioconda::esimsa
```

Alternatively, it can be compiled from source using GCC:
`gcc -o esimsa esimsa.c -lm`

## Command Line Usage

The tool follows a strict positional argument structure:

```bash
esimsa <peaklist> <maximum charge> <output>
```

### Arguments:
- `<peaklist>`: A text file containing the undeconvoluted peak list (typically m/z and intensity pairs).
- `<maximum charge>`: An integer representing the highest charge state (+z) the algorithm should consider during deconvolution.
- `<output>`: The filename where the resulting list of deconvoluted neutral masses will be saved.

## Best Practices and Tips

- **Peak List Preparation**: Ensure your input peak list is "clean" and contains resolved isotopic peaks. Since `esimsa` relies on mass differences, noisy data or poorly resolved isotopes can lead to incorrect charge state assignments.
- **Setting Maximum Charge**: Do not set the maximum charge unnecessarily high. If you are analyzing small molecules, a max charge of 2 or 3 is usually sufficient. For proteins, estimate the maximum expected charge based on the m/z range and expected mass to reduce false positives and processing time.
- **Output Interpretation**: The output file contains the calculated neutral masses. Always validate these against the raw spectra to ensure the deconvolution logic aligns with the observed isotopic clusters.
- **Handling Overlap**: `esimsa` is capable of handling overlapping isotopic distributions, which is common in complex mixtures, provided the individual peaks can still be distinguished by their mass differences.

## Reference documentation
- [Anaconda Bioconda - esimsa](./references/anaconda_org_channels_bioconda_packages_esimsa_overview.md)
- [ms-utils.org - esimsa](./references/www_ms-utils_org_esimsa.html.md)