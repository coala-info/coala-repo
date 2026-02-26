---
name: pysradb
description: pysradb is a command-line utility and Python library for retrieving and managing Next-Generation Sequencing metadata from SRA and GEO. Use when user asks to fetch study metadata, convert identifiers between GEO and SRA, search for genomic datasets, or download SRA data.
homepage: https://github.com/saketkc/pysradb
---


# pysradb

## Overview

`pysradb` is a specialized command-line utility and Python library that streamlines the retrieval of Next-Generation Sequencing (NGS) metadata. It acts as a bridge between various genomic repositories, allowing users to navigate the hierarchy of studies, experiments, samples, and runs without relying on manual web-based searches. This skill is essential for bioinformatics workflows that require automated data acquisition or large-scale metadata analysis across GEO and SRA.

## Core CLI Usage

### Metadata Retrieval
The primary command for obtaining study details is `metadata`.
```bash
# Fetch metadata for a specific SRA project
pysradb metadata SRP000941

# Get comprehensive records including GEO/SRP cross-references
pysradb metadata SRP000941 --detailed
```

### Identifier Conversions
`pysradb` excels at mapping accessions between GEO and SRA. The command pattern is generally `[source]-to-[target]`.
*   **GEO to SRA**: `pysradb gse-to-srp GSE12345` or `pysradb gsm-to-srr GSM12345`
*   **SRA to GEO**: `pysradb srp-to-gse SRP000941`
*   **Internal SRA Mapping**: `pysradb srp-to-srr SRP000941` (Get all Run IDs for a Project)

### Searching the Archive
Search for datasets based on keywords or specific attributes.
```bash
pysradb search "RNA-seq human brain"
```

### Downloading Data
Download all datasets associated with a project.
```bash
pysradb download SRP000941
```

## Expert Tips and Best Practices

*   **Output Handling**: `pysradb` outputs tab-separated values by default. Use standard Unix tools like `cut`, `awk`, or `column -t` to process the metadata in the terminal.
*   **Batch Processing**: For large-scale metadata enrichment, use the Python API within a script to handle multiple SRP IDs programmatically, as the CLI is optimized for single-project queries.
*   **Detailed Flag**: Always use the `--detailed` flag when you need to verify the relationship between GEO Series (GSE) and SRA Projects (SRP), as recent updates have improved the cross-referencing of these records.
*   **Environment Setup**: If using Conda, create a dedicated environment for `pysradb` to avoid dependency conflicts with older versions of pandas or requests.
    ```bash
    conda create -c bioconda -n pysradb python=3.13 pysradb
    ```

## Reference documentation
- [pysradb GitHub Repository](./references/github_com_saketkc_pysradb.md)
- [pysradb Development Commits](./references/github_com_saketkc_pysradb_commits_develop.md)