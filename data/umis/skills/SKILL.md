---
name: umis
description: The umis toolset processes UMI-tagged RNA-Seq data to extract barcodes, filter sequences, and quantify unique molecular identifiers for gene expression estimation. Use when user asks to transform FASTQ headers, filter cellular barcodes, generate barcode histograms, or count UMIs from mapped BAM files.
homepage: https://github.com/vals/umis
---


# umis

## Overview
The `umis` toolset is designed for the processing of UMI-tagged RNA-Seq data, specifically focusing on end-tag sequencing. It enables a four-step workflow: extracting non-biological sequences (Cellular Barcodes and UMIs) into read headers, filtering out low-quality or noisy barcodes, facilitating pseudo-mapping, and finally counting unique molecular identifiers to produce accurate expression estimates.

## Core Workflow and CLI Patterns

### 1. Read Transformation
Use `fastqtransform` to move Cellular Barcodes (CB) and UMIs from the sequence into the read header. This preserves the metadata while simplifying downstream mapping.

*   **Command**: `umis fastqtransform <transform.json> <fastq_r1> [<fastq_r2>]`
*   **Requirement**: A JSON transform file containing Python-style regular expressions to define the structure of the reads.
*   **Header Format**: The output FASTQ will have headers formatted as `@ID:CELL_GGTCCA:UMI_CCCT`.

### 2. Barcode Filtering and Analysis
Identify and retain only valid cellular barcodes to reduce noise from low-abundance or erroneous sequences.

*   **Filtering**: `umis cb_filter --nedit <distance> --bc <whitelist.txt> <transformed.fastq>`
    *   Use `--nedit` to allow for 1 or 2 mismatches when correcting barcodes against a known whitelist.
*   **Histogram**: `umis cb_histogram <filtered.fastq>`
    *   Generates a count file per barcode. Use this output to determine the abundance cut-off for high-quality cells.
*   **Demultiplexing**: `umis demultiplex_cells` can be used to split data into individual cell files if required for specific downstream tools.

### 3. UMI Counting
After pseudo-mapping (using tools like Kallisto or RapMap) to generate a SAM/BAM file, use `tagcount` to quantify expression.

*   **Standard Count**: `umis tagcount <input.bam>`
*   **Genome-mapped Data**: If the BAM was mapped to a genome (e.g., via STAR) and contains gene tags, use:
    *   `umis tagcount --gene_tags --gx_tag GX <input.bam>`
*   **Pre-parsed Tags**: If the BAM already contains barcodes in tags (CR for cell, UM for UMI), use:
    *   `umis tagcount --parse_tags <input.bam>`

### 4. Kallisto Integration
For users preferring the Kallisto-specific quantification pipeline, `umis` provides a reformatting utility.

*   **Command**: `umis kallisto <fastq_files>`
*   **Function**: Reformats data so that each cellular barcode has its own FASTQ and a corresponding UMI list file.

## Expert Tips
*   **Memory Efficiency**: When working with large datasets, ensure you filter barcodes (`cb_filter`) before counting to reduce the memory footprint of the UMI-to-gene evidence matrix.
*   **Dual UMIs**: Recent versions support dual UMI indexes; ensure your `transform.json` regex accounts for both segments if applicable.
*   **Sparse Matrices**: For large single-cell experiments, use `umis sparse` (if available in your version) to generate memory-efficient output formats compatible with downstream R/Python analysis packages.



## Subcommands

| Command | Description |
|---------|-------------|
| add_uid | Adds UID:[samplebc cellbc umi] to readname for umi-tools deduplication   Expects formatted fastq files with correct sample and cell barcodes. |
| bamtag | Convert a BAM/SAM with fastqtransformed read names to have UMI and cellular barcode tags |
| cb_filter | Filters reads with non-matching barcodes Expects formatted fastq files. |
| cb_histogram | Counts the number of reads for each cellular barcode |
| demultiplex_samples | Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each sample. |
| fastqtransform | Transform input reads to the tagcounts compatible read layout using regular expressions as defined in a transform file. Outputs new format to stdout. |
| fasttagcount | Count up evidence for tagged molecules, this implementation assumes the   alignment file is coordinate sorted |
| kallisto | Convert fastqtransformed file to output format compatible with kallisto. |
| mb_filter | Filters umis with non-ACGT bases Expects formatted fastq files. |
| sb_filter | Filters reads with non-matching sample barcodes Expects formatted fastq files. |
| subset_bamfile | Subset a SAM/BAM file, keeping only alignments from given cellular barcodes |
| tagcount | Count up evidence for tagged molecules |
| umi_histogram | Counts the number of reads for each UMI |
| umis demultiplex_cells | Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each cell. |
| umis sparse | Convert a CSV file to a sparse matrix with rows and column names saved as companion files. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_vals_umis.md)
- [Anaconda Bioconda Package](./references/anaconda_org_channels_bioconda_packages_umis_overview.md)