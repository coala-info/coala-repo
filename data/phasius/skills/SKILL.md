---
name: phasius
description: phasius creates interactive phase-block maps from alignment or variant files to visualize genomic phasing consistency. Use when user asks to visualize phase blocks, compare phasing across different data types, or create HTML maps for diploid assembly validation.
homepage: https://github.com/wdecoster/phasius
metadata:
  docker_image: "quay.io/biocontainers/phasius:0.7.0--ha6fb395_0"
---

# phasius

## Overview

phasius is a high-performance Rust tool designed to create phase-block maps. It allows researchers to visualize how genomic variants are linked together into phase blocks across specific regions. By processing alignment files (BAM/CRAM) or variant calls (VCF), it produces a dynamic HTML output that provides an intuitive look at phasing consistency and block length, which is essential for diploid assembly validation and haplotyping analysis.

## Installation

Install phasius using one of the following methods:

- **Conda**: `conda install -c bioconda phasius`
- **Cargo**: `cargo install phasius`
- **Binary**: Download pre-compiled binaries from the GitHub releases page.

## Command Line Usage

The basic syntax for phasius requires a region, an output filename, and at least one input file.

### Basic Visualization
To visualize phase blocks for a specific genomic coordinate:
`phasius --region "chr1:100,000-200,000" --output visualization.html input.bam`

### Multiple Input Formats
phasius can handle a mix of BAM, CRAM, and VCF files in a single command to compare phasing across different data types or samples:
`phasius -r "chr21:10500000-10600000" -o comparison.html sample1.bam sample2.cram sample3.vcf`

### Adding Annotations
To provide genomic context (like gene models or specific regions of interest), use a bgzipped and tabix-indexed BED file:
`phasius -r "chr1:5000-10000" -b annotations.bed.gz -o annotated_map.html input.bam`

## Optimization and Best Practices

### Performance Tuning
- **Parallel Sample Processing**: Use `-t` or `--threads` to set how many input files are processed in parallel. This is highly effective when visualizing many samples simultaneously.
- **Decompression Threads**: For CRAM files, which are computationally expensive to decompress, use `-d` or `--decompression` to allocate multiple threads per file.
- **Default Threading**: By default, phasius uses 4 threads for parallel file parsing and 1 thread for decompression per file.

### Input Requirements
- **Indexing**: All BAM, CRAM, and VCF files must be indexed (using `samtools index` or `bcftools index`) to allow rapid random access to the specified region.
- **Phasing Tags**: Ensure your BAM/CRAM files contain standard phasing tags (like `HP` for haplotag and `PS` for phase set) or that your VCF uses the pipe `|` notation for phased genotypes.
- **BED Files**: BED files must be processed with `bgzip` and `tabix` to be compatible with the `-b` option.

### Expert Tips
- **Region Formatting**: The region string follows standard genomic formats (e.g., "contig:start-end"). Ensure coordinates are correct for the reference genome used in the input files.
- **HTML Portability**: The output is a self-contained HTML file, making it easy to share with collaborators or view in any modern web browser without needing a specialized viewer.

## Reference documentation
- [phasius GitHub Repository](./references/github_com_wdecoster_phasius.md)
- [phasius Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phasius_overview.md)