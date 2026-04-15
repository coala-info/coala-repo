---
name: purge_haplotigs
description: The purge_haplotigs pipeline identifies and removes redundant genomic segments from a diploid assembly to create a cleaner haploid representation. Use when user asks to generate read depth histograms, analyze contig coverage, or purge redundant haplotigs from a genome assembly.
homepage: https://bitbucket.org/mroachawri/purge_haplotigs/
metadata:
  docker_image: "quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0"
---

# purge_haplotigs

## Overview
The `purge_haplotigs` pipeline automates the identification of "haplotigs"—redundant genomic segments where both maternal and paternal alleles have been assembled as separate primary contigs. By analyzing read depth (coverage) and sequence alignment, the tool reassigns these redundant contigs as "secondary" or "junk," resulting in a cleaner, more accurate haploid representation of a diploid genome.

## Core Workflow

The pipeline typically follows a three-step process:

### 1. Read Depth Histogram (`readhist`)
Generate a read-depth histogram from a BAM file (aligned genomic reads) to determine the coverage thresholds for primary and secondary contigs.
```bash
purge_haplotigs readhist -b aligned_reads.bam -g genome.fasta [options]
```
*   **Expert Tip:** Look for a bimodal distribution in the resulting `.png`. The first peak usually represents haplotigs (half coverage), and the second represents collapsed homozygous regions (full coverage).

### 2. Contig Coverage Analysis (`contigcov`)
Assign coverage levels to each contig based on the thresholds identified in the histogram.
```bash
purge_haplotigs contigcov -i aligned_reads.bam.gencov -l <low_cutoff> -m <mid_point> -h <high_cutoff> [-o coverage_stats.csv]
```
*   **Low Cutoff (`-l`):** Minimum coverage to keep a contig (filters out noise/low-coverage junk).
*   **Mid Point (`-m`):** The transition point between haplotig and primary contig peaks.
*   **High Cutoff (`-h`):** Maximum coverage (filters out repetitive/collapsed regions).

### 3. Purging Redundant Contigs (`purge`)
Perform the actual curation by comparing contigs and reassigning them based on sequence similarity and coverage.
```bash
purge_haplotigs purge -g genome.fasta -c coverage_stats.csv [options]
```
*   **Key Output:** `curated.fasta` (the cleaned primary assembly) and `curated.haplotigs.fasta` (the removed redundant sequences).
*   **Alignment:** This step often requires a self-alignment of the genome (e.g., using `minimap2` or `blasr`) to identify syntenic regions.

## Best Practices
*   **Input Quality:** Ensure your BAM file is sorted and indexed. Use long reads (PacBio/Oxford Nanopore) for the best results in identifying structural overlaps.
*   **Threshold Selection:** Do not guess thresholds. Always run `readhist` first and visually inspect the histogram to ensure `-l`, `-m`, and `-h` accurately reflect your specific sequencing data.
*   **Repeat Masking:** If the assembly is highly repetitive, consider masking repeats before running the `purge` step to prevent over-purging of collapsed repeats.

## Reference documentation
- [Bitbucket Repository and Documentation](./references/bitbucket_org_mroachawri_purge_haplotigs.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_purge_haplotigs_overview.md)