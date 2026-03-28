---
name: emu
description: Emu performs high-resolution taxonomic profiling for long-read sequencing data using an Expectation-Maximization algorithm. Use when user asks to perform taxonomic classification on long reads, merge multiple sample results into a single matrix, or adjust abundance thresholds for species identification.
homepage: https://gitlab.com/treangenlab/emu
---


# emu

## Overview
Emu is a specialized bioinformatic tool designed to provide high-resolution taxonomic profiling for long-read sequencing. Unlike traditional methods that may struggle with the error rates of long reads, Emu utilizes an Expectation-Maximization algorithm to accurately assign reads to their most likely origin. It is particularly effective for full-length 16S rRNA sequencing and supports various specialized databases for bacteria, eukaryotes, and fungi.

## Core CLI Patterns

### Standard Taxonomic Profiling
The primary workflow involves running Emu against a set of reads (FASTA/FASTQ) using a pre-built database.
```bash
emu run <input.fastq> --db <path_to_emu_db> --output-dir <output_folder>
```

### Merging Multiple Samples
To compare results across a study, use the `combine-outputs` subcommand. This aggregates individual `.tsv` files into a single matrix.
```bash
emu combine-outputs <directory_containing_results> --db <path_to_emu_db> --out-file combined_species.tsv
```
*   **Expert Tip**: Use the `--split-tables` flag during combination if you need the full taxonomic lineage (Domain to Species) included in the final table.

### Handling Unclassified Reads
By default, Emu focuses on classified taxa. To account for the "dark matter" in your sample, enable unclassified reporting:
```bash
emu run <input.fastq> --output-unclassified --db <path_to_emu_db>
```

## Expert Tips and Best Practices

### Managing Abundance Thresholds
Emu uses a built-in minimum abundance threshold to reduce false positives:
*   **Default**: 1 read for samples with <1,000 reads; 10 reads for samples with >1,000 reads.
*   **Adjustment**: Use `--min-abundance <float>` to manually set a threshold. 
*   **Warning**: Lowering this threshold below the default is generally discouraged as it significantly increases the risk of false-positive taxonomic assignments, especially in environmental samples.

### Low-Depth Samples
Be cautious when analyzing samples with fewer than 1,000 reads. Emu may overestimate the number of taxa in extremely low-depth metagenomic samples. If depth is low, consider increasing the `--min-abundance` parameter to filter out noise.

### Database Specifics
*   **18S/Eukaryotes**: When using the PR2 database for microbial eukaryotes, be aware that `combine-outputs` may normalize headers (e.g., changing 'supergroup' to 'superkingdom') to maintain consistency with the Emu internal structure.
*   **Custom Databases**: Emu supports custom database builds. If your database has gaps in taxonomic annotation, Emu will permit classification at less specific ranks (e.g., Genus level) rather than forcing a Species-level assignment.

### Performance Optimization
For large datasets, Emu versions 2.0.1+ include optimizations to reduce memory consumption and processing time. Always ensure you are using the latest stable release (v3.4.5+) for the most efficient Expectation-Maximization iterations.



## Subcommands

| Command | Description |
|---------|-------------|
| emu abundance | Calculate species abundance from sequence data. |
| emu build-database | Builds a custom database for EMU. |
| emu collapse-taxonomy | Collapse taxonomic ranks in emu output. |
| emu combine-outputs | Combines Emu output files into a single table. |

## Reference documentation
- [Emu Project README](./references/gitlab_com_treangenlab_emu_-_blob_master_README.md)
- [Emu Release History and Version Notes](./references/gitlab_com_treangenlab_emu_-_releases.md)
- [Emu GitLab Activity and Issue Discussions](./references/gitlab_com_treangenlab_emu.md)