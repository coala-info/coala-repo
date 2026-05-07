---
name: ncbi-datasets-cli
description: The ncbi-datasets-cli tool retrieves biological data packages from NCBI and transforms their metadata into structured formats. Use when user asks to download reference genomes, retrieve gene sequences, manage large datasets through dehydration and rehydration, or convert metadata reports into TSV format.
homepage: https://www.ncbi.nlm.nih.gov/datasets/docs/v2/how-tos/
metadata:
  docker_image: "quay.io/biocontainers/ncbi-datasets-cli:14.26.0"
---


# ncbi-datasets-cli

## Overview

The `ncbi-datasets-cli` skill provides a streamlined interface for interacting with NCBI's biological databases programmatically. It utilizes two core utilities: `datasets` for downloading comprehensive data packages (including sequences, annotations, and metadata) and `dataformat` for transforming the resulting metadata into structured formats. This skill is particularly useful for bioinformaticians needing to automate the retrieval of reference genomes, gene sequences, or viral data, and for those managing large-scale data transfers through NCBI's dehydration and rehydration workflow.

## Core CLI Patterns

### 1. Downloading Data Packages
The `datasets` tool retrieves data as a ZIP archive containing sequences and metadata.

*   **Genome by Taxon**: Download the reference genome for a specific organism.
    ```bash
    datasets download genome taxon "Homo sapiens" --reference --filename human_ref.zip
    ```
*   **Genome by Accession**: Download specific assembly versions.
    ```bash
    datasets download genome accession GCF_000001405.40 --filename grch38.zip
    ```
*   **Gene by Symbol**: Download gene sequences and metadata using symbols and taxon.
    ```bash
    datasets download gene symbol BRCA1 --taxon human --filename brca1_data.zip
    ```

### 2. Handling Large Datasets (Dehydration/Rehydration)
For large numbers of genomes, use the dehydration workflow to download metadata first and fetch sequences later.

1.  **Download Dehydrated Package**:
    ```bash
    datasets download genome taxon "Mus musculus" --dehydrated --filename mouse_dehydrated.zip
    ```
2.  **Unzip**:
    ```bash
    unzip mouse_dehydrated.zip -d mouse_data_dir
    ```
3.  **Rehydrate**: Fetch the actual sequence files.
    ```bash
    datasets rehydrate --directory mouse_data_dir/
    ```

### 3. Metadata Extraction and Formatting
The `dataformat` tool processes the `data_report.jsonl` file found inside downloaded ZIP packages.

*   **Convert to TSV**: Extract specific fields from a genome package.
    ```bash
    dataformat tsv genome --package human_ref.zip --fields organism-name,assminfo-name,accession
    ```
*   **Gene Metadata**: Extract gene-specific information.
    ```bash
    dataformat tsv gene --package brca1_data.zip --fields symbol,gene-id,description
    ```

## Expert Tips

*   **API Keys**: NCBI limits requests to 5 per second by default. Use an API key to increase this to 10 requests per second. Set the key in your environment: `export NCBI_API_KEY=your_key_here`.
*   **Filtering Genome Downloads**: Use flags like `--reference` to get only the high-quality reference assembly or `--annotated` to ensure the package includes functional annotations.
*   **Field Discovery**: If unsure of available fields for `dataformat`, use the tool's help command for the specific data type (e.g., `dataformat tsv genome --help`) to see a full list of valid field names.
*   **Taxonomy Checks**: Use `datasets summary taxonomy taxon <name>` to verify the taxonomic ID or rank before initiating a large download.



## Subcommands

| Command | Description |
|---------|-------------|
| dataformat excel | Convert data into an Excel workbook. |
| dataformat tsv | Convert data to TSV format. |
| datasets completion | This sub-command generates files needed to enable auto-complete for several popular command-line interpreters. |
| datasets download | Download genome, gene and virus data packages, including sequence, annotation, and metadata, as a zip file. |
| datasets rehydrate | Download data files for an unzipped, dehydrated genome data package. Data files specified in fetch.txt will be downloaded from NCBI. |
| datasets summary | Print a data report containing gene, genome or virus metadata in JSON format. |

## Reference documentation

- [NCBI Datasets GitHub README](./references/github_com_ncbi_datasets_blob_master_README.md)
- [NCBI Datasets Documentation Overview](./references/www_ncbi_nlm_nih_gov_datasets.md)
- [Comparative Genomics Resource Analysis Tools](./references/www_ncbi_nlm_nih_gov_comparative-genomics-resource_analysis-tools.md)