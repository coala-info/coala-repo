---
name: sat-bsa
description: Sat-BSA is a bioinformatics toolkit for extracting reads, performing local de novo assembly, and detecting structural variants in targeted genomic regions. Use when user asks to extract local reads, perform de novo assembly, align long reads to a reference, detect structural variants, or visualize genomic comparison results.
homepage: https://github.com/SegawaTenta/Sat-BSA
---


# sat-bsa

## Overview
Sat-BSA (Satellite-Based Structural variant Analysis) is a specialized bioinformatics toolkit designed for targeted genomic analysis. It automates the workflow of extracting reads from a specific locus, performing local de novo assembly, and detecting structural variants by comparing read depth across assembled contigs. This approach is particularly effective for resolving complex structural variations that are difficult to characterize using global alignment alone. The tool integrates several third-party utilities including Canu for assembly, Minimap2 for alignment, and Samtools for data handling.

## Command-Line Usage

The tool follows a sub-command structure using the `-w` flag to specify the workflow step.

### 1. Local Read Selection
Extracts long reads aligned to a specific target region.
```bash
Sat-BSA -w Local_reads_selection -c <chr_name> -s <start_pos> -e <end_pos> -b <bam_list.txt> -f <fa_list.txt>
```
*   **-b**: Tab-delimited file with sample names and full paths to BAM files.
*   **-f**: Tab-delimited file with sample names and full paths to fasta.gz files.

### 2. Local De Novo Assembly
Performs both read selection and assembly using Canu.
```bash
Sat-BSA -w Local_de_novo_assembly -c <chr_name> -s <start_pos> -e <end_pos> -b <bam_list.txt> -f <fa_list.txt> -d <path_to_canu> -g <genome_size_Mb>
```
*   **-d**: Requires the full path to the Canu executable.
*   **-g**: Estimated genome size in Mb for the local assembly (usually a small value for targeted regions).
*   **-r**: Read status for Canu (default is `-nanopore-raw`).

### 3. Long Read Alignment
Aligns the selected or assembled reads back to a reference using Minimap2.
```bash
Sat-BSA -w Long_reads_alignment -f <aligned_read_list.txt> -r <reference.fasta> -i <ont|pb>
```
*   **-i**: Specify the sequencing technology: `ont` (Oxford Nanopore) or `pb` (PacBio).
*   **-q**: Mapping quality threshold (default is 0).

### 4. Structural Variant Detection
Identifies SVs by comparing alignment depth in the constructed contigs.
```bash
Sat-BSA -w SVs_detection -g <gene.gtf> -c <compare_list.txt> -r <reference.fasta>
```
*   **-v**: P-value threshold for Fisher's exact test (default 0.05).
*   **-f**: Minimum length of insertion/deletion to report (default 5bp).
*   **-p**: Promoter size definition (default 0).

### 5. Visualization
Generates graphs based on the SV detection results.
```bash
Sat-BSA -w Graph -r <result.txt> -c <graph_data.txt>
```
*   **-c**: Tab-delimited file containing the directory path and the color hex code for the graph lines.

## Input File Formats
All list files must be **Tab-delimited**.

*   **bam_list.txt**: `[SampleName] [PathToBam]`
*   **fa_list.txt**: `[SampleName] [PathToFastaGz]` (Multiple files for one sample should be listed on separate lines with the same sample name).
*   **compare_list.txt**: Used in `SVs_detection` to define sample pairs for comparison.
*   **graph_data.txt**: `[DirectoryPath] [Color]` (e.g., `/path/to/results #FF0000`).

## Best Practices and Tips
*   **Dependency Management**: While `sat-bsa` is available via Bioconda, the `canu` assembler is often not included in the environment automatically. Ensure `canu` is downloaded manually and its path is provided via the `-d` flag.
*   **Path Configuration**: Ensure `samtools`, `minimap2`, `R`, and `perl` are available in your system `$PATH`.
*   **Targeting**: When using `Local_de_novo_assembly`, ensure the `-g` (genome size) parameter reflects the size of the target region (e.g., 0.1 for 100kb) rather than the whole genome to ensure Canu functions correctly.
*   **GTF Requirements**: The `SVs_detection` command specifically analyzes the "transcript" feature in the provided GTF file.

## Reference documentation
- [Sat-BSA GitHub Repository](./references/github_com_SegawaTenta_Sat-BSA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sat-bsa_overview.md)