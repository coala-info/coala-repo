---
name: lra
description: lra (Long Read Aligner) is a specialized tool designed for the alignment of long reads from single-molecule sequencing (SMS) platforms and megabase-scale assembly contigs.
homepage: https://github.com/ChaissonLab/LRA
---

# lra

## Overview
lra (Long Read Aligner) is a specialized tool designed for the alignment of long reads from single-molecule sequencing (SMS) platforms and megabase-scale assembly contigs. It utilizes a two-tiered seeding strategy—combining global minimizer-based seeds with local refinement using smaller matches—and a concave gap function. This approach makes it highly sensitive to structural variations, especially in Oxford Nanopore (ONT) datasets and de novo assemblies, where it often outperforms general-purpose aligners in SV detection accuracy.

## Installation
The recommended way to install lra is via Bioconda:
```bash
conda install -c bioconda lra
```

## Core Workflow

### 1. Indexing the Reference
Before alignment, you must generate a two-tiered index. You must specify the data type to optimize the index parameters.

```bash
# Syntax: lra index -[MODE] <reference.fa>
lra index -ONT hg38.fa
```

**Available Modes:**
- `-CCS`: PacBio HiFi/Circular Consensus Sequencing
- `-CLR`: PacBio Continuous Long Reads
- `-ONT`: Oxford Nanopore Technologies reads
- `-CONTIG`: Megabase-scale assembly contigs

### 2. Aligning Reads
Align your sequences using the same mode used for indexing.

```bash
# Syntax: lra align -[MODE] <reference.fa> <reads.fa/fq/bam> -t <threads> -p <format>
lra align -ONT hg38.fa reads.fastq -t 16 -p s > output.sam
```

**Output Format Options (`-p`):**
- `s`: SAM format (default)
- `p`: PAF format
- `b`: BED format
- `a`: Pairwise alignment

## Expert Tips and Best Practices

### Mode Selection
Always match the mode to your input data's error profile and length:
- Use **-CCS** for high-accuracy long reads (HiFi).
- Use **-ONT** or **-CLR** for noisier raw reads.
- Use **-CONTIG** when aligning assembled sequences to a reference to maximize sensitivity for large-scale rearrangements.

### Handling Compressed Inputs
lra can accept input from stdin, which is useful for gzipped files:
```bash
zcat reads.fastq.gz | lra align -ONT ref.fa /dev/stdin -t 16 -p s > output.sam
```

### Interpreting Custom Tags
lra adds specific tags to SAM/PAF output that are useful for downstream SV filtering:
- `NM`: Total edit distance (mismatches + indels).
- `NX`: Number of mismatches.
- `NI` / `ND`: Total bases of insertions / deletions.
- `TI` / `TD`: Total number of insertion / deletion events.
- `TP`: Type of alignment (P=Primary, S=Secondary, I=Inversion).
- `AO`: Order of the segment in a split-read alignment.

### Performance Optimization
- **Multithreading**: Use the `-t` flag to scale with available CPU cores. Alignment is the most computationally intensive step.
- **Memory**: Indexing a human-scale genome typically takes a few minutes; ensure sufficient RAM is available for the two-tiered minimizer index.

## Reference documentation
- [LRA GitHub Repository](./references/github_com_ChaissonLab_LRA.md)
- [LRA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lra_overview.md)