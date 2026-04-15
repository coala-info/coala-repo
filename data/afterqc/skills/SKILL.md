---
name: afterqc
description: AfterQC performs automated quality control, filtering, adapter trimming, and error correction for FASTQ sequencing data. Use when user asks to preprocess Illumina reads, detect bubble artifacts, correct mismatched bases in paired-end overlaps, or generate quality reports.
homepage: https://github.com/OpenGene/AfterQC
metadata:
  docker_image: "quay.io/biocontainers/afterqc:0.9.7--py27_0"
---

# afterqc

## Overview

AfterQC is a specialized tool for the automated preprocessing of FASTQ files, primarily targeting Illumina sequencing data (1.8 or newer). It streamlines the transition from raw sequencer output to analysis-ready data by performing quality filtering, adapter trimming, and error removal in a single execution. The tool is unique for its ability to detect "bubble artifacts" caused by fluid dynamics issues in the sequencer and its capacity to correct mismatched bases in the overlapped regions of paired-end reads.

## Installation and Performance

AfterQC is available via Bioconda and is compatible with both CPython and PyPy.

- **Installation**: `conda install bioconda::afterqc`
- **Performance Tip**: Use **PyPy** instead of standard Python to run the script. PyPy typically makes AfterQC 3x faster.
  - Example: `pypy after.py [options]`

## Common CLI Patterns

### 1. Automated Folder Processing
AfterQC can scan an entire directory and process all FASTQ files automatically. By default, it looks for `*R1*` and `*R2*` patterns.

```bash
# Process all files in the current directory
python after.py

# Process a specific input directory
python after.py -d /path/to/fastq_folder
```

### 2. Single-End and Paired-End Processing
To process specific files rather than a whole folder:

```bash
# Single-end
python after.py -1 sample_R1.fq

# Paired-end
python after.py -1 sample_R1.fq -2 sample_R2.fq
```

### 3. Quality Control Only
If you only need the statistical reports and figures without generating new filtered FASTQ files:

```bash
python after.py --qc_only
```

### 4. Handling Compressed Data
AfterQC supports Gzip and Bzip2 input. If the input is gzipped, the output will be gzipped by default.

```bash
# Force gzip output for non-gzipped input
python after.py -1 sample.fq -z

# Adjust compression level (0-9, default is 2)
python after.py -1 sample.fq -z --compression=5
```

## Expert Configuration and Best Practices

### Trimming and Filtering
- **Auto-Trimming**: Set `-f` (front) or `-t` (tail) to `-1` to allow AfterQC to automatically detect the number of bases to trim based on the QC results.
- **Poly-X Filtering**: By default, AfterQC filters reads with polyX (e.g., PolyG) sequences longer than 35bp. Adjust this with `-p`.
- **Quality Thresholds**: Use `-q` to set the Phred score qualified level (default 20) and `-u` to set the limit of unqualified bases allowed before a read is discarded.

### Paired-End Overlap Correction
One of AfterQC's strongest features is correcting low-quality bases in the overlapped regions of paired-end reads. This is enabled by default. If the bases in the overlap do not match, AfterQC uses the high-quality base to correct the low-quality one.

### Output Structure
AfterQC generates three distinct folders in the output directory:
- `good/`: Contains the filtered and trimmed FASTQ files.
- `bad/`: Contains the reads that failed the quality filters.
- `QC/`: Contains the HTML reports and JSON statistics.

### Successor Tool
For users requiring significantly higher performance (multithreading in C++), the author of AfterQC recommends using **fastp**, which implements many of the same algorithms with much higher throughput.

## Reference documentation
- [AfterQC GitHub Repository](./references/github_com_OpenGene_AfterQC.md)
- [AfterQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_afterqc_overview.md)