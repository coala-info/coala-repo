---
name: wgatools
description: wgatools is a high-performance toolkit for processing, visualizing, and analyzing Whole Genome Alignment data in MAF and PAF formats. Use when user asks to convert between MAF and PAF formats, generate dotplots, extract genomic regions, call variants, or calculate alignment statistics.
homepage: https://github.com/wjwei-handsome/wgatools
---


# wgatools

## Overview

wgatools is a specialized Rust-based suite designed for the rapid processing of Whole Genome Alignment (WGA) data. It provides a comprehensive set of utilities to handle Multiple Alignment Format (MAF) and Pairwise Mapping Format (PAF) files, which are often too large for general-purpose text tools. This skill enables efficient workflows for genomic researchers to filter alignments, visualize structural relationships through dotplots, and discover variants directly from alignment blocks.

## Core CLI Patterns

### Format Conversion
Convert between the two primary WGA formats to ensure compatibility with different downstream tools.
- **MAF to PAF**: `wgatools maf2paf -i input.maf > output.paf`
- **PAF to MAF**: `wgatools paf2maf -i input.paf -r reference.fa -q query.fa > output.maf`

### Visualization and Inspection
- **Terminal Viewer**: Use `wgatools view input.maf` to inspect alignment blocks directly in the command line with color-coded bases.
- **Dotplot Generation**: Create a visual representation of alignments to identify synteny, inversions, and translocations.
  `wgatools dotplot input.maf -o plot.pdf` (Supports both MAF and PAF).

### Region Extraction and Manipulation
- **Extract Regions**: Pull specific genomic coordinates from a large MAF file.
  `wgatools extract input.maf --region chr1:1000-2000 > subset.maf`
- **Chunking**: Split massive MAF files into smaller, manageable pieces based on sequence length.
  `wgatools chunk input.maf -l 1000000 -o output_dir/`

### Variant Calling
Discover SNPs and Indels directly from the alignment blocks.
- **Basic Call**: `wgatools call input.maf -r reference.fa > variants.vcf`
- **Memory Efficient**: For very large alignments, use the chunked calling feature to minimize RAM usage.

### Statistics and Validation
- **Alignment Stats**: Generate summary statistics (identity, coverage, length) for alignment files.
  `wgatools stat input.paf`
- **PAF Validation**: Check for and fix common formatting errors in PAF files.
  `wgatools check input.paf --fix`

## Expert Tips

- **Indexing**: For large-scale extractions, ensure your MAF file is indexed (if supported by the specific version) to avoid linear scanning of the file.
- **Filtering**: Always filter low-quality or extremely short alignment blocks before variant calling to reduce false positives.
  `wgatools filter input.maf --min-length 1000 --min-identity 0.9 > filtered.maf`
- **All-to-All Alignments**: When working with pangenomes, use `wgatools paf-cov` to calculate coverage across all-to-all alignments to identify core and accessory genomic regions.



## Subcommands

| Command | Description |
|---------|-------------|
| wgatools | A command-line tool for various genomic analyses. |
| wgatools | For more information, try '--help'. |
| wgatools_validate | Validate and fix query&target position in PAF file by CIGAR |

## Reference documentation
- [wgatools GitHub Repository](./references/github_com_wjwei-handsome_wgatools.md)
- [wgatools README](./references/github_com_wjwei-handsome_wgatools_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wgatools_overview.md)