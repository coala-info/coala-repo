---
name: pangolin
description: Pangolin identifies SARS-CoV-2 lineages from genomic sequences using phylogenetic assignment models. Use when user asks to assign Pango lineages to viral sequences, update lineage data, or analyze SARS-CoV-2 FASTA files.
homepage: https://github.com/hCoV-2019/pangolin
metadata:
  docker_image: "quay.io/biocontainers/pangolin:4.3.4--pyhdfd78af_1"
---

# pangolin

## Overview
Pangolin (Phylogenetic Assignment of Named Global Outbreak LINeages) is the standard bioinformatics tool for identifying SARS-CoV-2 lineages from genomic data. This skill helps you navigate the command-line interface to process viral sequences, manage the underlying assignment models (UShER or pangoLEARN), and keep the lineage data updated as new variants emerge.

## Installation and Updates
Pangolin relies on frequent data updates to recognize new lineages.

- **Install via Conda**:
  ```bash
  conda install -c bioconda -c conda-forge pangolin
  ```
- **Update the tool and data**:
  To ensure you are using the latest lineage definitions:
  ```bash
  pangolin --update
  ```
- **Check versions**:
  Verify the version of the software, the lineage data, and the assignment model:
  ```bash
  pangolin --version
  ```

## Common CLI Patterns
The primary input is a FASTA file containing one or more SARS-CoV-2 genomes.

- **Basic Analysis**:
  Run with default settings (currently uses the UShER model for speed and accuracy):
  ```bash
  pangolin sequences.fasta
  ```
- **Specify Output Directory**:
  ```bash
  pangolin sequences.fasta --outdir results_folder
  ```
- **Using pangoLEARN (Legacy/Alternative)**:
  If you specifically require the machine-learning based assignment:
  ```bash
  pangolin sequences.fasta --analysis-mode pangoLEARN
  ```
- **Parallel Processing**:
  Speed up analysis on multi-core systems:
  ```bash
  pangolin sequences.fasta -t 8
  ```

## Interpreting Output
The tool generates a `lineage_report.csv` file. Key columns include:
- **lineage**: The assigned Pango lineage (e.g., B.1.1.7, BA.2).
- **conflict**: A score indicating if the sequence fits multiple lineages (higher means more ambiguity).
- **ambiguity_score**: Represents the proportion of Ns or missing data in the sequence.
- **note**: Contains warnings, such as "sequencing_error" or "insufficient_data," which may invalidate the assignment.

## Expert Tips
- **Quality Control**: Pangolin automatically filters sequences that are too short or have too many Ns. If your sequences are missing from the report, check the `pangolin.log` for "failed QC" messages.
- **Maximum Parsimony**: Use the default UShER mode for the most robust results on large datasets, as it places sequences directly onto a global phylogenetic tree.
- **Data Sync**: Always run `--update` before starting a new batch of analysis, as Pango lineage designations change weekly.

## Reference documentation
- [Pangolin Overview](./references/anaconda_org_channels_bioconda_packages_pangolin_overview.md)
- [Pangolin GitHub Repository](./references/github_com_cov-lineages_pangolin.md)