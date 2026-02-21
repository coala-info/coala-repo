---
name: nomadic
description: Nomadic is designed for mobile, real-time analysis of nanopore sequencing data, specifically optimized for amplicon sequencing protocols like NOMADS-MVP.
homepage: https://jasonahendry.github.io/nomadic/
---

# nomadic

## Overview
Nomadic is designed for mobile, real-time analysis of nanopore sequencing data, specifically optimized for amplicon sequencing protocols like NOMADS-MVP. It automates the transition from raw FASTQ files to actionable insights by performing read mapping, quality control, and variant calling while the sequencer is still running. It provides a graphical dashboard to monitor experiment progress and visualize within-sample allele frequencies (WSAF).

## Core Workflows

### 1. Workspace Initialization
Before running any analysis, you must establish a structured directory.
```bash
# Create a new workspace (e.g., for P. falciparum)
nomadic start pfalciparum
cd nomadic
```
The workspace contains three critical directories:
- `beds/`: Genomic regions of interest.
- `metadata/`: CSV/Excel files linking barcodes to sample IDs.
- `results/`: Output data.

### 2. Real-time Analysis
To analyze data as it is produced by MinKNOW:
1. Place a metadata CSV (barcode, sample_id) in the `metadata/` folder.
2. Ensure the experiment name matches the metadata filename.
3. Run the real-time command:
```bash
nomadic realtime <experiment_name>
```
**Key Options:**
- `-b`: Specify the amplicon panel (e.g., `nomads8` or `nomadsMVP`).
- `-r`: Choose reference genome (e.g., `Pf3D7`, `Pv`, `Hs`).
- `-c`: Enable preliminary variant calling (biallelic SNPs).
- `--workspace`: Path to workspace if not in the current directory.

### 3. Post-Experiment Visualization
To view results after sequencing is complete without re-running the pipeline:
```bash
nomadic dashboard <experiment_name>
```

### 4. Data Management
Nomadic includes built-in utilities for backing up and sharing results.
```bash
# Backup workspace and MinKNOW data to external storage
nomadic backup -t /path/to/backup

# Share only summary CSVs and metadata for dashboard viewing
nomadic share -t /path/to/shared_folder

# Configure defaults to avoid typing paths repeatedly
nomadic configure backup -t /path/to/backup
```

## Expert Tips & Best Practices
- **Resuming Runs**: If a run is interrupted, `nomadic realtime` can be restarted safely. It tracks processed FASTQ files and resumes where it left off. Use the `--resume` flag if you need to force a restart on an existing output directory.
- **Parallel Instances**: You can run multiple `nomadic process` instances simultaneously, but only one instance of `nomadic realtime` or `nomadic dashboard` can serve the web interface at a time.
- **Interpreting WSAF**: In the dashboard heatmap, a WSAF of 1.0 (dark red) indicates a homozygous mutation, while values between 0 and 1 (yellow/orange) indicate polyclonality in malaria samples.
- **Custom Panels**: For non-standard organisms, use the `-b` flag to point to a custom BED file specifying your genomic regions of interest.

## Reference documentation
- [Basic Usage](./references/jasonahendry_github_io_nomadic_basic.md)
- [Advanced Usage](./references/jasonahendry_github_io_nomadic_advanced.md)
- [Output Files](./references/jasonahendry_github_io_nomadic_output_files.md)
- [Understanding the Dashboard](./references/jasonahendry_github_io_nomadic_understand.md)
- [Sharing and Backing up](./references/jasonahendry_github_io_nomadic_share_backup.md)