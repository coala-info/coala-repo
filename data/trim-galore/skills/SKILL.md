---
name: trim-galore
description: Trim Galore!
homepage: https://github.com/FelixKrueger/TrimGalore
---

# trim-galore

## Overview
Trim Galore! is a Perl-based wrapper script that streamlines the pre-processing of FastQ files. It automates quality trimming and adapter removal by leveraging Cutadapt, and optionally runs FastQC for immediate post-processing quality reports. Its primary strength lies in its ability to automatically detect adapter sequences and its specialized logic for bisulfite-treated (RRBS) sequencing data.

## Installation
The most reliable way to install Trim Galore and its dependencies (Cutadapt and FastQC) is via Bioconda:
```bash
conda install -c bioconda trim-galore
```

## Common CLI Patterns

### Basic Single-End Trimming
Automatically detect the adapter and trim reads with a default Phred score threshold of 20:
```bash
trim_galore sample.fastq.gz
```

### Paired-End Trimming
Use the `--paired` flag to ensure both reads are kept in sync. If one read becomes too short, both are discarded (or moved to unpaired files):
```bash
trim_galore --paired sample_R1.fastq.gz sample_R2.fastq.gz
```

### Standard Production Workflow
A common robust command including compression, multi-core support, and post-trimming QC:
```bash
trim_galore --paired --gzip --fastqc --cores 4 sample_R1.fastq.gz sample_R2.fastq.gz
```

## Expert Tips and Best Practices

### RRBS (Reduced Representation Bisulfite Sequencing)
Trim Galore has built-in logic to remove the specialized "filled-in" cytosines that can interfere with methylation analysis.
- **Standard RRBS**: `trim_galore --rrbs sample.fastq.gz`
- **Non-directional RRBS**: `trim_galore --rrbs --non_directional sample.fastq.gz` (removes an additional 2bp from the 5' end of the second read).

### Handling Stringency
By default, Trim Galore requires only 1bp of overlap with an adapter sequence to trim it. To be more conservative and reduce false positives in short-read data, increase the stringency:
```bash
trim_galore --stringency 3 sample.fastq.gz
```

### Output Management
To keep your working directory clean, always specify an output directory:
```bash
trim_galore --paired -o ./trimmed_reads/ sample_R1.fastq.gz sample_R2.fastq.gz
```

### Dealing with Short Reads
If your downstream aligner requires a minimum read length, use the `--length` parameter (default is 20bp):
```bash
trim_galore --length 35 sample.fastq.gz
```

### Manual Adapter Specification
While auto-detection is reliable, you can manually specify adapters if you are using custom libraries:
- **Illumina**: `AGATCGGAAGAGC` (Default)
- **Small RNA**: `TGGAATTCTCGG`
- **Nextera**: `CTGTCTCTTATA`

## Reference documentation
- [Trim Galore GitHub Repository](./references/github_com_FelixKrueger_TrimGalore.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_trim-galore_overview.md)