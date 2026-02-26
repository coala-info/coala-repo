---
name: pgr-tk
description: The PanGenomic Research Tool Kit performs multiscale analysis and structural decomposition of pangenomes to quantify complex genomic diversity. Use when user asks to construct minimizer databases, query genomic sequences, generate principal bundle decompositions, or visualize structural variants and genome rearrangements.
homepage: https://github.com/Sema4-Research/pgr-tk
---


# pgr-tk

## Overview
The PanGenomic Research Tool Kit (pgr-tk) is a specialized suite designed for the multiscale analysis of pangenomes. It leverages Rust for performance-critical computations and provides Python interfaces for ease of use. This skill should be applied when you need to manage large-scale genomic diversity data, specifically for repetitive or clinically relevant genes where traditional linear references fail. It is particularly effective for generating MAP graphs and performing principal bundle decomposition to visualize and quantify complex genome rearrangements and structural variants.

## Core CLI Workflows

### 1. Database Construction
Before analyzing sequences, you must index them into a pgr-tk database.

*   **Standard Minimizer Database**: Use `pgr-mdb` to create a database using the AGC (Assembled Genome Compressed) backend.
    ```bash
    pgr-mdb [options] -o output_db input.fasta
    ```
*   **Fragment Database**: Use `pgr-make-frgdb` for fragment-based minimizer indexing.
    ```bash
    pgr-make-frgdb [options] -o output_frgdb input.fasta
    ```

### 2. Querying and Extraction
Once a database is built, use `pgr-query` to retrieve sequences or identify hits.

*   **Basic Query**: Search for sequences and generate a hit summary.
    ```bash
    pgr-query db_prefix query.fasta > hits.summary
    ```
*   **Sequence Retrieval**: Generate fasta files from specific targets within the database.
    ```bash
    pgr-query --get-fasta db_prefix query.fasta
    ```

### 3. MAP Graph and Bundle Decomposition
The primary analytical power of pgr-tk lies in its ability to decompose pangenome structures.

*   **Generate Decomposition**: Create a principal bundle decomposition (BED format) from a FASTA file using the MAP graph approach.
    ```bash
    pgr-pbundle-decomp input.fasta > decomposition.bed
    ```
*   **Visualization**: Convert the decomposition BED file into an SVG for visual analysis of structural variants.
    ```bash
    pgr-pbundle-bed2svg decomposition.bed > visualization.svg
    ```

### 4. Downstream Analysis Tools
*   **Sorting**: Use `pgr-pbundle-bed2sorted` to generate annotation files with a specific sorting order based on the decomposition.
*   **Distance Metrics**: Use `pgr-pbundle-bed2dist` to calculate alignment scores between sequences based on their bundle decomposition.

## Best Practices
*   **Help Documentation**: Every command supports the `--help` flag. Use it to discover specific parameters for k-mer size and minimizer window settings, which are critical for sensitivity.
*   **Environment**: On Linux systems, pgr-tk is best managed via Bioconda. Ensure `libstdcxx-ng` and `python_abi` are correctly configured in your conda environment.
*   **Data Formats**: The toolkit primarily outputs GFA (Graphical Fragment Assembly) for graphs and BED for decomposition data, making it compatible with standard genomic visualization tools.

## Reference documentation
- [PGR-TK: Pangenome Research Tool Kit](./references/github_com_Sema4-Research_pgr-tk.md)
- [pgr-tk - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pgr-tk_overview.md)