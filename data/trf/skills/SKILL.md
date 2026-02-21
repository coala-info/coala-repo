---
name: trf
description: The `trf` skill provides a specialized workflow for detecting tandem repeats—adjacent, approximate copies of a nucleotide pattern—within DNA sequences.
homepage: https://tandem.bu.edu/trf/trf.html
---

# trf

## Overview
The `trf` skill provides a specialized workflow for detecting tandem repeats—adjacent, approximate copies of a nucleotide pattern—within DNA sequences. It is essential for genomic annotation, satellite DNA analysis, and identifying microsatellites or minisatellites. This tool is highly efficient, capable of processing large sequences (e.g., 0.5Mb) in seconds, and detects patterns ranging from 1 to 2000 base pairs without requiring the user to pre-specify the pattern.

## Command Line Usage
The standard execution of TRF requires a FASTA file and seven numeric parameters that control the alignment scoring and detection thresholds.

### Basic Syntax
```bash
trf <File> <Match> <Mismatch> <Delta> <PM> <PI> <MinScore> <MaxPeriod> [options]
```

### Parameter Definitions
To achieve optimal results, use the following standard parameter values:
- **Match (2):** Alignment match score.
- **Mismatch (7):** Alignment mismatch penalty.
- **Delta (7):** Indel penalty.
- **PM (80):** Matching probability (percentage).
- **PI (10):** Indel probability (percentage).
- **MinScore (50):** Minimum alignment score to report a repeat.
- **MaxPeriod (500):** Maximum period size to check (up to 2000).

**Recommended "Standard" Command:**
```bash
trf sequence.fasta 2 7 7 80 10 50 500
```

## Expert Tips & Best Practices
- **Output Files:** TRF generates two primary outputs in the working directory:
  - `.dat` file: A summary table containing indices, period size, copy number, and consensus sequence.
  - `.html` file: A visualization of the alignments (if running in a web-enabled environment).
- **Large Scale Analysis:** For whole-genome processing, use a `MaxPeriod` of 2000 to capture larger satellite repeats, though this may increase processing time.
- **Sequence Masking:** TRF is often used as a pre-processing step to mask repetitive elements before performing sequence alignments or gene prediction.
- **Data Parsing:** The `.dat` file is the most useful for downstream bioinformatics pipelines. It contains a header for each sequence followed by rows of detected repeats.

## Reference documentation
- [Tandem Repeats Finder Overview](./references/tandem_bu_edu_trf_trf.html.md)
- [Bioconda TRF Package](./references/anaconda_org_channels_bioconda_packages_trf_overview.md)