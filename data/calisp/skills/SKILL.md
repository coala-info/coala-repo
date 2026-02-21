---
name: calisp
description: Calisp (Calgary approach to isotopes in proteomics) is a high-precision tool designed to quantify the isotopic composition of peptides.
homepage: https://github.com/kinestetika/Calisp
---

# calisp

## Overview

Calisp (Calgary approach to isotopes in proteomics) is a high-precision tool designed to quantify the isotopic composition of peptides. It bridges the gap between proteomics and isotope geochemistry by processing mass spectrometry spectra (.mzML) alongside peptide identifications. It utilizes Fast Fourier Transforms (FFT) for natural abundance calculations and neutron abundance methods for SIP experiments. Unlike previous versions, the current Python implementation preserves all sampled isotopic patterns to allow for more robust downstream statistical analysis and machine learning filtering.

## Command Line Usage

### Core Analysis
The primary command is `calisp.py`. It requires a spectrum file and a corresponding peptide identification file.

```bash
calisp.py --spectrum_file <path_to_mzML> --peptide_file <path_to_PSM> --output_file <output_dir>
```

### Key Arguments
- `--isotope`: Specify the target isotope. Options: `13C` (default), `14C`, `15N`, `17O`, `18O`, `2H`, `3H`, `33S`, `34S`, or `36S`.
- `--bin_delimiter`: Calisp expects protein IDs to follow a `BinID_ProteinID` format. If your data does not use bins, set this to `none`.
- `--mass_accuracy`: Set the m/z identification accuracy (default: `10` ppm).
- `--threads`: Number of CPU threads to use (default: `4`).
- `--compute_clumps`: Use this flag if you need to compute isotopic "clumpiness" (e.g., for specific geochemical applications).

### Post-Processing Workflow
Calisp outputs data in a binary `.feather` format (Pandas DataFrame). Use the included utility scripts to make the data human-readable and summarized.

1.  **Filter Patterns**: Remove noisy isotopic patterns and convert the binary output to CSV.
    ```bash
    calisp_filter_patterns <input.feather> <output.csv>
    ```
2.  **Compute Medians**: Generate summary statistics (medians) for each protein or bin.
    ```bash
    calisp_compute_medians <input.csv> <output_summary.csv>
    ```

## Expert Tips and Best Practices

- **Input Compatibility**: Calisp supports standard `.mzML` files and Peptide Spectrum Match files from tools like Thermo or FragPipe. Ensure your PSM files contain the necessary peptide sequences and protein mappings.
- **Performance Expectations**: The Python version of Calisp is thorough and does not pre-filter data. Expect processing times of approximately 5-10 minutes per `.mzML` file on standard hardware.
- **Binning Logic**: If working with Metagenome-Assembled Genomes (MAGs), ensure your protein headers in the PSM file use a consistent delimiter (e.g., `BinName_Gene123`). This allows Calisp to automatically aggregate isotope data at the organism/bin level.
- **Method Selection**: 
    - Use `ratio_fft` results for natural abundance or very low-label experiments (<1% enrichment).
    - Use `ratio_na` (neutron abundance) for standard Stable Isotope Probing (SIP) experiments.
- **Data Exploration**: Because the output is a Pandas DataFrame, you can load the `.feather` files directly into a Jupyter Notebook for custom visualization or machine learning applications.

## Reference documentation
- [Calisp GitHub Repository](./references/github_com_kinestetika_Calisp.md)
- [Bioconda Calisp Overview](./references/anaconda_org_channels_bioconda_packages_calisp_overview.md)