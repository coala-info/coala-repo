---
name: ncbi-datasets-cli
description: The ncbi-datasets-cli is a command-line toolset for downloading genomic data and metadata from NCBI. Use when user asks to download genome or gene data, retrieve biological metadata, or convert NCBI data packages into tabular formats like TSV or Excel.
homepage: https://www.ncbi.nlm.nih.gov/datasets/docs/v2/how-tos/
metadata:
  docker_image: "quay.io/biocontainers/ncbi-datasets-cli:14.26.0"
---


# ncbi-datasets-cli

## Overview

The `ncbi-datasets-cli` is a modern suite of command-line tools designed to streamline the retrieval of biological data from NCBI. It consists of two primary binaries: `datasets` for querying and downloading data packages, and `dataformat` for converting the resulting JSON Lines metadata into human-readable formats like TSV or Excel. This toolset is the preferred method for accessing eukaryotic genomes, gene information, and viral data, offering a more structured and reliable alternative to legacy scripts or manual web downloads.

## Installation

The tools are most easily installed via conda:
```bash
conda install -c conda-forge ncbi-datasets-cli
```

## Core Workflows

### 1. Downloading Genome Data
To download a genome, you can specify a taxon (e.g., "human", "mus musculus") or a specific assembly accession.

*   **Download by Taxon (Reference Genome):**
    ```bash
    datasets download genome taxon human --reference --filename human_ref.zip
    ```
*   **Download by Accession:**
    ```bash
    datasets download genome accession GCF_000001405.40 --filename grch38.zip
    ```

### 2. Downloading Gene Data
Retrieve sequence and metadata for specific genes using NCBI Gene IDs or symbols.

*   **Download by Gene ID:**
    ```bash
    datasets download gene gene-id 672 --filename brca1_data.zip
    ```
*   **Download by Symbol and Taxon:**
    ```bash
    datasets download gene symbol brca1 --taxon human --filename brca1_human.zip
    ```

### 3. Handling Large Downloads (Dehydration/Rehydration)
For large-scale genomic studies involving hundreds or thousands of assemblies, use the "dehydrated" workflow to avoid massive initial zip files.

1.  **Download Dehydrated Archive:**
    ```bash
    datasets download genome taxon "felis catus" --dehydrated --filename cat_genomes.zip
    ```
2.  **Unzip:**
    ```bash
    unzip cat_genomes.zip -d cat_data/
    ```
3.  **Rehydrate (Fetch actual sequences):**
    ```bash
    datasets rehydrate --directory cat_data/
    ```

### 4. Extracting Metadata with `dataformat`
NCBI data packages include metadata in `.jsonl` format. Use `dataformat` to create tables.

*   **Convert Genome Metadata to TSV:**
    ```bash
    dataformat tsv genome --package human_ref.zip --fields organism-name,assminfo-name,accession
    ```
*   **Convert Gene Metadata to TSV:**
    ```bash
    dataformat tsv gene --package brca1_data.zip --fields symbol,gene-id,description
    ```

## Expert Tips and Best Practices

*   **Rate Limiting:** By default, NCBI limits requests to 5 per second. Use an NCBI API key to increase this to 10 per second by setting the `NCBI_API_KEY` environment variable.
*   **Filtering Assemblies:** When downloading genomes by taxon, use flags like `--reference` (for the reference assembly only) or `--annotated` (to ensure the assembly has functional annotation).
*   **Check Summary First:** Before downloading large files, use the `summary` command to see what is available:
    ```bash
    datasets summary genome taxon "sars-cov-2"
    ```
*   **File Management:** Always specify a `--filename` ending in `.zip` to keep your workspace organized, as the default behavior may create generic filenames.



## Subcommands

| Command | Description |
|---------|-------------|
| dataformat excel | Convert data into an Excel workbook. |
| dataformat tsv | Convert data to TSV format. |
| datasets completion | This sub-command generates files needed to enable auto-complete for several popular command-line interpreters. |
| datasets download gene | Download a gene data package. Gene data packages include gene, transcript and protein sequences and one or more data reports. Data packages are downloaded as a zip archive. |
| datasets download genome | Download a genome data package. Genome data packages may include genome, transcript and protein sequences, annotation and one or more data reports. Data packages are downloaded as a zip archive. |
| datasets download virus | Download a virus genome or SARS-CoV-2 protein data package as a zip file. |
| datasets rehydrate | Download data files for an unzipped, dehydrated genome data package. Data files specified in fetch.txt will be downloaded from NCBI. |
| datasets summary gene | Print a data report containing gene metadata. The data report is returned in JSON format. |
| datasets summary genome | Print a data report containing genome metadata. The data report is returned in JSON format. |
| datasets summary virus | Print a data report containing virus genome metadata by accession or taxon. The data report is returned in JSON format. |

## Reference documentation
- [NCBI Datasets GitHub README](./references/github_com_ncbi_datasets_blob_master_README.md)
- [NCBI Datasets How-to Guides](./references/www_ncbi_nlm_nih_gov_datasets_docs_v2_how-tos.md)
- [Comparative Genomics Resource Analysis Tools](./references/www_ncbi_nlm_nih_gov_comparative-genomics-resource_analysis-tools.md)