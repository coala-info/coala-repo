---
name: msproteomicstools
description: The `msproteomicstools` library is a specialized suite for mass spectrometry-based proteomics.
homepage: https://github.com/msproteomicstools/msproteomicstools
---

# msproteomicstools

## Overview
The `msproteomicstools` library is a specialized suite for mass spectrometry-based proteomics. It is primarily used in the post-processing pipeline of SWATH-MS data. Its core strengths lie in the TRIC (Targeted Retention Time Calibration) alignment tool, which allows for consistent feature mapping across multiple LC-MS/MS runs, and the TAPIR visualization engine for inspecting targeted proteomics results. It serves as a bridge between raw data extraction (like OpenSWATH) and downstream statistical analysis.

## Installation
Install the package via Bioconda or pip. Note that specific versions of dependencies like `pymzml` are often required for compatibility.

```bash
# Via Conda (Recommended)
conda install -c bioconda msproteomicstools

# Via pip
pip install numpy pymzml==0.7.8 Biopython
pip install msproteomicstools
```

## Core Components and CLI Usage

### TRIC Alignment
The TRIC alignment tool is located in the `analysis` directory. It is used to align targeted proteomics features across multiple runs to reduce missing values and improve quantification consistency.

*   **Primary Use Case**: Aligning OpenSWATH output files (.tsv or .sqlite).
*   **Key Parameters**:
    *   `--in`: Input files (OpenSWATH results).
    *   `--out`: Path for the aligned output file.
    *   `--method`: Alignment method (e.g., `realign` for non-linear alignment).
    *   `--fdr_cutoff`: Filter features based on a specific False Discovery Rate.
    *   `--max_rt_diff`: Maximum allowed retention time shift.

### TAPIR Visualization
TAPIR is a GUI-based tool for the visualization of chromatograms and peak groups.
*   **Execution**: Run the TAPIR executable found in the `gui` folder.
*   **Input**: Requires the transition list (Lib) and the extracted ion chromatograms (sqMass or mzML).

### Data Conversion and Utility Scripts
The `analysis` folder contains several scripts for preparing libraries and fixing metadata:
*   **tsv2spectrast.py**: Converts TSV-formatted transition lists into SpectraST-compatible formats.
*   **fix_swath_windows.py**: Corrects or modifies SWATH window settings in transition lists to ensure they match the experimental acquisition settings.

## Expert Tips
*   **Performance**: For large-scale alignments, ensure you have the "Fast lowess" implementation installed. This can speed up the TRIC alignment process by several orders of magnitude.
*   **Memory Management**: When processing hundreds of SWATH runs, prefer using the SQLite output format over TSV to manage memory and facilitate easier querying of aligned results.
*   **FDR Iteration**: If you encounter "Recursed too much in FDR iteration" errors, check your input data for highly skewed score distributions or insufficient decoy transitions.

## Reference documentation
- [msproteomicstools GitHub Repository](./references/github_com_msproteomicstools_msproteomicstools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_msproteomicstools_overview.md)