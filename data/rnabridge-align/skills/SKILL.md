---
name: rnabridge-align
description: rnabridge-align determines the alignment of entire RNA fragments by bridging the gap between paired-end reads. Use when user asks to bridge paired-end RNA reads, calculate the most probable path connecting reads, or perform reference-guided fragment alignment.
homepage: https://github.com/Shao-Group/rnabridge-align
metadata:
  docker_image: "quay.io/biocontainers/rnabridge-align:1.0.1--h5ca1c30_9"
---

# rnabridge-align

## Overview
rnabridge-align is a specialized bioinformatics tool designed to determine the alignment of entire RNA fragments by bridging the gap between paired-end reads. While standard aligners (like STAR or HISAT2) map individual reads, rnabridge-align uses an efficient algorithm to calculate the most probable path connecting those reads. This process is essential for downstream applications that require full fragment context, such as transcript assembly or isoform quantification. It can operate de novo or leverage a reference transcriptome (GTF) to increase bridging accuracy.

## Installation
The most efficient way to install rnabridge-align is via Bioconda:
```bash
conda install bioconda::rnabridge-align
```

## Core Workflow and CLI Patterns

### 1. Pre-processing: Sorting
The input BAM file must be sorted by coordinate. If your aligner output is unsorted, use samtools:
```bash
samtools sort input.bam > input.sorted.bam
```

### 2. Library Type Inference
Before running a full alignment, use the `--preview` flag to check the inferred library type and fragment length range.
```bash
rnabridge-align -i input.sorted.bam -o preview.bam --preview
```
*Note: Inference relies on the `XS` tag in the BAM file. If your BAM lacks `XS` tags, you must specify the library type manually.*

### 3. Standard Bridging
Run the tool by providing the sorted input and a target output path.
```bash
rnabridge-align -i input.sorted.bam -o output.bridged.bam --library_type first
```

### 4. Reference-Guided Bridging
To significantly improve accuracy, provide a reference transcriptome in GTF format:
```bash
rnabridge-align -i input.sorted.bam -o output.bridged.bam -r reference.gtf --library_type first
```

## Parameter Tuning for Experts

| Parameter | Default | Expert Guidance |
| :--- | :--- | :--- |
| `--library_type` | empty | Choose from `unstranded`, `first` (fr-firststrand), or `second` (fr-secondstrand). Manual specification is safer than auto-inference. |
| `--min_bridging_score` | 0.5 | Increase this value (e.g., 0.7) to be more conservative, requiring higher confidence to bridge a fragment. |
| `--dp_solution_size` | 10 | Number of candidate bridging paths. Increase for complex regions with many overlapping isoforms. |
| `--min_splice_boundary_hits` | 1 | Increase to 2 or 3 for high-depth data to filter out noise and spurious junctions. |

## Best Practices
- **Library Type Mapping**: 
  - `first` corresponds to Illumina `fr-firststrand` (e.g., TruSeq Stranded).
  - `second` corresponds to Illumina `fr-secondstrand`.
- **Memory Management**: For very large BAM files, ensure your environment has sufficient RAM, as the tool maintains weights for multiple bridging paths.
- **CIGAR Strings**: The tool ignores reads with CIGAR strings longer than 1000 by default (`--max_num_cigar`). If working with long-read hybrid data, you may need to adjust this.

## Reference documentation
- [rnabridge-align GitHub Repository](./references/github_com_Shao-Group_rnabridge-align.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_rnabridge-align_overview.md)