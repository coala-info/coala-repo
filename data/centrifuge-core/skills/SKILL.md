---
name: centrifuge-core
description: Centrifuge is a high-performance microbial classification engine that performs rapid taxonomic labeling and abundance estimation for metagenomic DNA reads. Use when user asks to download reference genomes, build compressed taxonomic indexes, classify sequencing reads, or generate summary reports for microbial identification.
homepage: https://github.com/infphilo/centrifuge
---


# centrifuge-core

## Overview

Centrifuge is a high-performance microbial classification engine designed to process millions of DNA reads in minutes. It utilizes a memory-efficient indexing strategy based on the Burrows-Wheeler Transform (BWT) and Ferragina-Manzini (FM) index, specifically tuned for metagenomic data. This skill assists in navigating the end-to-end workflow of Centrifuge, from acquiring reference genomes and building compressed taxonomic indexes to performing sensitive read labeling and abundance estimation on standard desktop hardware.

## Core Workflows and CLI Patterns

### 1. Database Preparation
Centrifuge requires a taxonomic tree and a mapping of sequence IDs to taxonomy IDs.

*   **Download Standard Databases**: Use `centrifuge-download` to fetch genomes from RefSeq or GenBank.
    ```bash
    # Download all complete archaeal, bacterial, and viral genomes
    centrifuge-download -o taxonomy taxonomy
    centrifuge-download -o library -m -d "archaea,bacteria,viral" refseq > seqid2taxid.map
    ```
*   **Required Taxonomy Files**: Ensure you have `nodes.dmp` (tree structure) and `names.dmp` (taxid to name mapping) from the NCBI taxonomy dump.

### 2. Building the Index
The `centrifuge-build` command creates the FM-index used for classification.

*   **Basic Index Build**:
    ```bash
    centrifuge-build -p 8 --conversion-table seqid2taxid.map \
                     --taxonomy-tree taxonomy/nodes.dmp \
                     --name-table taxonomy/names.dmp \
                     input_sequences.fna index_basename
    ```
*   **Expert Tip**: Building indexes for large datasets (like the BLAST `nt` database) requires significant RAM. Use the `-p` flag to parallelize the build process.

### 3. Classification and Quantification
The main `centrifuge` executable performs the alignment and classification.

*   **Classifying Paired-End Reads**:
    ```bash
    centrifuge -x index_basename -1 reads_1.fq -2 reads_2.fq -S classification_results.tsv
    ```
*   **Generating a Summary Report**: Use the `--report-file` option to get a summary of the classification.
    ```bash
    centrifuge -x index_basename -U single_reads.fq --report-file summary.tsv -S results.tsv
    ```

### 4. Inspecting Indexes
Use `centrifuge-inspect` to extract information or reference sequences from an existing index.
```bash
# List all sequence names in the index
centrifuge-inspect --names index_basename

# Extract the reference sequences
centrifuge-inspect index_basename > reference_sequences.fa
```

## Best Practices and Expert Tips

*   **Memory Efficiency**: A complete index of all bacterial and viral genomes plus the human genome typically fits within 6 GB of RAM, making it suitable for desktop analysis.
*   **64-bit Advantage**: Always prefer 64-bit builds of the binaries for large-scale metagenomic problems to avoid memory addressing limits.
*   **SRA Integration**: If compiled with SRA support (`USE_SRA=1`), Centrifuge can directly access NCBI Sequence Read Archive data using the `-s` flag.
*   **Path Configuration**: Ensure all executables (`centrifuge`, `centrifuge-build`, `centrifuge-class`, `centrifuge-download`, `centrifuge-inspect`) are in your `PATH` to allow the wrapper scripts to call the binary engines correctly.
*   **Taxonomic Consistency**: Always use the `nodes.dmp` and `names.dmp` files that correspond to the version of the genomes used during the index build to prevent taxonomic ID mismatches.



## Subcommands

| Command | Description |
|---------|-------------|
| centrifuge | Centrifuge version 1.0.4 by the Centrifuge developer team (centrifuge.metagenomics@gmail.com) |
| centrifuge-RemoveN.pl | Removes Ns from sequences in a FASTA file. |
| centrifuge-build | Builds a Centrifuge index from reference sequences. |
| centrifuge-download | Download sequence databases for Centrifuge. |
| centrifuge-kreport | centrifuge-kreport creates Kraken-style reports from centrifuge out files. |

## Reference documentation
- [Centrifuge Manual](./references/github_com_infphilo_centrifuge_blob_master_MANUAL.markdown.md)
- [Centrifuge README](./references/github_com_infphilo_centrifuge_blob_master_README.md)
- [Centrifuge Tutorial](./references/github_com_infphilo_centrifuge_blob_master_TUTORIAL.md)