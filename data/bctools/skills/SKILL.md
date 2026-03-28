---
name: bctools
description: bctools is a suite of scripts designed to manage barcodes and UMIs by extracting, filtering, and deduplicating technical sequences in NGS pipelines. Use when user asks to extract barcodes from reads, merge PCR duplicates, filter spurious UMIs, remove paired-end tails, or convert barcodes to binary RY-space.
homepage: https://github.com/dmaticzka/bctools
---

# bctools

## Overview
bctools is a specialized suite of Python and Perl scripts designed to manage the lifecycle of barcodes and UMIs within sequencing pipelines. It provides deterministic methods for handling the technical sequences that identify individual molecules and samples, addressing common NGS artifacts such as PCR duplication and sequencing errors in barcode regions. The toolset is particularly useful for workflows where barcodes are located at arbitrary positions or require conversion into binary RY-space.

## Core Toolset and CLI Usage

The bctools suite consists of several standalone scripts. Most follow standard Unix-style CLI patterns for bioinformatics (input/output streams or file arguments).

### Barcode Extraction
Use `extract_bcs.py` to isolate barcodes from raw sequencing reads.
- **Purpose**: Extracts barcodes from arbitrary positions relative to the start of the read.
- **Pattern**: Typically used at the beginning of a pipeline before alignment to move barcode sequences from the read into the read header.

### PCR Duplicate Merging
Use `merge_pcr_duplicates.py` to collapse your data.
- **Purpose**: Merges reads that share the same UMI and mapping position, effectively removing PCR duplicates.
- **Pattern**: Run this after alignment (BAM/SAM) to ensure that only unique biological molecules are counted.

### Filtering Erroneous UMIs
Use `rm_spurious_events.py` to improve data quality.
- **Purpose**: Filters out spurious events produced by erroneous UMIs (e.g., UMIs that are likely 1-nt mismatches of high-frequency UMIs).
- **Pattern**: Use this as a secondary cleanup step after or during deduplication to account for sequencing errors within the barcode itself.

### Paired-End Tail Removal
Use `remove_tail.py` for paired-end libraries.
- **Purpose**: Cleans up readthroughs into UMIs.
- **Pattern**: Essential for paired-end sequencing where the second read might sequence into the adapter or UMI of the first read.

### RY-Space Conversion
Use `convert_bc_to_binary_RY.py` for specific crosslinking protocols.
- **Purpose**: Handles binary RY-space barcodes.
- **Context**: Specifically used with uvCLAP and FLASH protocols.

## Best Practices and Expert Tips

- **Installation**: Always prefer the Bioconda installation to ensure all dependencies (like `pysam` and `future`) are correctly managed.
  ```bash
  conda install bctools -c bioconda -c conda-forge
  ```
- **Workflow Integration**: Barcode extraction should occur on FASTQ files before alignment, while duplicate merging must occur after alignment when genomic coordinates are available.
- **Memory Management**: When merging duplicates in large BAM files, ensure your environment has sufficient temporary space, as the tool may create intermediate files during the sorting and merging process.
- **Compatibility**: The tools are compatible with both Python 2 and Python 3 environments, but Python 3 is recommended for modern pipelines.



## Subcommands

| Command | Description |
|---------|-------------|
| convert_bc_to_binary_RY.py | Convert standard nucleotides in FASTQ or FASTA format to IUPAC nucleotide codes used for binary RY-space barcodes. A and G are converted to R. T, U and C are converted to Y. By default output is written to stdout. |
| extract_bcs.py | Exract barcodes from a FASTQ file according to a user-specified pattern. Starting from the 5'-end, positions marked by X will be moved into a separate FASTQ file. Positions marked bv N will be kept. |
| merge_pcr_duplicates.py | Merge PCR duplicates according to random barcode library. All alignments with same outer coordinates and barcode will be merged into a single crosslinking event. |
| remove_tail.py | Remove a certain number of nucleotides from the 3'-tails of sequences in FASTQ format. |
| rm_spurious_events.py | Remove spurious events originating from errors in random sequence tags. |

## Reference documentation
- [bctools Main Repository](./references/github_com_dmaticzka_bctools.md)
- [Bioconda bctools Package](./references/anaconda_org_channels_bioconda_packages_bctools_overview.md)