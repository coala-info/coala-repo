---
name: ngs_te_mapper2
description: ngs_te_mapper2 identifies transposable element insertions and target site duplications in short-read sequencing data using a multi-stage alignment approach. Use when user asks to detect non-reference transposable element insertions, estimate allele frequencies of insertions, or identify target site duplications.
homepage: https://github.com/bergmanlab/ngs_te_mapper2
---


# ngs_te_mapper2

## Overview

ngs_te_mapper2 is a specialized tool for genomic researchers to identify transposable element (TE) insertions using a three-stage alignment procedure. It processes short-read WGS data to find "junction reads" that span the boundary between a TE and its genomic flank. By clustering these reads and aligning them to a hard-masked reference genome, the tool precisely identifies the span of target site duplications (TSDs) and provides heuristic estimates of allele frequency for non-reference TEs.

## Installation and Environment Setup

The most reliable way to deploy ngs_te_mapper2 is via Conda.

```bash
# Create a dedicated environment
conda create -n ngs_te_mapper2 --channel bioconda ngs_te_mapper2

# Activate the environment
conda activate ngs_te_mapper2
```

## Core Usage Patterns

### Basic Execution
To run a standard analysis, provide the raw reads, the TE consensus library, and the reference genome.

```bash
ngs_te_mapper2 -f reads.fastq -l library.fasta -r reference.fasta -o output_directory
```

### Handling Multiple Input Files
If you have multiple FASTQ files (e.g., paired-end reads or multiple lanes), provide them as a comma-separated list without spaces.

```bash
ngs_te_mapper2 -f R1.fastq,R2.fastq -l library.fasta -r reference.fasta -o output_directory
```

### Performance Optimization
Use the `-t` flag to specify the number of threads for parallel processing.

```bash
ngs_te_mapper2 -f reads.fastq -l library.fasta -r reference.fasta -t 8 -o output_directory
```

## Expert Tips and Best Practices

### Input Requirements
*   **TE Library (-l):** Ensure each TE family is represented by only one consensus sequence in the FASTA file.
*   **Reference Genome (-r):** Use the standard reference genome; the tool will handle the hard-masking internally using RepeatMasker logic and your provided TE library.

### Tuning Detection Sensitivity
*   **Allele Frequency (--min_af):** Adjust the minimum allele frequency threshold to filter out low-confidence or somatic insertions.
*   **Mapping Quality (--min_mapq):** Increase this value if you are working in highly repetitive regions to reduce false positives.
*   **TSD and Gaps:** Use `--tsd_max` and `--gap_max` to constrain the search space for target site duplications based on the known biology of the TEs you are investigating.

### Understanding Output Metrics
*   **Count_junction5'/3':** These represent soft-clipped reads overlapping a 10bp window on either side of the TSD.
*   **Count_ref:** These are non-soft-clipped reads that span the TSD with at least 3bp extension on both sides, indicating the "reference" (empty) haplotype.
*   **Allele Frequency:** Calculated heuristically as `max(Count_junction5', Count_junction3') / (max(Count_junction5', Count_junction3') + Count_ref)`.

### Troubleshooting
*   **Intermediate Files:** Use the `-k` flag to keep intermediate files if you need to debug alignment stages or inspect the junction read clusters.
*   **Queueing Systems:** If running via a cluster script (e.g., SLURM or SGE), ensure Conda is properly initialized within the script to avoid environment activation failures.

## Reference documentation
- [ngs_te_mapper2 Overview](./references/anaconda_org_channels_bioconda_packages_ngs_te_mapper2_overview.md)
- [ngs_te_mapper2 GitHub Repository](./references/github_com_bergmanlab_ngs_te_mapper2.md)