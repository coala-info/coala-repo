---
name: zamp
description: zAMP is a command-line interface for reproducible amplicon-based metagenomics that processes raw sequencing data into taxonomic insights. Use when user asks to prepare reference databases, execute end-to-end analysis pipelines, or generate visualizations for metagenomic datasets.
homepage: https://github.com/metagenlab/zAMP/
---


# zamp

## Overview

zAMP is a specialized command-line interface for reproducible amplicon-based metagenomics. It streamlines the transition from raw sequencing data (local FASTQ or SRA accessions) to taxonomic insights. You should use this skill when you need to:
1. **Prepare Reference Databases**: Train taxonomic classifiers on specific primer regions (e.g., SILVA, Greengenes2, UNITE) to improve sensitivity.
2. **Execute Analysis Pipelines**: Perform end-to-end processing including read QC, Amplicon Sequence Variant (ASV) inference, and taxonomic classification.
3. **Generate Visualizations**: Produce basic plots and summary statistics for metagenomic datasets.

## CLI Usage and Best Practices

The `zamp` tool follows a standard subcommand structure: `zamp [COMMAND] [ARGS]`.

### 1. Database Preparation (`zamp db`)
Before running an analysis, you must prepare a database tailored to your primers. This increases the accuracy of taxonomic assignments.

*   **Standard Pattern**:
    ```bash
    zamp db --fasta <ref_dna.fasta> --taxonomy <ref_tax.tsv> --name <db_name> --fw-primer <SEQ> --rv-primer <SEQ> -o <output_dir>
    ```
*   **Expert Tip**: When using Greengenes2, ensure you have exported the `.qza` files to `.fasta` and `.tsv` formats using QIIME2 before passing them to `zamp db`.

### 2. Running the Pipeline (`zamp run`)
The `run` command executes the actual analysis. It requires an input sample sheet and a prepared database.

*   **Input Format**: Use a TSV file (e.g., `samples.tsv`) containing sample IDs and paths to FASTQ files or SRA accessions.
*   **Execution Pattern**:
    ```bash
    zamp run -i <samples.tsv> -db <prepared_db_name> --fw-primer <SEQ> --rv-primer <SEQ>
    ```
*   **Resource Management**: Since `zamp` is built on Snakemake, it inherits Snakemake's ability to handle resource allocation. Ensure `mamba` and `apptainer` are available in your environment for dependency management.

### 3. Common CLI Options
*   `-h, --help`: Access specific help for `db` or `run` subcommands.
*   `-v, --version`: Verify the installed version of the pipeline.
*   `citation`: Use this to generate the necessary citations for the tools bundled within the pipeline (e.g., DADA2, VSEARCH).



## Subcommands

| Command | Description |
|---------|-------------|
| insilico | Run the in-silico module for zAMP |
| run | Run zAMP |
| zamp db | Prepare database files for zAMP |

## Reference documentation
- [zAMP GitHub Repository](./references/github_com_metagenlab_zAMP_blob_master_README.md)
- [zAMP Documentation Overview](./references/github_com_metagenlab_zAMP.md)