---
name: bamcmp
description: bamcmp deconvolves host and graft reads in chimeric samples by comparing alignments from the same sequencing library against two different reference genomes. Use when user asks to separate human and mouse reads in PDX samples, resolve mapping conflicts between two species, or categorize reads as unique, better, or ambiguous based on alignment scores.
homepage: https://github.com/CRUKMI-ComputationalBiology/bamcmp
metadata:
  docker_image: "quay.io/biocontainers/bamcmp:2.2--h9948957_7"
---

# bamcmp

## Overview

bamcmp is a specialized tool for deconvolving host and graft reads in chimeric samples, such as Patient-Derived Xenografts (PDX). It works by comparing the same sequencing library aligned to two different reference genomes. By evaluating full-length alignments and their respective scores, bamcmp determines the most likely origin for each read. A key advantage of this tool is its ability to resolve conflicts at the individual read level rather than the fragment level for paired-end data, which allows for higher data retention even when one read in a pair has a weak match.

## Installation

Install bamcmp via Bioconda:

```bash
conda install bioconda::bamcmp
```

## Core Usage and CLI Patterns

The basic syntax requires two input BAM files (one for each species) and several output flags to categorize the results.

### Basic Command Template
```bash
bamcmp -n \
  -1 species1_aligned.bam -2 species2_aligned.bam \
  -a species1_unique.bam -A species1_better.bam -C species1_ambiguous.bam \
  -b species2_unique.bam -B species2_better.bam -D species2_ambiguous.bam \
  -s [scoring_method]
```

### Parameter Breakdown
- `-n`: Process files sorted by read name.
- `-1` / `-2`: Input BAM files for the two species (e.g., human and mouse).
- `-a` / `-b`: Output BAMs for reads mapping uniquely to species 1 or species 2.
- `-A` / `-B`: Output BAMs for reads mapping to both, but with a "better" score in one species.
- `-C` / `-D`: Output BAMs for reads that are "lost" or ambiguous (conflicts that couldn't be resolved clearly).
- `-s`: The scoring strategy used to compare alignments.

## Selecting a Scoring Strategy (-s)

Choosing the correct scoring method is critical for accurate deconvolution:

- `as`: Use Alignment Scores. This is the preferred method if your aligner (like BWA or Bowtie2) populates the `AS` tag in the BAM file.
- `match`: Use the number of matches extracted from the CIGAR string. Use this if alignment scores are unavailable.
- `mapq`: Use Mapping Quality scores.
- `balwayswins`: A specific mode where species 2 (the host/mouse) is prioritized in specific conflict scenarios.

## Expert Tips and Best Practices

- **Input Preparation**: Ensure your BAM files are name-sorted before running bamcmp. While the tool uses the `-n` flag, pre-sorting with `samtools sort -n` ensures consistency.
- **Paired-End Handling**: bamcmp resolves conflicts at the read level. If one read of a pair maps significantly better to the graft than the host, it can be retained even if its mate is ambiguous.
- **Memory and Performance**: Since the tool processes full-length alignments, ensure you have sufficient disk space for the multiple output BAM files generated (Unique, Better, and Loss categories for both species).
- **Downstream Analysis**: For most biological interpretations, you should combine the "Unique" (`-a`/`-b`) and "Better" (`-A`/`-B`) BAM files for a specific species to get the total set of reads assigned to that organism.

## Reference documentation
- [bamcmp Overview](./references/anaconda_org_channels_bioconda_packages_bamcmp_overview.md)
- [bamcmp GitHub Repository](./references/github_com_CRUKMI-ComputationalBiology_bamcmp.md)