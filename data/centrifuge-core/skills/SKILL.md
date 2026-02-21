---
name: centrifuge-core
description: Centrifuge is a specialized metagenomic classifier designed for speed and memory efficiency.
homepage: https://github.com/infphilo/centrifuge
---

# centrifuge-core

## Overview
Centrifuge is a specialized metagenomic classifier designed for speed and memory efficiency. It uses a novel indexing scheme based on the Burrows-Wheeler transform (BWT) and the Ferragina-Manzini (FM) index, allowing it to store massive genomic databases (like all complete bacterial and viral genomes) in a relatively small footprint. This skill provides guidance on building indices, classifying high-throughput sequencing reads, and converting raw results into human-readable taxonomic reports.

## Core Workflows and CLI Patterns

### 1. Index Generation
Before classification, you must build an index from reference sequences.

*   **Standard Build**:
    ```bash
    centrifuge-build -p <threads> --conversion-table <taxid_map> \
                     --taxonomy-tree <nodes.dmp> --name-table <names.dmp> \
                     input_sequences.fa <index_base>
    ```
*   **Using Pre-configured Recipes**: The source repository includes a Makefile in the `indices/` directory for common targets:
    *   `make p+h+v`: Builds an index for all complete bacterial, human, and viral genomes.
    *   `make p_compressed`: Builds an index with bacterial genomes compressed at the species level to save space.

### 2. Sequence Classification
The primary `centrifuge` executable performs the alignment and classification.

*   **Paired-end Reads**:
    ```bash
    centrifuge -x <index_base> -1 <reads_1.fq> -2 <reads_2.fq> -S <output.results>
    ```
*   **Single-end Reads**:
    ```bash
    centrifuge -x <index_base> -U <reads.fq> -S <output.results>
    ```
*   **Key Options**:
    *   `-p <int>`: Number of threads to use.
    *   `-k <int>`: Report up to `<int>` assignments per read (default is 1).
    *   `--report-file <file>`: Output a summary report containing classification statistics.

### 3. Taxonomic Reporting
Raw output from `centrifuge` is often difficult to interpret. Use `centrifuge-kreport` to generate a Kraken-style report.

```bash
centrifuge-kreport -x <index_base> <output.results> > <human_readable_report.txt>
```

### 4. Data Acquisition
Use the `centrifuge-download` script to fetch standard NCBI datasets.

```bash
# Download bacterial genomes
centrifuge-download -o taxonomy taxonomy
centrifuge-download -o library -m -d "bacteria" refseq > seqid2taxid.map
```

## Expert Tips and Best Practices
*   **Memory Management**: A complete bacterial, viral, and human index typically requires ~4.7 GB of RAM. If working on a machine with limited resources, use the "compressed" index versions which group sequences at the species level.
*   **Input Formats**: Centrifuge supports FASTA and FASTQ files. It can also handle compressed files (e.g., `.gz`) if specified or piped.
*   **Sensitivity vs. Speed**: Centrifuge is optimized for classification. For very short reads or highly divergent species, ensure your index includes a broad enough taxonomic representation to avoid false negatives.
*   **Filtering**: Use the provided utility scripts like `centrifuge-RemoveN.pl` to clean input sequences before building an index to improve index quality and reduce size.

## Reference documentation
- [Centrifuge GitHub Repository](./references/github_com_infphilo_centrifuge.md)
- [Bioconda Centrifuge-core Overview](./references/anaconda_org_channels_bioconda_packages_centrifuge-core_overview.md)