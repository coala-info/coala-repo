---
name: pyquant-ms
description: pyquant-ms is a framework for the automated quantification of mass spectrometry data through ion chromatogram extraction and peak fitting. Use when user asks to quantify proteomics data, perform SILAC or isobaric tagging analysis, or conduct NeuCode quantification.
homepage: https://chris7.github.io/pyquant/
---


# pyquant-ms

## Overview

pyquant-ms is a versatile framework designed for the automated quantification of mass spectrometry data. It bridges the gap between peptide identification and quantification by extracting ion chromatograms (XICs) and performing peak fitting. The tool supports a wide array of labeling chemistries and can handle complex workflows like MS3-based quantification and NeuCode analysis. It is particularly useful for researchers who need a command-line interface to integrate quantification into their existing proteomics pipelines.

## Installation and Setup

The tool can be installed via Conda or Pip:

```bash
# Conda installation
conda install bioconda::pyquant-ms

# Pip installation (requires Cython)
pip install Cython
pip install pyquant
```

For Docker users, use the image `chrismit7/pyquant`. Ensure local directories are mounted to the container to allow access to raw data and search files.

## Common CLI Patterns

### SILAC Quantification (MaxQuant)
When using MaxQuant "evidence.txt" files, use the `--maxquant` flag to automatically map columns.
```bash
pyQuant --tsv evidence.txt --label-method K8R10 --maxquant --out silac_results
```

### Isobaric Tagging (TMT/iTRAQ)
For TMT or iTRAQ, specify the labeling method and the reference channel.
```bash
# MS3-based TMT10 quantification
pyQuant --isobaric-tags --ms3 --label-method TMT10 --search-file data.msf --reference-label 128N --precursor-ppm 10
```

### NeuCode Analysis
NeuCode requires high-resolution data and a specific labeling scheme file.
```bash
pyQuant --neucode --resolution 200000 --search-file data.pep.xml --label-scheme neucode.tsv --overlapping-labels
```

## Parameter Optimization

*   **Mass Accuracy**: Adjust `--precursor-ppm` (for the first monoisotopic peak) and `--isotope-ppm` (for the cluster) based on the instrument's performance (e.g., 10 ppm for Orbitrap, 20-50 ppm for older instruments).
*   **Retention Time**: Use `--rt-window` to define the maximal deviation (in minutes) allowed for a scan to be considered for a specific peptide identification.
*   **Peak Fitting**: If dealing with noisy MS1 data, reduce `--max-peaks` to prevent the algorithm from over-fitting noise.
*   **Missing Values**: Enable `--mva` (Missing Value Analysis) to attempt quantification in runs where a peptide was not explicitly identified but is expected based on other runs.

## Expert Tips

*   **Visual Validation**: Always include the `--html` flag during initial runs. This generates an HTML summary that allows you to visually inspect peak picking and integration quality.
*   **Resuming Jobs**: If a large run is interrupted, use the `--resume` flag. This only works if the output is directed to a file prefix via `--out` rather than stdout.
*   **Performance**: For very large datasets, use the `--sample` parameter (e.g., `--sample 0.1`) to run the pipeline on 10% of the data first to verify that parameters and labeling schemes are correctly configured.
*   **Raw Data Access**: If your raw files are not in the same directory as your search files, explicitly point to them using `--scan-file-dir`.

## Reference documentation

- [pyquant-ms Overview](./references/anaconda_org_channels_bioconda_packages_pyquant-ms_overview.md)
- [PyQuant Documentation](./references/chris7_github_io_pyquant.md)