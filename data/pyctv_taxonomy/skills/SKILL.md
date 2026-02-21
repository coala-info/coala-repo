---
name: pyctv_taxonomy
description: The `pyctv_taxonomy` tool provides a streamlined interface for the ICTV Virus Metadata Resource (VMR), which is the authoritative source for viral classification.
homepage: https://github.com/linsalrob/pyctv
---

# pyctv_taxonomy

## Overview
The `pyctv_taxonomy` tool provides a streamlined interface for the ICTV Virus Metadata Resource (VMR), which is the authoritative source for viral classification. It automates the process of downloading the VMR Excel files and parsing them into usable formats. This skill allows for the rapid retrieval of taxonomic hierarchies (using the standard k__, p__, c__ prefix notation) and facilitates the cross-referencing of genomic accessions with their corresponding viral species.

## Installation
The tool is available via Bioconda or PyPI:
- Conda: `conda install bioconda::pyctv_taxonomy`
- Pip: `pip install pyctv_taxonomy`

## Common CLI Patterns

### Data Management
The tool requires a local copy of the VMR dataset to function.
- **Initial Download**: `pyctv.py download`
- **Force Update**: `pyctv.py download --force` (Use this if you suspect your local VMR file is outdated or corrupted).
- **Automatic Trigger**: The tool will automatically attempt to download the VMR the first time a query is run if the file is missing.

### Querying and Listing
Use the `list` command to extract specific subsets of the taxonomy:
- **Semicolon-delimited list**: `pyctv.py list --semi` (Useful for generating quick summaries of all viral species).
- **GenBank Mapping**: `pyctv.py list --genbank` (Outputs GenBank accession numbers alongside their viral species).
- **RefSeq Mapping**: `pyctv.py list --refseq` (Outputs RefSeq accession numbers alongside their viral species).

## Expert Tips and Best Practices
- **Taxonomy Formatting**: `pyctv_taxonomy` generates taxonomy strings using the standard taxonomic prefixes (e.g., `k__` for Kingdom, `p__` for Phylum). These can be accessed as single strings or tab-separated values depending on your downstream analysis needs.
- **Version Awareness**: The tool checks for newer versions of the VMR on execution. If a notification appears regarding a newer version, run the `download --force` command to stay current with ICTV updates.
- **Windows Usage**: If you are using the tool on Windows and have the VMR Excel file open in Microsoft Excel, the `download --force` command may fail because Excel locks the file. Close Excel before attempting to update the database.
- **GenBank/RefSeq Integration**: This tool is particularly powerful for bioinformaticians who have a list of accessions and need to assign official ICTV names rather than relying on potentially inconsistent GenBank metadata.

## Reference documentation
- [pyctv_taxonomy - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pyctv_taxonomy_overview.md)
- [GitHub - linsalrob/pyctv: Parse and incorporate the ICTV Virus Metadata Resource file](./references/github_com_linsalrob_pyctv.md)