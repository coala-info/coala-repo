---
name: toulligqc
description: ToulligQC is a specialized post-sequencing quality control tool tailored for the Oxford Nanopore ecosystem.
homepage: https://github.com/GenomicParisCentre/toulligQC
---

# toulligqc

## Overview

ToulligQC is a specialized post-sequencing quality control tool tailored for the Oxford Nanopore ecosystem. It transforms raw sequencing metrics into actionable insights, producing HTML reports that detail flow cell performance, read length distributions, and basecall quality. It is particularly useful for validating run success, identifying potential sequencing artifacts, and managing barcoded or 1D² library preparations.

## Installation

The recommended way to manage ToulligQC is via `uv` for speed and environment isolation:

```bash
git clone https://github.com/GenomicParisCentre/toulligQC.git
cd toulligqc
uv sync
# Run via uv
uv run toulligqc [options]
```

Alternatively, install via pip: `pip install toulligqc` or conda: `conda install -c bioconda toulligqc`.

## Common CLI Patterns

### Standard QC (Guppy/Dorado Output)
The most efficient way to run ToulligQC is by providing the sequencing summary and telemetry files generated during basecalling.

```bash
toulligqc -a sequencing_summary.txt -t sequencing_telemetry.js --output-directory ./qc_results
```

### QC from FASTQ or BAM
If the sequencing summary is unavailable, ToulligQC can extract metrics directly from sequence files.

```bash
# From FASTQ
toulligqc -q reads.fastq.gz --output-directory ./qc_results

# From BAM
toulligqc -u alignment.bam --output-directory ./qc_results
```

### Barcoded Runs
To analyze specific barcodes, provide a comma-separated list. ToulligQC supports naming schemes like BCXX, RBXX, NBXX, and barcodeXX (case-insensitive).

```bash
toulligqc -a sequencing_summary.txt -l BC01,BC02,BC03 --output-directory ./barcoded_qc
```

### 1D² Analysis
For 1D² runs, include the specific 1D² summary file.

```bash
toulligqc -a sequencing_summary.txt -d sequencing_1dsq_summary.txt -t sequencing_telemetry.js --output-directory ./1d2_qc
```

## Expert Tips and Best Practices

- **Telemetry Importance**: Always provide the `sequencing_telemetry.js` file (or a FAST5/POD5 file via `-f` or `-p`) if possible. This allows ToulligQC to retrieve critical metadata like Flow Cell ID and Kit versions, which are essential for accurate reporting.
- **Directory Organization**: For complex runs, organize your data into a `RUN_ID` folder containing the summary and telemetry files. ToulligQC is optimized to look for these standard outputs.
- **Q-Score Filtering**: Use the `--qscore-threshold` (default is often 7 or 10 depending on the basecaller) to align the QC report with your specific project requirements for "pass" vs "fail" reads.
- **Resource Management**: For large datasets, use the `--thread` option to speed up processing, especially when extracting data from FASTQ or BAM files.
- **Output Customization**: Use `-n` to give your report a specific name and `-o` to define a custom path for the HTML file if the default `toulligqc_report.html` is not desired.

## Reference documentation

- [ToulligQC GitHub README](./references/github_com_GenomiqueENS_toulligQC.md)
- [Bioconda ToulligQC Overview](./references/anaconda_org_channels_bioconda_packages_toulligqc_overview.md)