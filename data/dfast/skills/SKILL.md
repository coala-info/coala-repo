---
name: dfast
description: DFAST is a high-speed annotation pipeline for identifying genomic features and assigning functional annotations to prokaryotic genomes. Use when user asks to annotate a genome assembly, generate GFF3 or GenBank files, or prepare data for DDBJ submission.
homepage: https://dfast.nig.ac.jp
metadata:
  docker_image: "quay.io/biocontainers/dfast:1.3.8--h5ca1c30_0"
---

# dfast

## Overview
DFAST is a high-speed annotation pipeline designed specifically for prokaryotic genomes. It streamlines the process of identifying genomic features (such as CDS, rRNA, and tRNA) and assigning functional annotations. It is particularly useful for researchers who need to generate standardized annotation files (GFF3, GenBank) or prepare data for submission to public databases like DDBJ.

## Installation
The recommended way to install dfast is through the Bioconda channel:
```bash
conda install -c bioconda dfast
```

## Common CLI Patterns
DFAST typically requires a genomic FASTA file as input. Below are the standard usage patterns:

### Basic Annotation
To run the default annotation pipeline on a genome assembly:
```bash
dfast --genome assembly.fasta --out output_dir
```

### Database Setup
Before the first run, or to update reference data, you must download the necessary protein and HMM databases:
```bash
dfast_file_update.py --protein
dfast_file_update.py --hmm
```

### Submission Preparation
To generate files specifically formatted for DDBJ submission, include the metadata flags:
```bash
dfast --genome assembly.fasta --organism "Escherichia coli" --strain "K-12" --center "Your Institute" --out output_dir
```

## Expert Tips
- **CPU Optimization**: Use the `--cpus` flag to speed up the search steps (BLAST/HMMER) if running on a multi-core server.
- **Custom Databases**: You can provide your own reference protein sequences in FASTA format using the `--protein` option to improve annotation accuracy for specific taxa.
- **Locus Tag Prefix**: Always specify a unique `--locus_tag_prefix` if you plan to submit multiple genomes to ensure feature IDs do not overlap.
- **Cleanup**: Use the `--force` option if you need to overwrite an existing output directory.

## Reference documentation
- [dfast Overview](./references/anaconda_org_channels_bioconda_packages_dfast_overview.md)