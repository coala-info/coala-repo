---
name: emeraldbgc
description: `emeraldbgc` is a specialized tool for the detection of Small Molecule Biosynthetic Gene Clusters (SMBGCs).
homepage: https://github.com/Finn-Lab/emeraldBGC
---

# emeraldbgc

## Overview

`emeraldbgc` is a specialized tool for the detection of Small Molecule Biosynthetic Gene Clusters (SMBGCs). It utilizes genomic sequence data and protein domain annotations to identify potential clusters, providing a probability score and identifying the nearest known cluster in the MiBIG space using Dice dissimilarity coefficients. While the project has been deprecated in favor of its successor, SanntiS, `emeraldbgc` remains a standard tool for legacy workflows requiring GFF3-formatted cluster predictions.

## Installation and Setup

The tool is primarily distributed via Bioconda and requires a Linux/Unix-like environment due to its dependency on InterProScan.

```bash
# Create and activate environment
conda create -n emeraldbgc emeraldbgc
conda activate emeraldbgc

# Install the package
conda install -c bioconda emeraldbgc
```

## Command Line Usage

### Basic Detection
To run a basic detection on a genomic FASTA file:
```bash
emeraldbgc path/to/sequence.fna
```

### Using Pre-computed InterProScan Results
For more accurate results or when running on non-Linux systems (where InterProScan cannot run natively), provide a TSV or GFF3 file from InterProScan and a corresponding GenBank file:
```bash
emeraldbgc --ip-file annotations.gff3 sequence.gb
```

## Output Interpretation

The tool produces a GFF3 file. Key attributes in the 9th column include:

*   **score**: The post-processing probability of the region being a cluster.
*   **nearest_MiBIG**: The accession ID of the most similar BGC in the MiBIG database.
*   **nearest_MiBIG_diceDistance**: The Dice dissimilarity coefficient (lower values indicate higher similarity).
*   **partial**: A two-digit binary flag (e.g., `10`). The first digit represents the 5' end and the second represents the 3' end. `1` indicates the cluster is truncated by the contig edge.

## Expert Tips and Best Practices

*   **InterProScan Version**: Ensure InterProScan is version 5.52-86.0 or higher for compatibility.
*   **Input Consistency**: When using `--ip-file`, the sequence IDs in the InterProScan file must match the IDs in the GenBank/FASTA file.
*   **Docker Alternative**: If local installation of InterProScan is problematic (due to its ~24GB size), use the Docker image `quay.io/microbiome-informatics/emerald-bgc`.
*   **Transition Note**: For new projects, consider using SanntiS, as it is the maintained successor to this tool.

## Reference documentation
- [emeraldbgc - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_emeraldbgc_overview.md)
- [Finn-Lab/emeraldBGC: SMBGC detection tool](./references/github_com_Finn-Lab_emeraldBGC.md)