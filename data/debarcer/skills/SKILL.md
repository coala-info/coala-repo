---
name: debarcer
description: Debarcer is a bioinformatics toolset for processing molecular barcodes to extract UMIs, group reads into families, and generate high-fidelity consensus sequences. Use when user asks to preprocess FASTQ files for UMI extraction, group reads into molecular families, collapse families into consensus sequences, or perform UMI-based variant calling.
homepage: https://github.com/oicr-gsi/debarcer
---


# debarcer

## Overview

Debarcer is a specialized bioinformatics toolset for handling molecular barcodes in sequencing data. It manages the end-to-end workflow of extracting UMIs from raw reads, grouping reads into molecular families, and collapsing those families into high-fidelity consensus sequences. By accounting for sequencing errors and PCR duplicates through UMI analysis, it enables high-sensitivity variant calling.

## Core Workflow and CLI Patterns

### 1. Preprocessing (Reheadering)
Extract UMIs from FASTQ files and move them into the read headers. This must be done before alignment.

```bash
python debarcer.py preprocess \
  -o /path/to/output_dir \
  -r1 read1.fastq \
  -r2 read2.fastq \
  -p "LIBRARY_NAME" \
  -pf library_prep_types.ini \
  -c config.ini
```

### 2. UMI Grouping and Error Correction
After external alignment (e.g., BWA-MEM) and indexing, group UMIs into families based on sequence identity and genomic position.

```bash
python debarcer.py group \
  -o /path/to/output_dir \
  -r "chrN:posA-posB" \
  -b aligned_sorted.bam \
  -c config.ini
```
*   **Tip**: This generates a `.umis` binary file. The default edit distance for clustering is 1, but can be adjusted in the config.

### 3. Base Collapsing (Consensus Generation)
Collapse grouped reads into a single consensus sequence per UMI family to remove stochastic errors.

```bash
python debarcer.py collapse \
  -o /path/to/output_dir \
  -r "chrN:posA-posB" \
  -b aligned_sorted.bam \
  -u sample.umis \
  -c config.ini
```
*   **Output**: Generates a `.cons` file containing sequential base position information.

### 4. Variant Calling
Generate VCF files from the consensus data, filtered by family size (number of supporting reads per UMI).

```bash
python debarcer.py call \
  -o /path/to/output_dir \
  -r "chrN:posA-posB" \
  -cf sample.cons \
  -f "1,2,5"
```
*   **Note**: The `-f` argument specifies the minimum family sizes to include in separate VCF outputs.

### 5. Batch Processing
To process multiple genomic regions in parallel, use the `run` command with a BED file.

```bash
python debarcer.py run \
  -o /path/to/output_dir \
  -b aligned_sorted.bam \
  -be regions.bed \
  -id unique_run_id \
  -c config.ini
```

## Library Prep Configuration

Custom library types are defined in the `library_prep_types.ini` file. Key parameters include:

- **INPUT_READS**: Total FASTQ files (1-3).
- **UMI_LOCS**: Which read indices contain the UMI (e.g., `1` or `1,2`).
- **UMI_LENS**: Length of the UMI sequence.
- **SPACER**: Set to `TRUE` if a constant spacer sequence exists between the UMI and the insert.
- **UMI_INLINE**: `TRUE` if the UMI is part of the biological read, `FALSE` if it is in a separate index FASTQ.

## Best Practices

- **BAM Requirements**: Input BAM files must be coordinate-sorted and indexed. Both `.bam` and `.bam.bai` files are required for the `group` and `collapse` steps.
- **Python Version**: Use Python 3.6.4 for optimal compatibility.
- **Memory Management**: When running the `collapse` or `run` commands on large regions, ensure sufficient memory is allocated as UMI family grouping is memory-intensive.
- **Family Sizes**: Use family size 0 for uncollapsed data to compare the effect of error correction against the raw signal.



## Subcommands

| Command | Description |
|---------|-------------|
| call | Call variants based on consensus files and thresholds. |
| debarcer.py bed | Generate a BED file from a BAM file, identifying genomic intervals based on read depth. |
| debarcer.py collapse | Collapse UMIs based on various criteria. |
| debarcer.py preprocess | Preprocess FASTQ files for debarcer. |
| debarcer_run | Run the debarcer pipeline. |
| group | Group UMIs based on proximity and abundance. |
| merge | Merge files of a specified data type. |
| plot | Plotting tool for debarcer results. |
| report | Generate a report from debarcer results. |

## Reference documentation
- [Running Debarcer](./references/github_com_oicr-gsi_debarcer_wiki_2.-Running-Debarcer.md)
- [Defining Library Types](./references/github_com_oicr-gsi_debarcer_wiki_3.-Defining-Library-Types.md)
- [Debarcer Overview](./references/github_com_oicr-gsi_debarcer.md)