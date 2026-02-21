---
name: leviosam2
description: LevioSAM2 is a specialized toolkit for migrating genomic data across reference assemblies using chain files.
homepage: https://github.com/milkschen/leviosam2
---

# leviosam2

## Overview
LevioSAM2 is a specialized toolkit for migrating genomic data across reference assemblies using chain files. While traditional liftover tools often focus on simple coordinate transformation, LevioSAM2 provides a comprehensive solution for sequence alignments, ensuring that read flags, CIGAR strings, and mate-pair relationships are correctly updated to reflect the target reference. Use this skill when you need to re-map data to a newer assembly (e.g., GRCh37 to GRCh38) without losing the context of the original alignments.

## Installation
Install leviosam2 via Bioconda for the most stable environment:
```bash
conda create -n leviosam2 -c bioconda -c conda-forge leviosam2
conda activate leviosam2
```

## Core Workflow

### 1. Index the Chain File
Before lifting alignments, you must generate a LevioSAM2 index (`.clft`) from a UCSC-style chain file.
```bash
leviosam2 index -c source_to_target.chain -p source_to_target -F target.fai
```
*   `-c`: Path to the input chain file.
*   `-p`: Prefix for the output index.
*   `-F`: FAI index of the target reference genome.

### 2. Lift Alignments
Perform the coordinate conversion on aligned reads.
```bash
leviosam2 lift -C source_to_target.clft -a aligned_to_source.bam -p lifted_from_source -O bam
```
*   `-C`: The `.clft` index created in the previous step.
*   `-a`: Input SAM/BAM/CRAM file.
*   `-p`: Output prefix.
*   `-O`: Output format (sam, bam, or cram).

### 3. Selective Re-mapping (Advanced)
For higher accuracy, especially when there are significant differences between assemblies, use the selective re-mapping workflow. This identifies reads that map poorly after liftover and re-aligns them to the target reference.
```bash
sh leviosam2.sh \
    -a bowtie2 \
    -i aligned_to_source.bam \
    -o lifted_output \
    -f target.fna \
    -b bt2_index/target \
    -C source_to_target.clft \
    -t 16
```

## Best Practices and Expert Tips
*   **Pre-sort Input**: Always sort your input BAM file by position before running `leviosam2 lift` to ensure optimal performance and compatibility.
*   **Memory Efficiency**: LevioSAM2 is designed to be memory-efficient, but indexing very large, complex chain files may require significant RAM.
*   **Tag Updates**: By default, the tool updates `MD:Z` and `NM:i` tags. If your downstream analysis relies on these, ensure you provide the target reference fasta during the lift or re-mapping phase.
*   **Mate Information**: When working with paired-end data, LevioSAM2 can update `RNEXT`, `PNEXT`, and `TLEN`. Ensure the input BAM has proper mate information fixed (e.g., via `samtools fixmate`) if the liftover results show inconsistencies.
*   **Multithreading**: Use the `-t` flag in the shell workflow or ensure your environment allows for multi-core execution to significantly speed up the liftover of large CRAM/BAM files.

## Reference documentation
- [LevioSAM2 GitHub Repository](./references/github_com_milkschen_leviosam2.md)
- [Bioconda LevioSAM2 Package](./references/anaconda_org_channels_bioconda_packages_leviosam2_overview.md)