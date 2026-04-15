---
name: bygul
description: Bygul simulates amplicon sequencing reads from complex mixtures of viral or bacterial strains with specified or random proportions. Use when user asks to simulate amplicon reads, generate sequencing data for wastewater surveillance, or create mixtures of genomic samples with specific proportions.
homepage: https://github.com/andersen-lab/Bygul
metadata:
  docker_image: "quay.io/biocontainers/bygul:1.0.7--pyhdfd78af_0"
---

# bygul

## Overview

Bygul is a specialized tool designed to simulate amplicon reads, particularly for applications like wastewater surveillance where multiple viral or bacterial strains are present in a single sample. It allows for the creation of complex mixtures by specifying the relative proportions of different input sequences. The tool integrates with established simulators like `wgsim` and `mason` to generate realistic sequencing data while accounting for primer binding efficiency and genomic mismatches.

## Command Line Usage

The primary command for Bygul is `simulate-proportions`. It requires a list of sample FASTA files, a primer BED file, and a reference FASTA.

### Basic Simulation
To simulate reads from two samples with specific proportions (e.g., 80% and 20%):

```bash
bygul simulate-proportions sample1.fasta,sample2.fasta primers.bed reference.fasta --proportions 0.8,0.2 --outdir output_dir
```

### Random Proportions
If the `--proportions` flag is omitted, Bygul assigns random proportions to the input samples. The resulting values are saved in `results/sample_proportions.txt`.

```bash
bygul simulate-proportions s1.fasta,s2.fasta primers.bed reference.fasta --outdir results/
```

### Adjusting Simulator Parameters
Bygul defaults to `wgsim`, but you can switch to `mason` and adjust sequencing parameters:

```bash
bygul simulate-proportions s1.fasta,s2.fasta primers.bed reference.fasta \
    --simulator mason \
    --readcnt 1000 \
    --error_rate 0.001 \
    --read_length 400 \
    --indel_fraction 0.001
```

## Expert Tips and Best Practices

### Primer BED File Requirements
The primer BED file must include a column containing the actual primer sequences. Bygul uses these to calculate binding efficiency and mismatches.

### Handling Primer Mismatches
By default, Bygul allows 1 SNP mismatch in the primer region. If working with highly divergent samples, increase this threshold to avoid artificial amplicon dropouts:

```bash
bygul simulate-proportions ... --maxmismatch 2
```

### Optimizing Read Counts
Set the `--readcnt` (reads per amplicon) to a value significantly higher than the number of contigs in your amplicon file. This is critical for whole-genome sequencing (WGS) primer sets where an amplicon might contain many contigs; low read counts can lead to empty FASTQ files for specific amplicons.

### Analyzing Dropouts
After simulation, check the `amplicon_stats.csv` file located in the sample-specific subdirectories within your output folder. This file provides:
- `primer_seq_x` and `primer_seq_y`: The left and right primer sequences used.
- `left_mismatch_map` and `right_mismatch_map`: The actual sequence found in the sample, allowing you to pinpoint exactly where mismatches occurred.
- `ambiguous_bases`: A boolean indicating if the matching sequence contains Ns or other ambiguous bases.

## Reference documentation
- [Bygul GitHub Repository](./references/github_com_andersen-lab_Bygul.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bygul_overview.md)