---
name: straitrazor
description: STRait Razor is a bioinformatic tool designed for the forensic analysis of genetic markers by identifying length-based and sequence-based alleles in raw sequencing data. Use when user asks to detect STR motifs, identify isoalleles, or process FASTQ files for forensic genetic marker analysis.
homepage: https://github.com/Ahhgust/STRaitRazor
metadata:
  docker_image: "quay.io/biocontainers/straitrazor:3.0.1--h7d875b9_3"
---

# straitrazor

## Overview

STRait Razor (Short Tandem Repeat Allele Identification Tool) is a specialized bioinformatic tool designed for the forensic analysis of genetic markers. It functions by searching raw sequencing data for specific motifs defined in configuration files, allowing for the detection of both length-based and sequence-based alleles. It is particularly useful for identifying isoalleles and stutter patterns that are often indistinguishable in traditional capillary electrophoresis. The tool is designed to be kit-agnostic, provided the user optimizes the configuration files for the specific chemistry being used.

## Installation and Setup

The most efficient way to install STRait Razor is via Bioconda:

```bash
conda install bioconda::straitrazor
```

The tool consists of two primary components that must work in tandem:
1.  **The Executable**: `str8rzr` (or `str8rzr.exe` on Windows).
2.  **The Configuration File**: A `.config` file that defines the loci, flanking sequences, and anchor motifs.

## Core Workflow

### 1. Configuration Selection
Before running the analysis, identify the correct configuration file for your sequencing kit. Standard configs included in the repository include:
*   `ForenSeqv1.27.config`
*   `PowerSeqv2.31.config`
*   `GFNGSv2_v7.1.config`
*   `IDseek` variants (Autosomal, SNP, YSTR)

### 2. Batch Processing
For most research and casework, use the provided batch scripts to process multiple FASTQ files simultaneously.

**Linux/macOS:**
Use `batchCstr8.bash`. Ensure the script has execution permissions:
```bash
chmod +x batchCstr8.bash
./batchCstr8.bash
```

**Windows:**
Use `batchCstr8.bat`. Place the batch file, the `str8rzr.exe`, the config file, and your FASTQ files in the same directory, then execute the batch file.

### 3. Output Analysis
The tool creates a unique directory for every processed FASTQ file. The primary output is:
*   **allsequences.txt**: A plain-text summary containing all detected STR/SNP data, including sequence strings and read counts.

## Expert Tips and Best Practices

*   **Config Optimization**: Do not assume a default config will work perfectly for a new chemistry. You must evaluate the tradeoff between locus size and throughput. Larger loci provide more information but may have fewer supporting reads.
*   **Compressed Files**: To process `.fastq.gz` files, ensure that `7zip` (Windows) or `gzip` (Linux/macOS) is installed and correctly configured in your system PATH.
*   **Genotype Calling**: STRait Razor identifies *apparent* alleles and stutter; it does not perform automated genotype calling or mixture deconvolution. For semi-automated genotyping, the output should be imported into STRait Razor Online (SRO).
*   **The -i Flag**: Use the `-i` flag if you need to specify an alternative input directory or handle specific indexing requirements as noted in recent updates.
*   **Directory Management**: When performing iterative analyses in the same folder, move previously analyzed FASTQ files to a sub-directory to prevent the batch script from re-processing them.

## Reference documentation

- [STRait Razor Overview](./references/anaconda_org_channels_bioconda_packages_straitrazor_overview.md)
- [STRait Razor GitHub Documentation](./references/github_com_Ahhgust_STRaitRazor.md)