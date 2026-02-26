---
name: konezumiaid
description: konezumiaid is a command-line utility that identifies C-to-T base editing targets for generating knockout mouse models using Target-AID technology. Use when user asks to design gRNAs for gene disruption, search for base editing targets by gene symbol or transcript ID, or perform batch processing for multiplex knockout generation.
homepage: https://github.com/aki2274/KOnezumi-AID
---


# konezumiaid

## Overview

konezumiaid is a command-line utility designed to facilitate multiplex knockout mouse generation using Target-AID base editing technology. Unlike traditional CRISPR/Cas9 which relies on double-strand breaks, this tool identifies specific C-to-T conversion targets that result in functional gene disruption. It streamlines the workflow from genomic data preprocessing to the final selection of "Recommended" gRNAs based on their position and impact on the protein-coding sequence.

## Installation and Setup

The tool requires Python 3.9+ and external dependencies `bedtools` and `bowtie`.

```bash
# Recommended installation via Bioconda
conda install -c conda-forge -c bioconda konezumiaid
```

### Data Preparation
Before running searches, you must download the mouse genome (mm39) and locus information (refFlat) from UCSC and run the preprocessing command.

```bash
# 1. Download required data
curl https://hgdownload.soe.ucsc.edu/goldenPath/mm39/database/refFlat.txt.gz | gzip -dc > data/refFlat.txt
curl https://hgdownload.soe.ucsc.edu/goldenPath/mm39/bigZips/mm39.fa.gz | gzip -dc > data/mm39.fa

# 2. Preprocess the dataset
konezumiaid preprocess data/refFlat.txt data/mm39.fa
```

## Core Workflows

### Single Query Search
You can search by gene symbol or specific RefSeq transcript ID.

*   **By Gene Symbol**: Returns gRNAs present across all transcript variants.
    ```bash
    konezumiaid -n Rp1
    ```
*   **By Transcript Name**: Provides more granular data, including "Recommended" status, target amino acids, and exon indices.
    ```bash
    konezumiaid -n NM_001370921
    ```

### Batch Processing
For high-throughput design, use a list of genes or transcripts.
*   **File Format**: A single-column CSV or Excel file.
*   **Constraint**: No header row; data must start from the first row.

```bash
konezumiaid batch -f gene_list.csv
```

## Expert Tips and Best Practices

*   **Output Location**: Results are automatically saved to `data/output/` as CSV files named `<gene|transcript>_ptc_gRNA.csv` or `<gene|transcript>_splice_gRNA.csv`.
*   **RefSeq Versioning**: The tool automatically strips minor version numbers from RefSeq IDs (e.g., `NM_111111.2` becomes `NM_111111`) because the underlying `refFlat` format does not support versioning.
*   **Recommended Status**: When searching by transcript, prioritize gRNAs marked as `True` in the "Recommended" column. These are typically filtered for optimal editing windows and impact.
*   **Target-AID Specificity**: Remember that this tool specifically targets C-to-T conversions. The output includes links to CRISPRdirect to help you verify off-target effects for the specific 20mer + PAM sequence.

## Reference documentation
- [KOnezumi-AID GitHub Repository](./references/github_com_aki2274_KOnezumi-AID.md)
- [Bioconda konezumiaid Overview](./references/anaconda_org_channels_bioconda_packages_konezumiaid_overview.md)