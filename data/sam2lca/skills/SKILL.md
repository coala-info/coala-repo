---
name: sam2lca
description: The `sam2lca` tool is designed to resolve taxonomic ambiguity in metagenomic and environmental DNA (eDNA) datasets.
homepage: https://github.com/maxibor/sam2lca
---

# sam2lca

## Overview

The `sam2lca` tool is designed to resolve taxonomic ambiguity in metagenomic and environmental DNA (eDNA) datasets. When a sequencing read aligns to multiple reference sequences, `sam2lca` calculates the Lowest Common Ancestor—the most specific node in the NCBI taxonomic tree that encompasses all identified hits for that read. This ensures conservative and accurate taxonomic assignment, preventing over-classification when sequences are conserved across multiple species or genera.

## Core Workflows

### 1. Database Management
Before running an analysis, you must initialize or update the local taxonomic database.

*   **Initialize/Update Database**: Downloads and parses the latest NCBI taxonomy and accession-to-taxid mappings.
    ```bash
    sam2lca update-db
    ```
*   **List Available Databases**: Verify which database versions are currently stored locally.
    ```bash
    sam2lca list-db
    ```

### 2. Analyzing Alignments
The primary function of the tool is the `analyze` command, which processes alignment files to produce taxonomic assignments.

*   **Standard Analysis**:
    ```bash
    sam2lca analyze input.bam
    ```
*   **Custom Taxonomy Dumps**: As of version 1.1.4, you can provide specific NCBI taxonomy dump files (e.g., `nodes.dmp`, `names.dmp`) if you need to use a specific version of the taxonomy rather than the latest online version.

## CLI Patterns and Best Practices

### Input Requirements
*   **Accession Numbers**: The reference sequences in your SAM/BAM/CRAM headers must use NCBI accession numbers. The tool relies on these to map alignments to the NCBI Taxonomy ID (TaxID).
*   **File Formats**: While SAM is supported, using BAM or CRAM is highly recommended for better performance and reduced disk I/O.

### Common Command Options
To see specific parameters for the analysis, such as filtering thresholds or output formatting, use the help flag:
```bash
sam2lca analyze --help
```

### Performance Tips
*   **Pre-filtering**: For very large datasets, consider pre-filtering your BAM files to remove unmapped reads or low-quality alignments before running `sam2lca` to speed up processing.
*   **Database Maintenance**: Periodically run `update-db` to ensure your assignments reflect the most current NCBI taxonomy, as TaxIDs are frequently merged or updated.

## Troubleshooting
*   **Unknown TaxID Errors**: If the tool encounters accessions not present in the local database, ensure you have run `update-db` recently.
*   **Installation**: The preferred installation method is via Bioconda:
    ```bash
    conda install -c bioconda sam2lca
    ```

## Reference documentation
- [sam2lca GitHub Repository](./references/github_com_maxibor_sam2lca.md)
- [sam2lca Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sam2lca_overview.md)