---
name: moff
description: moFF extracts MS1 apex intensities for identified peptides and performs retention time alignment for match-between-runs quantification. Use when user asks to extract peptide intensities, perform match between runs, or quantify proteomics data across multiple samples.
homepage: https://github.com/compomics/moFF
metadata:
  docker_image: "quay.io/biocontainers/moff:2.0.3--4"
---

# moff

## Overview

moFF (A modest Feature Finder) is a specialized proteomics tool designed to extract apex MS1 intensities using identified MS2 peptides as a guide. It bridges the gap between peptide identification and quantification by locating the most intense signal in the MS1 spectrum corresponding to a known peptide. Its modular design allows for standalone apex intensity extraction or a combined workflow including "Match Between Runs" (MBR), which uses retention time alignment to quantify peptides across multiple samples even when they weren't identified by MS2 in every run.

## Installation and Environment

moFF is available via Bioconda. For Linux and macOS users, this is the recommended installation method as it handles complex dependencies like Mono (required for Thermo RAW file parsing on non-Windows systems).

```bash
conda install -c bioconda moff
```

**Key Requirements:**
- **Python 3.6+**
- **Mono (v4.2.1+)**: Essential for Linux users to process Thermo RAW files.
- **.NET Framework 4.6.2**: Required for Windows users.

## Input Data Requirements

moFF requires two primary inputs:
1.  **Spectral Data**: Thermo RAW files or mzML files.
2.  **Peptide Information**: A tab-delimited text file (or PeptideShaker export) containing:
    - `peptide`: Sequence
    - `prot`: Protein ID
    - `mod_peptide`: Sequence with modifications (e.g., `NH2-M<Mox>LTKFESK-COOH`)
    - `rt`: Retention time **in seconds**
    - `mz`: Mass-to-charge ratio
    - `mass`: Peptide mass
    - `charge`: Ion charge

## Common CLI Patterns

### Running the Full Pipeline
The most efficient way to run moFF is using the `moff_all.py` script, which handles both MBR and apex intensity extraction.

```bash
python moff_all.py --config_file path/to/config.ini
```

### Match Between Runs (MBR) Only
To align retention times and identify features across replicates without performing the final intensity extraction immediately:

```bash
python moff_mbr.py --loc_in <input_folder> --mbr only --ext .txt
```
*Note: The output will be stored in a `mbr_output` subfolder within your input directory.*

### Apex Intensity Extraction Only
To extract intensities for a specific set of identified peptides:

```bash
python moff.py --input <peptide_file> --raw <raw_file_or_folder>
```

## Expert Tips and Best Practices

- **Retention Time Units**: Ensure your input `rt` column is in **seconds**. A common error is providing minutes, which will result in failed feature detection.
- **File Extensions**: When using `--loc_in`, moFF defaults to looking for `.txt` files. If your identification files use a different extension (like `.tsv`), specify it using the `--ext` flag.
- **Filtering Outliers**: When running MBR, use the `--out_flag` (default True) and `--w_filt` (default 3) to control the stringency of the retention time alignment and filter out low-quality matches.
- **Direct RAW Access**: moFF uses the `txic_json.exe` utility internally to read Thermo RAW files directly. If you encounter errors on Linux, verify that `mono` is in your system PATH.
- **PeptideShaker Integration**: moFF is designed to work seamlessly with PeptideShaker. You can use the default PSM export from PeptideShaker as your input file without manual reformatting.

## Reference documentation
- [moFF GitHub Repository](./references/github_com_CompOmics_moFF.md)
- [moFF Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_moff_overview.md)