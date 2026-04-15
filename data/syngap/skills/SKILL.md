---
name: syngap
description: SynGAP refines gene structure annotations and identifies homologous gene pairs by leveraging evolutionary synteny between species. Use when user asks to polish genome annotations, correct gene models using synteny, identify high-confidence ortholog pairs, or perform cross-species transcriptomic analysis.
homepage: https://github.com/yanyew/SynGAP
metadata:
  docker_image: "quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0"
---

# syngap

## Overview

SynGAP (Synteny-based Gene Structure Annotation Polisher) is a specialized toolkit designed to refine gene models by leveraging evolutionary conservation and synteny between related species. It transforms general genome annotations into high-quality, polished versions by identifying gaps in gene models (MAGs) and correcting structural errors. Beyond annotation polishing, it provides workflows for cross-species transcriptomic analysis, enabling the identification of high-confidence homologous gene pairs and the calculation of expression variation indices (EVI).

## Core Workflows

### 1. Genome Annotation Polishing
Use these modules to correct gene structures based on synteny.

*   **Dual Polishing (`dual`)**: Mutual correction between two species.
    ```bash
    syngap dual --sp1fa=species1.fa --sp1gff=species1.gff3 --sp2fa=species2.fa --sp2gff=species2.gff3 --sp1=ID1 --sp2=ID2
    ```
*   **Master Polishing (`master`)**: Polish a target species using a high-quality "Core set" reference.
    *   *Prerequisite*: Initialize the database first.
    ```bash
    syngap initdb --sp=plant --file=plant.tar.gz
    syngap master --sp=plant --sp1fa=target.fa --sp1gff=target.gff3 --sp1=TargetID
    ```
*   **Triple Polishing (`triple`)**: Combined polishing using three related species.
    ```bash
    syngap triple --sp1fa=sp1.fa --sp1gff=sp1.gff3 --sp2fa=sp2.fa --sp2gff=sp2.gff3 --sp3fa=sp3.fa --sp3gff=sp3.gff3 --sp1=ID1 --sp2=ID2 --sp3=ID3
    ```
*   **Custom Polishing (`custom`)**: Use specific synteny blocks or results from external software (e.g., JCVI).
    ```bash
    syngap custom --sp1fa=sp1.fa --sp1gff=sp1.gff3 --sp2fa=sp2.fa --sp2gff=sp2.gff3 --custom_anchors=manual.anchors --sp1=ID1 --sp2=ID2
    ```

### 2. Comparative Transcriptomics
Use these modules to analyze gene expression across species boundaries.

*   **Gene Pairing (`genepair`)**: Generates high-confidence ortholog pairs by combining SynGAP-improved synteny with reciprocal best BLAST hits.
    ```bash
    syngap genepair --sp1fa=sp1.fa --sp1gff=sp1.SynGAP.gff3 --sp2fa=sp2.fa --sp2gff=sp2.SynGAP.gff3 --sp1=ID1 --sp2=ID2
    ```

## Expert Tips and Best Practices

*   **Output Interpretation**:
    *   `*.SynGAP.gff3`: The complete annotation set containing both original and newly polished models.
    *   `*.SynGAP.clean.gff3`: Contains only the polished/corrected annotations.
    *   `*.miss_annotated.gff3`: Specifically identifies genes that were entirely missing in the original annotation.
    *   `*.mis_annotated.gff3`: Specifically identifies genes that had incorrect structures in the original annotation.
*   **Database Management**: When using the `master` workflow, ensure you have downloaded the appropriate `plant.tar.gz` or `animal.tar.gz` datasets. Use `syngap initdb` to register them before running the polishing command.
*   **Input Requirements**: Always provide unique species identifiers (e.g., `Ath`, `Sly`) via the `--sp1` and `--sp2` flags to ensure output files are correctly prefixed and organized.
*   **Environment**: It is highly recommended to run SynGAP within its dedicated Conda environment or Docker container to manage the extensive list of dependencies (Biopython, JCVI, Bedtools, Diamond, etc.).



## Subcommands

| Command | Description |
|---------|-------------|
| syngap custom | Custom synteny analysis between two species. |
| syngap dual | Compare two species' genomes and annotations. |
| syngap evi | Calculate EVI (Expression Variation Index) for gene pairs. |
| syngap genepair | Compares gene pairs between two species. |
| syngap initdb | Initialize a new syngap database by importing a masterdb. |
| syngap master | This tool appears to be a master script for processing genomic data, likely involving species comparison and annotation. |
| syngap triple | Compare three species genomes and their annotations. |
| syngap_eviplot | Generate an EVI plot from a tab-divided EVI file. |

## Reference documentation
- [SynGAP GitHub README](./references/github_com_yanyew_SynGAP_blob_master_README.md)
- [Custom Polishing Logic](./references/github_com_yanyew_SynGAP_blob_master_custom.py.md)
- [Dual Polishing Logic](./references/github_com_yanyew_SynGAP_blob_master_dual.py.md)