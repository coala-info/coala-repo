---
name: dimspy
description: DIMSpy is a Python framework for processing and aligning direct infusion mass spectrometry data into peak matrices. Use when user asks to process raw spectral scans, filter technical replicates, align samples into a single matrix, or perform blank and sample filtering.
homepage: https://github.com/computational-metabolomics/dimspy
---


# dimspy

## Overview

DIMSpy is a specialized Python framework designed for the high-throughput processing of mass spectrometry data acquired without chromatographic separation. It transforms raw spectral scans into a clean, aligned peak matrix. The tool is particularly effective for handling Thermo Fisher .RAW files and mzML formats, offering sophisticated algorithms for signal-to-noise (SNR) calculation, Fourier transform ringing artifact removal, and hierarchical clustering for peak alignment across large cohorts.

## Core Workflow & CLI Patterns

The standard DIMSpy workflow follows a linear progression from raw data to a filtered peak matrix.

### 1. Spectral Processing (`process-scans`)
Extracts and averages scans from raw files. This is the most computationally intensive step.

```bash
dimspy process-scans -i ./raw_data -o peaklists.hdf5 -m median -s 3.5 -p 2.0 -n 10
```
- **-m (noise function)**: Use `median` or `mad` for robust noise estimation. Use `noise_packets` only for Thermo `.raw` files.
- **-s (SNR threshold)**: A value of 3.0 to 5.0 is standard for high-resolution data.
- **-p (ppm)**: Mass tolerance for grouping peaks across scans (typically 1.0–2.0 ppm).
- **-n (min_scans)**: Minimum scans required to retain a peak; helps filter transient noise.

### 2. Replicate Filtering (`replicate-filter`)
Filters peaks based on reproducibility across technical replicates.

```bash
dimspy replicate-filter -i peaklists.hdf5 -p 2.0 --replicates 3 --min-peaks 2 --rsd-thres 30.0
```
- **--min-peaks**: If you have 3 replicates, setting this to 2 (2-out-of-3 rule) is common.
- **--rsd-thres**: Removes peaks with high Relative Standard Deviation (e.g., >30%) across replicates.

### 3. Sample Alignment (`align-samples`)
Aligns peaklists from different biological samples into a single peak matrix.

```bash
dimspy align-samples -i filtered_replicates.hdf5 -p 2.0 -o aligned_matrix.hdf5
```

### 4. Post-Alignment Filtering
Clean the matrix by removing background noise and low-quality features.

- **Blank Filtering**: `dimspy blank-filter -i matrix.hdf5 --blank-tag Blank --fold-threshold 3`
- **Sample Filtering**: `dimspy sample-filter -i matrix.hdf5 --min-fraction 0.5` (Retains peaks present in at least 50% of samples).

## Expert Tips & Best Practices

- **mzML Requirements**: If using mzML files converted via ProteoWizard, you **must** use the `--simAsSpectra` filter during conversion, or DIMSpy will fail to recognize SIM-type scans.
- **Filelist Metadata**: Always prepare a tab-delimited `filelist.txt`. It must contain `filename` and `classLabel` columns. Optional but recommended columns include `injectionOrder`, `replicate`, and `batch`.
- **SIM Stitching**: By default, DIMSpy "stitches" overlapping Selected Ion Monitoring (SIM) windows into a single pseudo-spectrum. If you need to analyze windows independently, use the `--skip-stitching` flag.
- **Ringing Artifacts**: For FT-ICR or Orbitrap data, use `--ringing-thres` (e.g., 0.05) in `process-scans` to remove side-lobe artifacts around high-intensity peaks.
- **Parallelization**: Use the `-c` or `--ncpus` flag in `process-scans` and `align-samples` to utilize multiple cores, as these steps are highly parallelizable.



## Subcommands

| Command | Description |
|---------|-------------|
| dimspy align-samples | Aligns samples by grouping peaks across scans/mass spectra based on mass tolerance. |
| dimspy blank-filter | Filters a peak matrix based on blank samples. |
| dimspy create-sample-list | Create a sample list from an HDF5 peak matrix. |
| dimspy get-average-peaklist | Calculates the average peaklist from input HDF5 files. |
| dimspy get-peaklists | Get peaklists from HDF5 files. |
| dimspy hdf5-pls-to-txt | Converts HDF5 peaklist objects to text files. |
| dimspy hdf5-pm-to-txt | Converts a HDF5 peak matrix to a text file. |
| dimspy merge-peaklists | Merge peaklists from multiple HDF5 files. |
| dimspy mv-sample-filter | Filters samples based on the maximum fraction of missing values. |
| dimspy process-scans | Processes raw mass spectrometry scan data to generate peaklists. |
| dimspy remove-samples | Removes samples from a peak matrix or peaklist object. |
| dimspy replicate-filter | Filters peaklists based on replicate information. |
| dimspy sample-filter | Apply sample filter to a peak matrix. |
| dimspy unzip | Unzip a dimspy file. |

## Reference Documentation

- [Command Line Interface](./references/dimspy_readthedocs_io_en_latest_cli.html.md)
- [Tools Module (High-level Workflows)](./references/dimspy_readthedocs_io_en_latest_dimspy.tools.html.md)
- [Processing Module (Algorithms)](./references/dimspy_readthedocs_io_en_latest_dimspy.process.html.md)
- [Data Models (PeakList & PeakMatrix)](./references/dimspy_readthedocs_io_en_latest_dimspy.models.html.md)