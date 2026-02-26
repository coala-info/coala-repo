---
name: ms2rescore-rs
description: This tool rescores peptide identifications by integrating peak intensities and retention time predictions into the scoring process to improve identification reliability. Use when user asks to rescore proteomics datasets, improve peptide identification accuracy, or process large-scale mass spectrometry data efficiently.
homepage: https://github.com/compomics/ms2rescore-rs
---


# ms2rescore-rs

## Overview
This skill facilitates the use of `ms2rescore-rs`, a high-performance Rust implementation of core components for the MS²Rescore framework. It is designed to improve the reliability of peptide identifications by integrating additional features (such as peak intensities and retention time predictions) into the scoring process. Use this tool when you need to process large-scale proteomics datasets where computational efficiency and rescoring accuracy are critical.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured to use the `bioconda` and `conda-forge` channels.

```bash
# Install via conda
conda install bioconda::ms2rescore-rs

# Install via mamba (recommended for speed)
mamba install bioconda::ms2rescore-rs
```

## Common CLI Patterns
While `ms2rescore-rs` often acts as a backend for the broader MS²Rescore Python package, it can be invoked directly for specific processing tasks.

### Basic Execution
The tool typically requires input PSM files (e.g., from search engines like Mascot, Tandem, or MaxQuant) and corresponding spectrum files (MGF, mzML).

```bash
# General execution pattern
ms2rescore-rs --psm-file <path_to_psms> --spectrum-file <path_to_spectra> --output <output_prefix>
```

### Performance Optimization
Since the tool is written in Rust, it supports efficient multi-threading. Use the threads flag to match your hardware capabilities.

```bash
# Specify the number of threads for parallel processing
ms2rescore-rs -t 8 --psm-file input.idXML --spectrum-file data.mzML
```

## Expert Tips
- **Platform Support**: Note that while Linux (x86_64 and aarch64) and macOS (ARM/M1/M2) are fully supported in the latest versions, Intel-based macOS support is limited to older versions (0.2.0 and below).
- **Integration**: This tool is often used in conjunction with the `ms2pip` and `DeepLC` predictors. Ensure these are available in your path if you are running a full rescoring pipeline that requires fragment ion or retention time predictions.
- **Memory Management**: For extremely large mzML files, ensure you have sufficient RAM, as the Rust backend optimizes for speed by keeping necessary indices in memory.

## Reference documentation
- [ms2rescore-rs Overview](./references/anaconda_org_channels_bioconda_packages_ms2rescore-rs_overview.md)
- [CompOmics ms2rescore-rs GitHub](./references/github_com_CompOmics_ms2rescore-rs.md)