---
name: ganon
description: Ganon classifies DNA sequences and performs metagenomic analysis using indexed reference databases. Use when user asks to build or update taxonomic databases, assign taxonomic labels to sequencing reads, generate abundance reports, or create multi-sample contingency tables.
homepage: https://github.com/pirovc/ganon
---


# ganon

## Overview
Ganon is a high-performance bioinformatics toolset designed for the efficient classification of DNA sequences. It streamlines the metagenomic analysis pipeline by providing integrated tools to download genomic data, build indexed databases using Bloom filters and minimizers, and assign taxonomic labels to sequencing reads. It is particularly useful for researchers needing to manage massive reference datasets or perform hierarchical classification across multiple taxonomic levels.

## Core CLI Patterns

### Database Construction
Use `ganon build` to create or update reference databases. It supports automated fetching of NCBI or GTDB data.

*   **Build from NCBI RefSeq (Archaea):**
    ```bash
    ganon build --db-prefix archaea_db --source refseq --organism-group archaea --complete-genomes --threads 24
    ```
*   **Build from local FASTA files:**
    ```bash
    ganon build --db-prefix custom_db --input-files seq1.fasta seq2.fasta --taxonomy ncbi
    ```

### Sequence Classification
Use `ganon classify` to map reads against one or more databases.

*   **Classify paired-end reads:**
    ```bash
    ganon classify --db-prefix archaea_db --paired-reads reads.1.fq.gz reads.2.fq.gz --output-prefix sample_results --threads 24
    ```
*   **Hierarchical classification:**
    Run classification against multiple databases in a specific order (e.g., host first, then microbes).
    ```bash
    ganon classify --db-prefix human_db microbes_db --output-prefix multi_level_results
    ```

### Reporting and Abundance Estimation
Use `ganon report` to transform raw classification results into human-readable taxonomic profiles.

*   **Generate a taxonomic report with genome size correction:**
    ```bash
    ganon report --input-prefix sample_results --output-report sample.tre --report-type abundance --genome-size-correction
    ```
*   **Filter report by taxonomic rank:**
    ```bash
    ganon report --input-prefix sample_results --rank species --output-report species_abundance.txt
    ```

### Multi-sample Analysis
Use `ganon table` to create contingency tables (OTU-like tables) from multiple classification runs.

*   **Create a comparison table for multiple samples:**
    ```bash
    ganon table --input-prefixes sample1_results sample2_results sample3_results --output-file study_comparison.tsv
    ```

## Expert Tips
*   **Memory Management:** Ganon uses Bloom filters. If you encounter memory constraints during `build`, adjust the `--bin-length` or `--max-fp` (false positive rate) parameters.
*   **Incremental Updates:** You can update an existing database without rebuilding it from scratch by using the same `--db-prefix` and providing new input files or updated organism groups.
*   **Algorithm Selection:** By default, Ganon uses a unique-matching strategy. For complex samples, consider using the EM (Expectation-Maximization) or LCA (Lowest Common Ancestor) algorithms provided in the reporting stage to resolve multi-matching reads.
*   **Long Reads:** If working with PacBio or Oxford Nanopore data (>65kbp), ensure the tool was compiled with `LONGREADS` support (standard in most bioconda distributions) to handle high k-mer counts per read.



## Subcommands

| Command | Description |
|---------|-------------|
| ganon build | Build a Ganon database |
| ganon build-custom | Build a custom Ganon database. |
| ganon classify | Classify reads against a database. |
| ganon report | Report generation from Ganon classification results. |
| ganon_table | Create a table from Ganon report files. |
| ganon_update | Update an existing Ganon database. |
| reassign | Reassigns sequences based on EM algorithm. |

## Reference documentation
- [ganon GitHub Repository](./references/github_com_pirovc_ganon.md)
- [ganon README](./references/github_com_pirovc_ganon_blob_main_README.md)
- [ganon User Manual (External)](https://pirovc.github.io/ganon/)