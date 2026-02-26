---
name: mess
description: MeSS is a Snakemake-based pipeline that generates realistic metagenomic mock communities by fetching reference genomes and simulating reads with technology-specific error profiles. Use when user asks to simulate metagenomic datasets, generate mock communities from TaxIDs or accessions, or create ground truth reads for testing bioinformatics tools.
homepage: https://github.com/metagenlab/MeSS
---


# mess

## Overview

MeSS (Metagenomic Sequence Simulator) is a Snakemake-based pipeline designed to generate realistic metagenomic mock communities. It streamlines the workflow of fetching reference genomes from NCBI (via TaxIDs or accessions) or utilizing local FASTA files, and then simulating reads with technology-specific error profiles. It is an essential tool for researchers needing to create "ground truth" datasets to test assemblers, taxonomic profilers, or binning algorithms.

## Core CLI Usage

The primary entry point for the tool is the `mess run` command.

### Basic Simulation
To run a simulation using an input table:
```bash
mess run -i samples.tsv
```

### Specifying Sequencing Technology
MeSS supports different technologies and error profiles:
- **Illumina (Default):** `mess run -i input.tsv --tech illumina`
- **Nanopore (ONT):** `mess run -i input.tsv --tech nanopore`
- **PacBio HiFi:** `mess run -i input.tsv --tech pacbio --error hifi`

### Dependency Management
By default, MeSS uses Apptainer for maximum reproducibility. If you prefer Conda, specify the software deployment mode:
```bash
mess run -i input.tsv --sdm conda
```

## Input Table Configuration

The input TSV file defines the community composition.

### Using TaxIDs and Read Counts
Create a `samples.tsv` with the following structure:
| sample | taxon | reads |
| :--- | :--- | :--- |
| sample1 | 487 | 174840 |
| sample1 | 727 | 90679 |

### Using Coverage Depth
You can specify coverage instead of absolute read counts:
| sample | taxon | cov_sim |
| :--- | :--- | :--- |
| phage_sample | 347329 | 200 |

## Advanced Features

### Circular Assemblies
To simulate reads from circular genomes (e.g., plasmids or circular bacteria), use the `--rotate` flag to shuffle start points:
```bash
mess run -i input.tsv --rotate 3
```
*Note: This will apply circularization to all contigs in the provided or downloaded FASTA.*

### Output Structure
By default, MeSS creates a `mess_out` directory containing:
- `assembly_finder/download/`: Downloaded NCBI genomes.
- `fastq/`: The simulated reads (e.g., `sample1_R1.fq.gz`).
- `CAMI-profile`: Taxonomic and sequence abundances in CAMI format.

## Expert Tips

1. **TaxID Precision:** Always prefer NCBI TaxIDs over scientific names in your input table to avoid ambiguity (e.g., names that might match multiple species or strains).
2. **Resource Management:** For large simulations, MeSS typically requires ~1.8GB of RAM per CPU. Ensure your environment has sufficient overhead for the `art_illumina` or `pbsim3` backends.
3. **Custom Error Profiles:** While `hiseq25k` is the Illumina default, you can pass additional simulator-specific arguments if needed to match specific sequencing runs.
4. **Reproducibility:** Use the default Apptainer mode whenever possible to ensure that the underlying simulators (ART, PBSIM3) and their dependencies remain version-consistent.

## Reference documentation
- [Metagenomic Sequence Simulator (MeSS) Overview](./references/github_com_metagenlab_MeSS.md)
- [MeSS Wiki and Workflow Rules](./references/github_com_metagenlab_MeSS_wiki.md)