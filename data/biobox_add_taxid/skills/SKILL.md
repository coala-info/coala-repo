---
name: biobox_add_taxid
description: This tool adds a TaxID column to biobox-formatted files by mapping sequence identifiers to NCBI Taxonomy IDs using an external mapping file. Use when user asks to add taxonomic identifiers to biobox files, map BinIDs or ContigIDs to TaxIDs, or prepare metagenomics binning data for evaluation with CAMI Amber.
homepage: https://github.com/SantaMcCloud/biobox_add_taxid
metadata:
  docker_image: "quay.io/biocontainers/biobox_add_taxid:1.2--pyh7e72e81_0"
---

# biobox_add_taxid

## Overview
The `biobox_add_taxid` tool is a specialized utility for metagenomics workflows. It bridges the gap between taxonomic classification and binning evaluation by injecting a 'TaxID' column into biobox-formatted files. This process is essential for researchers who want to use CAMI Amber to assess the taxonomic accuracy of their bins, as it links specific BinIDs or ContigIDs to their corresponding NCBI Taxonomy IDs based on external mapping files.

## Usage Instructions

### Input Requirements
To use this tool effectively, you must provide two specific files:
1.  **Biobox Binning File**: The primary input, usually created via `convert_fasta_bins_to_biobox_format.py`.
2.  **Mapping File**: A reference file that maps IDs to TaxIDs. This can be:
    *   A `contig2taxid` file (standard output from Kraken2).
    *   A `binid2taxid` file (custom mapping).

### Mapping File Format
The mapping file should be structured with clear columns. For example:
```text
BinID    TaxID
test1    11056
test2    444944
```

### Column Indexing
A critical step in using the tool is identifying the correct columns in your mapping file.
*   **1-based Indexing**: The tool uses 1-based counting (the first column is 1, the second is 2, etc.).
*   You must specify the column index for the **ID** (BinID or ContigID) and the column index for the **TaxID**.

### Command Line Best Practices
*   **Flag Usage**: Ensure you are using the latest version (v1.0+) where column specifications are handled via flags rather than positional arguments.
*   **Debugging**: If the TaxIDs are not appearing correctly in the output, use the `--debug` option (introduced in v1.2) to trace the mapping logic and identify mismatched IDs.
*   **Workflow Integration**: This tool is designed to be the final step before running CAMI Amber. Ensure your biobox file is properly formatted before attempting to add TaxIDs.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biobox_add_taxid_overview.md)
- [GitHub Repository README](./references/github_com_SantaMcCloud_biobox_add_taxid.md)