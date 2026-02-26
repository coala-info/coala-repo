---
name: panta
description: PanTA identifies core and accessory genomes and clusters orthologous genes for bacterial strains. Use when user asks to construct a pan-genome, cluster orthologous genes, perform sequence alignments, or incrementally add new genomic samples to an existing analysis.
homepage: https://github.com/amromics/panta
---


# panta

## Overview

PanTA (Pan-genome Analysis) is a high-performance pipeline designed to identify the core and accessory genomes of a set of related bacterial strains. It streamlines the process of clustering orthologous genes and performing sequence alignments. A key feature of PanTA is its ability to perform incremental updates, allowing you to add new genomic samples to an existing analysis without re-processing the entire dataset. Use this skill to construct valid command-line calls for initial builds and collection expansions.

## Installation and Setup

The recommended way to install panta is via Conda or Docker to ensure all dependencies (bedtools, CD-HIT, BLAST/DIAMOND, MCL) are correctly managed.

```bash
# Conda installation
conda install bioconda::panta

# Docker usage
docker pull amromics/panta:latest
```

## Core CLI Usage

### Initial Pan-genome Construction
Use the `main` command to process a set of GFF files for the first time.

```bash
panta main -o <output_directory> -g <input_files.gff> [options]
```

**Key Parameters:**
- `-o, --outdir`: Required. The directory where results will be stored.
- `-g, --gff`: Space-separated list of GFF3 input files.
- `-f, --tsv`: Alternatively, provide a TSV file listing input samples.
- `-b, --blast`: Choose the alignment method: `diamond` (default, faster) or `blast`.
- `-i, --identity`: Minimum percentage identity for clustering (default: 0.7).
- `-t, --threads`: Number of threads. Use `0` to utilize all available cores.

### Adding Samples to an Existing Collection
Use the `add` command to incorporate new genomes into a previously generated output directory.

```bash
panta add -c <previous_collection_dir> -g <new_files.gff> [options]
```

**Key Parameters:**
- `-c, --collection-dir`: Required. The path to the output directory created by a previous `panta main` or `panta add` run.
- Parameters for identity (`-i`), alignment method (`-b`), and threads (`-t`) should generally match the original run for consistency.

## Advanced Options and Best Practices

### Sequence Alignment
By default, panta clusters genes but may not perform full alignments for every cluster. To generate alignments for downstream phylogenomic analysis:
- Use `-a nucleotide` or `-a protein` (or both: `-a nucleotide protein`) to run alignments for each gene cluster.

### Clustering Sensitivity
- **Length Difference (`--LD`)**: Controls the allowed length difference between two sequences to be clustered (default: 0.7).
- **Alignment Coverage**: Use `--AL` (longer sequence) and `--AS` (shorter sequence) to enforce coverage constraints on the alignments.
- **Paralog Handling**: By default, panta attempts to split paralog clusters. Use `-s` or `--dont-split` if you wish to keep paralogs in the same cluster.

### Expert Tips
- **Input Suffixes**: Ensure your GFF files use standard extensions like `.gff` or `.gff3`.
- **Resource Management**: For large datasets (hundreds of genomes), always prefer `-b diamond` over blast to significantly reduce computation time.
- **Codon Tables**: If working with non-standard organisms (e.g., certain Mycoplasma), adjust the codon table using `--table` (default is 11 for Bacteria/Archaea).

## Reference documentation
- [panta GitHub Repository](./references/github_com_amromics_panta.md)
- [panta Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_panta_overview.md)