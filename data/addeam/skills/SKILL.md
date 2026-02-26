---
name: addeam
description: AdDeam characterizes nucleotide misincorporation patterns in ancient DNA and clusters sequences based on their degradation profiles. Use when user asks to estimate ancient DNA damage, generate damage profiles from BAM files, or cluster metagenomic sequences by degradation levels.
homepage: https://github.com/LouisPwr/AdDeam
---


# addeam

## Overview

AdDeam (Ancient DNA Damage Estimation and Management) is a high-performance toolkit designed to characterize nucleotide misincorporation patterns—the hallmark of ancient DNA. It processes BAM files to generate damage profiles and employs unsupervised learning to group sequences with similar degradation levels. It is particularly powerful for metagenomic datasets where it can calculate damage for every individual reference (contig or scaffold) within a single BAM file, allowing researchers to identify which specific organisms in a sample are likely ancient.

## Core Workflow and CLI Usage

### 1. Mandatory Pre-processing
AdDeam requires BAM files to have **MD tags** (mismatch information) and recommends they be **sorted** for performance. If your BAM files lack MD tags, generate them using `samtools`:

```bash
samtools calmd -b input.bam reference.fasta > input_with_md.bam
```

### 2. Generating Damage Profiles
Use `addeam-bam2prof.py` to process a list of BAM files. The input should be a text file containing the full paths to your BAM files (one per line).

**Basic Command:**
```bash
python addeam-bam2prof.py -o profiles_output_dir list_of_bams.txt
```

**Key Parameters:**
- `-o`: Directory where `.prof` files will be stored.
- `--bam2profpath`: (Optional) Explicit path to the `bam2prof` binary if not in your PATH.
- `Meta Mode`: Automatically triggered if the BAM contains multiple references and you wish to analyze them individually.

### 3. Clustering and Visualization
Once profiles are generated, use `addeam-cluster.py` to perform Gaussian Mixture Model (GMM) clustering and Principal Component Analysis (PCA).

**Basic Command:**
```bash
python addeam-cluster.py -i profiles_output_dir -o results_plots_dir
```

**Key Parameters:**
- `-i`: The directory containing the `.prof` files generated in the previous step.
- `-o`: Output directory for reports and plots.

## Interpreting Results

The clustering step produces several critical outputs in the results directory:

- **PDF Damage Reports**: (e.g., `damage_report_k3.pdf`) Visualizes the PCA clusters and the representative damage profiles for each group.
- **Cluster Assignments**: Found in `GMM/kx/cluster_report_kx.tsv`. This file provides the probability of each sample/reference belonging to a specific cluster.
- **Excluded References**: A text file listing IDs that had insufficient data (aligned reads) to be reliably clustered.

## Expert Tips and Best Practices

- **Convergence Speed**: AdDeam uses an early stopping criterion. If a damage profile converges early, it will stop processing that BAM, significantly saving time on high-coverage samples.
- **Metagenomic Screening**: In "Meta Mode," use the TSV cluster reports to filter your assembly. Contigs assigned to the "high damage" cluster are your primary candidates for authentic ancient sequences.
- **MD Tag Piping**: You can pipe `samtools calmd` directly from aligners like `bwa` or `bowtie` to avoid creating massive intermediate files without MD tags.
- **K-selection**: By default, the tool generates reports for k=2, 3, and 4 clusters. Compare the PCA plots across these values to determine which grouping best represents the biological reality of your data (e.g., separating "undamaged," "low damage," and "high damage").

## Reference documentation
- [AdDeam GitHub Repository](./references/github_com_LouisPwr_AdDeam.md)
- [AdDeam Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_addeam_overview.md)