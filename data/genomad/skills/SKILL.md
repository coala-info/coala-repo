---
name: genomad
description: genomad is a specialized tool designed to find and classify mobile genetic elements within nucleotide sequences.
homepage: https://portal.nersc.gov/genomad/
---

# genomad

## Overview
genomad is a specialized tool designed to find and classify mobile genetic elements within nucleotide sequences. It utilizes a hybrid approach combining neural networks and protein-based classification to distinguish between chromosomal DNA, viruses, and plasmids. It is particularly effective for metagenomic datasets where identifying the origin of specific contigs is critical for downstream ecological or functional analysis.

## Core Workflows

### Basic Identification
To run the end-to-end pipeline (identification, taxonomic assignment, and annotation):
```bash
genomad end-to-end [INPUT.fasta] [OUTPUT_DIRECTORY] [DATABASE_DIRECTORY]
```

### Key Subcommands
- `find-proviruses`: Specifically identifies viral sequences integrated into host genomes.
- `annotate`: Predicts genes and assigns functions using the geNomad database.
- `marker-classification`: Classifies sequences based on the presence of specific MGE markers.
- `score-calibration`: Refines classification scores to reduce false positives.

### Common Parameters
- `--min-score`: Filter results by classification confidence (default is usually 0.7).
- `--splits`: Increase this value (e.g., `--splits 5`) to reduce memory usage during the neural network classification phase.
- `--cleanup`: Removes intermediate files to save disk space after the run completes.
- `--relaxed`: Use this flag during provirus detection to increase sensitivity for smaller or less conserved viral regions.

## Expert Tips
- **Database Setup**: Ensure the geNomad database is downloaded and indexed before running. Use `genomad download-database .` to fetch the latest version.
- **Contig Length**: For optimal performance, filter out very short contigs (<1000 bp) before running geNomad, as short sequences often lack sufficient marker density for reliable classification.
- **Interpreting Scores**: geNomad provides separate scores for virus and plasmid likelihood. A high "virus score" and low "plasmid score" indicates a strong viral candidate. If both are low, the sequence is likely chromosomal.
- **Provirus Boundaries**: When identifying proviruses, geNomad provides coordinates. Always verify these boundaries if performing detailed comparative genomics, as the tool prioritizes marker-rich regions.

## Reference documentation
- [genomad Overview](./references/anaconda_org_channels_bioconda_packages_genomad_overview.md)