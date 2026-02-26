---
name: gecco
description: GECCO is a machine learning tool used to identify and predict biosynthetic gene clusters in genomic and metagenomic data. Use when user asks to predict biosynthetic gene clusters, annotate protein domains, convert cluster coordinates to different formats, or train custom CRF models.
homepage: https://gecco.embl.de/
---


# gecco

## Overview

GECCO (Gene Cluster prediction with Conditional Random Fields) is a high-performance bioinformatics tool designed to identify secondary metabolite biosynthetic gene clusters in genomic data. Unlike traditional rule-based systems, GECCO uses a machine learning approach to detect putative novel BGCs with high speed and scalability. Use this skill to process DNA sequences (FASTA or GenBank), extract gene coordinates, annotate protein domains, and predict biosynthetic types.

## Core Workflows

### Running BGC Predictions

The primary command for identifying clusters in a genome or metagenome.

```bash
# Basic prediction on a FASTA file with verbose output
gecco -v run --genome sequence.fna

# Run prediction and generate a sideload file for the AntiSMASH viewer
gecco run --genome sequence.gbk --antismash-sideload --output-dir ./results

# Adjust the probability threshold (default is 0.3) to increase sensitivity
gecco run --genome sequence.fna --threshold 0.2
```

### Annotation and Feature Extraction

Use these commands to generate intermediate tables or prepare data for training.

```bash
# Annotate a genome using a specific HMM database (e.g., Pfam)
gecco annotate --genome sequences.fna --hmm Pfam35.hmm.gz -o ./annotations

# Predict BGCs from an already annotated genome (requires gene/feature tables)
gecco predict --genes sequences.genes.tsv --features sequences.features.tsv
```

### Format Conversion

Convert GECCO output into formats compatible with other bioinformatics suites.

```bash
# Convert cluster coordinates to GFF format for genome browsers
gecco convert clusters -i ./output_dir --format gff

# Convert GenBank outputs to BiG-SLiCE compatible format
gecco convert gbk -i ./output_dir --format bigslice
```

### Training Custom Models

Train the CRF on specific datasets if the default model is not suitable for your target organisms.

```bash
# Fit a new CRF model and type classifier
gecco -vv train --genes genes.tsv --features features.tsv --clusters clusters.tsv -o custom_model

# Train with feature selection to keep only the top 30% most informative domains
gecco train --features features.tsv --clusters clusters.tsv -o custom_model --select 0.3
```

## Expert Tips and Best Practices

- **Input Formats**: GECCO uses Biopython for sequence loading; it supports FASTA, GenBank, and EMBL formats. For best results with `gecco convert`, use GenBank files that include full taxonomic metadata.
- **Performance**: For very large metagenomes, split the input FASTA into smaller chunks and run `gecco annotate` in parallel across nodes, then merge the resulting TSV tables before running `gecco predict`.
- **Threshold Tuning**: The default probability threshold of 0.3 is optimized for general BGC discovery. Lowering it (e.g., 0.15) may help find highly novel or fragmented clusters but will increase false positives.
- **Feature Selection**: When training, always use the `--select` flag. Reducing the feature set not only improves accuracy by removing non-informative domains but also significantly speeds up the HMM annotation step during subsequent `run` commands.
- **Visualization**: GECCO-produced GenBank files include color qualifiers (red for biosynthetic, blue for transporters, green for regulatory). These are natively supported by tools like SnapGene, Benchling, and Artemis.

## Reference documentation

- [GECCO Overview](./references/gecco_embl_de_index.md)
- [Installation Guide](./references/gecco_embl_de_install.html.md)
- [Downstream Integrations](./references/gecco_embl_de_integrations.html.md)
- [Training and Annotation](./references/gecco_embl_de_training.html.md)
- [API Reference](./references/gecco_embl_de_api_index.html.md)