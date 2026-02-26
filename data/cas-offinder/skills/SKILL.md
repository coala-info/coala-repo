---
name: cas-offinder
description: Cas-OFFinder is an ultrafast algorithm used to predict off-target effects in CRISPR-Cas9 and other RGEN systems by performing exhaustive genomic searches. Use when user asks to predict off-target sites, account for degenerate PAM sequences, or identify potential DNA and RNA bulges.
homepage: https://github.com/snugel/cas-offinder
---


# cas-offinder

## Overview

Cas-OFFinder is an ultrafast, OpenCL-based algorithm used to predict off-target effects in CRISPR-Cas9 and other RGEN systems. While many off-target search tools limit the number of mismatches to improve speed, Cas-OFFinder provides an exhaustive search across the entire genome without such restrictions. It is the preferred tool when you need to account for degenerate PAM sequences, high mismatch counts, or structural variations like DNA and RNA bulges. This skill provides the procedural knowledge to configure input files, manage hardware acceleration, and execute searches efficiently.

## Command Line Usage

The basic syntax for Cas-OFFinder is:

`cas-offinder {input_file|-} {device_type}[device_id(s)] {output_file|-}`

### Device Selection
Cas-OFFinder requires an OpenCL-compatible device. Specify the hardware using the following codes:
- **G**: GPU (Recommended for speed)
- **C**: CPU
- **A**: Accelerator
- **Device IDs**: Optional. Use `G0` for the first GPU, or `G0,1` / `G0:2` for multiple devices.

### Input File Structure
The input file is a plain text file with a specific four-part structure:

1.  **Genome Path**: The first line must be the directory containing the reference genome in FASTA or .2bit format.
2.  **Pattern and Bulges**: The second line defines the target pattern (including PAM) and optional bulge sizes.
    - Format: `[Pattern] [Max_DNA_Bulge] [Max_RNA_Bulge]`
    - Example: `NNNNNNNNNNNNNNNNNNNNNRG 2 1`
3.  **Query Sequences**: Each subsequent line contains a specific guide sequence and the maximum allowed mismatches.
    - Format: `[Sequence] [Max_Mismatches] [Optional_ID]`
    - Example: `GGCCGACCTGTCGCTGACGCNNN 5 Seq1`

### Supported IUPAC Codes
For both the pattern (Line 2) and query sequences (Line 3+), you can use degenerate base codes to account for PAM variations:
- **R**: A or G
- **Y**: C or T
- **S**: G or C
- **W**: A or T
- **K**: G or T
- **M**: A or C
- **N**: Any base

## Expert Tips and Best Practices

### Performance Optimization
- **Use .2bit Files**: While FASTA is supported, using .2bit files for the reference genome significantly reduces memory overhead and improves loading times.
- **GPU Acceleration**: Always prefer GPU (`G`) over CPU (`C`) for large-scale genomic searches. Cas-OFFinder is designed to leverage the parallel processing power of graphics cards.
- **Batching Queries**: You can include hundreds of query sequences in a single input file. This is more efficient than running the tool multiple times for individual guides.

### Handling Version Differences
- **Version 2.x**: The stable production version. Use this for standard mismatch searches without bulges.
- **Version 3.x (Beta)**: Introduces support for DNA and RNA bulges. Note that results may differ slightly from v2; use v3 only when structural bulges are a critical part of your analysis.

### Stream Processing
Use the `-` character to read from `stdin` or write to `stdout`. This is useful for piping results directly into downstream analysis tools or filtering utilities without creating massive intermediate files.

`cat input.txt | cas-offinder - G - > results.tsv`

## Reference documentation
- [Cas-OFFinder Overview](./references/anaconda_org_channels_bioconda_packages_cas-offinder_overview.md)
- [Cas-OFFinder GitHub Documentation](./references/github_com_snugel_cas-offinder.md)