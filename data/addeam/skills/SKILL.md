---
name: addeam
description: AdDeam estimates and analyzes post-mortem DNA damage profiles from sequencing data to distinguish between ancient DNA and modern contamination. Use when user asks to detect C->T transitions in BAM files, generate damage profiles for metagenomic assemblies, or cluster sequences based on damage characteristics.
homepage: https://github.com/LouisPwr/AdDeam
metadata:
  docker_image: "quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0"
---

# addeam

## Overview

AdDeam (Ancient DNA Damage Estimation and Analysis) is a specialized toolkit for processing sequencing data to detect post-mortem DNA damage, specifically C->T transitions. It transforms raw alignment data (BAM files) into statistical damage profiles. By utilizing a "Meta Mode," it can generate individual profiles for every contig or scaffold in a metagenomic assembly, allowing researchers to identify which specific parts of a sample are authentically ancient and which represent modern contamination through automated clustering.

## Core Workflow

### 1. Prepare BAM Files
Ensure all input BAM files are sorted and contain **MD tags** (mismatch annotations). If MD tags are missing, generate them using `samtools`:

```bash
samtools calmd -b input.bam reference.fasta > output_with_md.bam
```

### 2. Generate Damage Profiles
Use `addeam-bam2prof.py` to process a list of BAM files.

**Basic Usage:**
```bash
python addeam-bam2prof.py -o output_profiles_dir list_of_bams.txt
```

**Key Execution Patterns:**
- **Classic Mode**: Use `-classic` to generate one profile per BAM file (best for single-source samples).
- **Meta Mode**: Use `-meta` to generate individual profiles for every reference/contig (best for metagenomics).
- **Performance Tuning**: 
    - Use `-threads <int>` to process multiple files in parallel.
    - Use `-precision 0.01` or `0.001` to speed up analysis on large files by enabling early convergence checks.
- **Library Specifics**: 
    - Use `-single` for single-strand libraries.
    - Use `-double` for double-strand libraries.
    - Use `-both` to report both C->T and G->A transitions.

### 3. Cluster and Visualize
Use `addeam-cluster.py` to analyze the generated `.prof` files.

**Basic Usage:**
```bash
python addeam-cluster.py -i output_profiles_dir -o plots_dir
```

**Advanced Clustering:**
- **Cluster Count**: By default, the tool generates reports for k=2, 3, and 4 clusters.
- **Output Interpretation**:
    - **PDF Reports**: Visual summaries of damage for each cluster.
    - **GMM Directory**: Contains TSV files with probability assignments (which sample belongs to which cluster).
    - **PCA Directory**: Visual separation of samples based on damage characteristics.

## Expert Tips and Best Practices

- **Early Stopping**: For very large datasets, set `-minAligned` (e.g., 1,000,000) and `-minConverge` (e.g., 0.01). AdDeam will stop processing a file once the damage profile stabilizes, significantly reducing runtime without losing accuracy.
- **Filtering**: Use `-minq` (base quality) and `-minl` (read length, default 35) to exclude low-quality data that might skew damage estimates.
- **Handling Contamination**: In metagenomic contexts, look for clusters with near-zero damage profiles in the GMM output; these typically represent modern contaminants or poorly aligned reads.
- **Binary Pathing**: If the tool cannot find the underlying `bam2prof` C++ binary, explicitly provide the path using `--bam2profpath /path/to/binary`.



## Subcommands

| Command | Description |
|---------|-------------|
| addeam-bam2prof.py | Python wrapper for bam2prof |
| addeam-cluster.py | Cluster and plot damage profiles. |
| samtools | Tools for alignments in the SAM format |

## Reference documentation

- [AdDeam Repository Overview](./references/github_com_LouisPwr_AdDeam_blob_main_README.md)
- [Damage Profile Generation (addeam-bam2prof.py)](./references/github_com_LouisPwr_AdDeam_blob_main_addeam-bam2prof.py.md)
- [Clustering and Visualization (addeam-cluster.py)](./references/github_com_LouisPwr_AdDeam_blob_main_addeam-cluster.py.md)