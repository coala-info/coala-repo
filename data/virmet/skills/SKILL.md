---
name: virmet
description: VirMet is a bioinformatics toolkit designed to identify viral organisms in metagenomic sequencing data through a sequential decontamination and BLAST-based classification workflow. Use when user asks to process raw FASTQ files, remove host contamination, identify viral species, or generate genome coverage plots.
homepage: https://github.com/medvir/VirMet
metadata:
  docker_image: "quay.io/biocontainers/virmet:2.0.1--pyhdfd78af_0"
---

# virmet

## Overview
VirMet is a specialized toolkit for viral metagenomics designed to process raw sequencing reads and identify viral organisms. It follows a rigorous decontamination workflow—sequentially removing human, bovine, bacterial, and fungal sequences—before performing BLAST searches against viral databases. This skill helps users navigate the command-line interface to move from raw FASTQ files to a prioritized list of identified viruses with associated coverage metrics.

## Core Workflow

### 1. Preparation and Database Setup
Before running an analysis, the reference databases must be downloaded and indexed.
- **Download databases**: `virmet fetch`
- **Update viral records**: `virmet update`
- **Index genomes**: `virmet index`

### 2. Running the Analysis (Wolfpack)
The `wolfpack` subcommand is the primary entry point for analyzing a sequencing run.
- **Standard run**: `virmet wolfpack --run path_to_run_directory`
- **Input structure**: The tool expects a directory containing `.fastq.gz` files (e.g., `Exp01/sample1_S1.fastq.gz`).
- **Output**: Results are stored in a new directory named `virmet_output_RUN_NAME`.

### 3. Visualizing Results
- **Coverage plots**: By default, `wolfpack` generates coverage plots. To manually generate or update a plot for a specific organism, use:
  `virmet covplot`

## Interpreting Outputs

### Primary Summary Files
- **Orgs_species_found.csv**: The main results table. Focus on the `reads` and `covered_region` columns to assess the strength of a viral hit.
- **Run_reads_summary.tsv**: A step-by-step breakdown of read filtering. Use this to determine if a sample had high host (human/bovine) contamination or low quality.

### Sample-Specific Data
Each sample gets its own subdirectory containing:
- `viral_reads.fastq.gz`: Reads identified as viral.
- `undetermined_reads.fastq.gz`: Reads that did not match any database.
- `unique.tsv.gz`: Raw BLAST hits before final filtering.
- `[Virus_Name]/[Virus_Name]_coverage.pdf`: Visual representation of genome coverage.

## Expert Tips and Best Practices
- **Validation Criteria**: VirMet filters BLAST hits to ensure only those with **≥75% identity (pident)** and **≥75% query coverage (qcov)** are reported in the final species list.
- **Manual Inspection**: Always review the `.pdf` coverage plots in the sample folders. A "true" viral hit typically shows distributed coverage across the genome rather than a single high-depth spike in one conserved region.
- **Decontamination Order**: Understand that VirMet removes reads in a specific order: Human GRCh38 -> Bovine -> Bacteria -> Fungi. If a sample is expected to have high bacterial load, check the `matching_bacteria` count in the summary TSV.
- **Disk Space**: Database indexing and BLAST searches are resource-intensive. Ensure the execution environment has sufficient temporary storage, as intermediate files are often created in `/tmp`.



## Subcommands

| Command | Description |
|---------|-------------|
| virmet covplot | Generate coverage plots for viral genomes. |
| virmet fetch | Fetch viral, human, bacterial, fungal, or bovine databases. |
| virmet update | Update the Virmet database. |
| virmet_index | Builds indexes for various databases used by Virmet. |

## Reference documentation
- [VirMet GitHub Repository Overview](./references/github_com_medvir_VirMet.md)
- [VirMet Bioconda Package](./references/anaconda_org_channels_bioconda_packages_virmet_overview.md)