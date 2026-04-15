---
name: piler-cr
description: PILER-CR is a specialized tool designed for the rapid identification and mapping of CRISPR arrays in genomic sequences. Use when user asks to identify CRISPR repeats, find CRISPR arrays in bacterial or archaeal genomes, or analyze the structure of spacers and repeats.
homepage: http://www.drive5.com/pilercr/
metadata:
  docker_image: "quay.io/biocontainers/piler-cr:1.06--h9948957_6"
---

# piler-cr

## Overview
PILER-CR is a specialized tool designed for the rapid identification of CRISPR arrays. Unlike general repeat finders, it specifically targets the unique structure of CRISPRs—consisting of highly conserved repeats separated by non-repetitive spacers. It is particularly effective for processing large genomic datasets where speed and high sensitivity are required to map the architectural boundaries of these immune system components in bacteria and archaea.

## Command Line Usage
The basic syntax for running piler-cr is:
`pilercr -in <input_fasta> -out <output_report>`

### Common Options
- `-in <filename>`: Input file in FASTA format (required).
- `-out <filename>`: Output file for the text report (required).
- `-minrepeat <n>`: Minimum length of the repeat (default is 16).
- `-maxrepeat <n>`: Maximum length of the repeat (default is 64).
- `-minspacer <n>`: Minimum length of the spacer (default is 8).
- `-maxspacer <n>`: Maximum length of the spacer (default is 64).
- `-minarray <n>`: Minimum number of repeats in an array (default is 3).
- `-noerrlog`: Suppress error logging to stderr.

## Best Practices and Tips
- **Input Preparation**: Ensure your FASTA headers are concise. Long or complex headers in the input file can sometimes clutter the generated report.
- **Sensitivity Tuning**: If you suspect the presence of atypical CRISPRs, try lowering the `-minarray` parameter to 2, though this may increase false positives from simple tandem repeats.
- **Interpreting Results**: The output report provides a summary of each identified array, including the consensus repeat sequence, the number of repeats, and the average lengths of repeats and spacers. Pay close attention to the "Consistency" score; lower scores may indicate a degenerate array or a false positive.
- **High-Throughput Processing**: PILER-CR is optimized for speed. For metagenomic datasets or multiple genomes, use a simple shell loop to process files individually rather than concatenating them, as this keeps the output reports organized by contig/genome.

## Reference documentation
- [PILER-CR Home Page](./references/www_drive5_com_pilercr.md)
- [Bioconda piler-cr Overview](./references/anaconda_org_channels_bioconda_packages_piler-cr_overview.md)