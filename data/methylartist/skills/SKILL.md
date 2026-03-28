---
name: methylartist
description: Methylartist is a toolkit for processing, aggregating, and visualizing modified base calls from long-read sequencing data. Use when user asks to convert raw methylation calls into SQLite databases, aggregate methylation levels over genomic features, or generate locus-specific and phased methylation plots.
homepage: https://github.com/adamewing/methylartist
---

# methylartist

## Overview
Methylartist is a specialized toolkit designed for the analysis of modified base calls, primarily from long-read sequencing platforms. It streamlines the workflow of converting raw modification calls into queryable SQLite databases and provides high-level visualization commands. Use this skill when you need to aggregate methylation data over specific genomic features (like promoters or repeat elements) or create detailed plots of methylation density and phasing across specific genetic loci.

## Core Workflows

### 1. Database Initialization
Before plotting, raw methylation calls must be converted into a methylartist SQLite database (.db).

*   **From Nanopolish**:
    `methylartist db-nanopolish -m calls.tsv.gz -d output.db`
    *Tip: Use `-t 2.0 -s` to apply recommended log-likelihood ratio cutoffs and scale grouped CpGs.*
*   **From Megalodon**:
    `methylartist db-megalodon -m per_read_modified_base_calls.txt -d output.db`
*   **From C/U Conversion (WGBS/EM-seq)**:
    `methylartist db-sub -b aligned_reads.bam -d output.db`
*   **Appending Data**: Use the `-a` flag to add multiple samples or flowcells to an existing database.

### 2. Segment Aggregation (segmeth)
To compare methylation across different regions (e.g., comparing WT vs. Mutant across all promoters), you must first run `segmeth`.

*   **Command**: `methylartist segmeth -d data_config.txt -i regions.bed -p 8`
*   **Data Config Format**: A whitespace-delimited file where each line is: `[BAM_FILE] [DATABASE_FILE]`
*   **Input BED**: BED3+2 format (chrom, start, end, label, strand).

### 3. Visualization Patterns

*   **Locus Plots**: Detailed view of a specific genomic region.
    `methylartist locus -b sample.bam -d sample.db -g ref.gtf -r chr1:100-2000`
*   **Segment Plots (segplot)**: Create violin or strip plots from `segmeth` output.
    `methylartist segplot -i aggregated_data.segmeth.tsv --plot violin`
*   **Phased Plots**: If your BAM is haplotagged, methylartist can split methylation tracks by haplotype to visualize allele-specific methylation.

## Expert Tips & Best Practices
*   **Parallelization**: Always use the `-p/--proc` flag with `segmeth` and `locus` commands to utilize multiple CPU cores, as parsing large methylation databases is computationally intensive.
*   **BAM Requirements**: Ensure BAM files are sorted and indexed (`samtools index`). Read names in the BAM must match the read names in the methylation database.
*   **Modified Base Tags**: If using Dorado or Guppy, methylartist can often read `MM` and `ML` tags directly from the BAM, bypassing the need for separate database creation for some plotting functions.
*   **Custom Parsing**: If using a non-standard caller, use `db-custom` and map the columns manually using `--readname`, `--chrom`, `--pos`, and `--modprob`.



## Subcommands

| Command | Description |
|---------|-------------|
| methylartist adjustcutoffs | Adjust methylation cutoffs in a methylartist database |
| methylartist composite | Generate composite methylation plots for transposable elements or other genomic features. |
| methylartist db-custom | Create or update a methylartist database from a custom per-read methylation output table. |
| methylartist db-guppy | Process Guppy-called fast5 files to generate a methylation database |
| methylartist db-megalodon | Process megalodon per_read_text methylation output into a database |
| methylartist db-nanopolish | Process nanopolish methylation output into a database |
| methylartist db-sub | Methylartist database submission/subcommand tool |
| methylartist locus | Plot methylation data for a specific genomic locus, including alignments, smoothed methylation profiles, and gene annotations. |
| methylartist region | Plot methylation data for a specific genomic region, including alignment tracks, smoothed methylation profiles, and gene annotations. |
| methylartist scoredist | Plot the distribution of modification scores from methylartist databases or BAM files. |
| methylartist segmeth | Segmented methylation analysis tool for calculating methylation levels over specific intervals. |
| methylartist segplot | Generate segmentation plots from methylartist segmeth output |
| methylartist wgmeth | Whole-genome methylation calling and processing tool |

## Reference documentation
- [methylartist GitHub Repository](./references/github_com_adamewing_methylartist_blob_main_README.md)
- [methylartist Tool Overview](./references/anaconda_org_channels_bioconda_packages_methylartist_overview.md)