---
name: phabox
description: PhaBOX is an integrated bioinformatics suite for identifying, classifying, and analyzing viral sequences from high-throughput sequencing data. Use when user asks to identify viral contigs, classify viruses according to ICTV taxonomy, predict bacterial or archaeal hosts, determine viral lifestyle, or perform protein annotation and vOTU grouping.
homepage: https://github.com/KennthShang/PhaBOX
metadata:
  docker_image: "quay.io/biocontainers/phabox:2.1.13--pyhdfd78af_1"
---

# phabox

## Overview

PhaBOX (specifically PhaBOX2) is an integrated bioinformatics suite designed for the comprehensive analysis of viral sequences. It serves as a local version of the PhaBOX web server, optimized for high-throughput sequencing data. The toolset consolidates several specialized programs—PhaMer, PhaGCN, CHERRY, and PhaTYP—into a single workflow. It is capable of identifying viral contigs, classifying them according to ICTV taxonomy, predicting their bacterial or archaeal hosts, and determining whether a virus is virulent or temperate (lifestyle).

## Installation and Database Setup

Before running PhaBOX, the environment must be configured and the mandatory database must be downloaded.

1.  **Environment**: Install via bioconda: `conda install bioconda::phabox`.
2.  **Database**: Download and unzip the latest database (v2.1 is required for current versions):
    ```bash
    wget https://github.com/KennthShang/PhaBOX/releases/download/v2/phabox_db_v2_1.zip
    unzip phabox_db_v2_1.zip
    ```

## Common CLI Patterns

The primary entry point is the `phabox2` command.

### End-to-End Analysis
To run all modules (identification, taxonomy, host, lifestyle, and annotation) in a single execution:
```bash
phabox2 --task end_to_end --dbdir /path/to/phabox_db_v2_1/ --outpth output_dir --contigs input.fa --threads 40
```

### Specific Task Execution
If only specific analyses are required, use the `--task` flag with one of the following modules:
*   **Virus Identification**: `--task phamer`
*   **Taxonomy Classification**: `--task phagcn`
*   **Host Prediction**: `--task cherry`
*   **Lifestyle Prediction**: `--task phatyp`
*   **Protein Annotation**: `--task annotation`
*   **vOTU Grouping**: `--task votu`
*   **Phylogenetic Tree**: `--task tree`

### Advanced Host Prediction (CHERRY)
For higher confidence in host prediction, you can provide GTDB-tk taxonomy files:
```bash
phabox2 --task cherry --dbdir db_path --outpth out_dir --contigs input.fa --bgtdb gtdbtk.tsv
```

## Expert Tips and Best Practices

*   **Resource Allocation**: PhaBOX is computationally intensive. Always specify `--threads` to match your hardware capabilities, especially for the `phagcn` and `cherry` tasks which involve heavy alignment and graph-based processing.
*   **Database Versioning**: Ensure your database version matches the software version. Version 2.1.x of the software requires the `v2_1` database. If results seem inconsistent, verify the database path in `--dbdir`.
*   **Input Requirements**: Contigs should generally be at least 1000bp for reliable identification and classification. Shorter fragments may lead to "Unknown" classifications or low-confidence scores.
*   **Prophage Detection**: When working with Whole Genome Sequencing (WGS) data where viruses might be integrated, use the `--prophage` parameter within the `cherry` task to set the minimum alignment length (default is 1000).
*   **Phylogenetic Trees**: The `--tree` task can be run with or without reference genes from the database using the `--msadb Y/N` flag. Setting it to `N` will build a tree using only the marker genes found within your input contigs.

## Reference documentation
- [PhaBOX GitHub Wiki](./references/github_com_KennthShang_PhaBOX_wiki.md)
- [PhaBOX Main Repository](./references/github_com_KennthShang_PhaBOX.md)