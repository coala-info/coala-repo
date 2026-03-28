---
name: artic
description: The ARTIC tool processes viral sequencing data from Oxford Nanopore devices to generate high-quality consensus genomes and validated variants. Use when user asks to filter reads by length, run the MinION pipeline for tiled amplicon data, or perform genomic surveillance for infectious disease outbreaks.
homepage: https://github.com/artic-network/fieldbioinformatics
---


# artic

## Overview

The ARTIC (Anthropogenic Response to Infectious Diseases) skill provides a specialized workflow for processing viral sequencing data, primarily from Oxford Nanopore devices. It is designed to transform raw sequencing reads into high-quality consensus genomes and validated variants. This skill is essential for researchers and public health professionals working on outbreak response, allowing for rapid, field-deployable genomic surveillance using standardized "lab-in-a-suitcase" protocols.

## Core CLI Workflows

The `artic` pipeline (fieldbioinformatics) is the primary tool for processing tiled amplicon data.

### 1. Read Filtering and Demultiplexing
Before assembly, reads must be filtered by length to match the expected amplicon size (e.g., 400bp for many schemes).

```bash
# Filter reads by length and quality
artic guppyplex --directory <path_to_fastq> --min-length 400 --max-length 700 --output filtered_reads.fastq
```

### 2. The Main Pipeline (MinION)
The `minion` command executes the full workflow: alignment, primer trimming, signal normalization, and variant calling.

```bash
# Standard run using Medaka for variant calling
artic minion --medaka --normalise 100 --threads 8 --scheme-directory ~/artic/schemes --read-file filtered_reads.fastq <scheme_name> <sample_id>
```

**Key Parameters:**
- `--medaka`: Recommended for Nanopore data to improve consensus accuracy.
- `--normalise`: Limits maximum depth per amplicon (e.g., 100x) to speed up processing without losing sensitivity.
- `--scheme-directory`: Path to the directory containing primer schemes and reference sequences.

### 3. Working with Primer Schemes
ARTIC relies on specific primer schemes designed via `PrimalScheme`. Ensure your scheme directory follows the required structure:
`[scheme_name]/[v1.0.0]/[scheme_name].reference.fasta` and `[scheme_name].scheme.bed`.

## Expert Tips & Best Practices

- **Wastewater Surveillance**: When processing environmental samples (WBE), expect lower viral concentrations and higher background noise. Use the `artic-measles/400/v1.0.0` or similar broad-spectrum schemes to capture genetic variation across multiple serotypes.
- **Metagenomics (SMART-9N)**: For untargeted viral surveillance, use the optimized SMART-9N protocol. This involves host depletion (DNase treatment) followed by magnetic bead extraction to enrich for both DNA and RNA viruses.
- **Primer Trimming**: Always ensure the correct version of the primer scheme is specified. Incorrect schemes lead to "primer-derived" variants being incorrectly called in the final consensus.
- **In-frame Deletions**: When reviewing variant outputs, verify that deletions are correctly identified as in-frame to maintain the viral open reading frame (ORF) in the consensus.



## Subcommands

| Command | Description |
|---------|-------------|
| artic export | Export artic results to various formats. |
| artic filter | Filter FASTQ reads based on length. |
| artic minion | ARTIC pipeline for MinION data |
| artic rampart | RAMPART is a tool for the analysis of sequencing data from pathogen surveillance. |
| artic_run | Run the artic pipeline |
| guppyplex | Basecalled and demultiplexed (guppy) results directory |

## Reference documentation

- [The ARTIC fieldbioinformatics pipeline](./references/github_com_artic-network_fieldbioinformatics.md)
- [Optimisation of SMART-9N for viral metagenomics](./references/artic_network_2025-09-08-smart9n-optimisation.html.md)
- [Applying the ARTIC approach to wastewater](./references/artic_network_2025-08-14-wastewater_based_epidemiology_AGD.html.md)
- [Measles sequencing update and primer schemes](./references/artic_network_2025-08-11-artic-measles-v1.0.0-scheme.html.md)