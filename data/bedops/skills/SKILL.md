---
name: bedops
description: BEDOPS is a high-performance toolkit for the efficient manipulation, integration, and statistical mapping of genomic features using a stream-based architecture. Use when user asks to perform set operations like union or intersection, merge overlapping regions, map signal data to reference coordinates, find nearest genomic features, or convert various genomic formats to BED.
homepage: http://bedops.readthedocs.io
---


# bedops

## Overview

BEDOPS is a high-performance toolkit designed for the efficient manipulation of genomic features. Unlike many other tools, BEDOPS utilizes a stream-based architecture that requires input files to be lexicographically sorted. This design allows it to process massive datasets with a minimal memory footprint and high execution speed. Use this skill to construct command-line pipelines for genomic data integration, feature extraction, and statistical mapping.

## Core Toolset and Usage Patterns

### 1. Sorting (The Essential First Step)
Almost all BEDOPS tools require inputs to be sorted lexicographically. Use `sort-bed` to prepare your data.
- **Standard Sort**: `sort-bed input.bed > sorted_input.bed`
- **Check Sorting**: Use the `--ec` (error-check) flag in other tools if you are unsure if the input is properly sorted.

### 2. Set Operations with `bedops`
The `bedops` tool handles Boolean set logic between any number of BED files.
- **Union (Everything)**: `bedops --everything file1.bed file2.bed > union.bed`
- **Intersection**: `bedops --intersect file1.bed file2.bed > intersection.bed`
- **Merge (Flattening)**: `bedops --merge file1.bed > merged_regions.bed`
- **Difference**: `bedops --difference reference.bed exclusions.bed > result.bed`
- **Element-of**: Find elements in A that overlap B: `bedops --element-of 1 A.bed B.bed`

### 3. Statistical Mapping with `bedmap`
Use `bedmap` to aggregate data from a "map" file onto regions in a "reference" file.
- **Basic Mapping**: `bedmap --echo --mean reference.bed map_data.bed > results.bed`
- **Common Operations**: `--count`, `--min`, `--max`, `--sum`, `--median`.
- **Overlap Criteria**: Refine mapping using `--bp-ovr` (base pair overlap) or `--fraction-ref`.

### 4. Finding Nearest Features
`closest-features` identifies the nearest elements between two files.
- **Find Nearest**: `closest-features --closest query.bed reference.bed`
- **Distances**: It provides the distance to the nearest feature by default.

### 5. Fast Extraction
For extremely large files, `bedextract` is faster than `bedops` for retrieving specific chromosomes.
- **Extract Chromosome**: `bedextract chr1 sorted_input.bed`

## Expert Tips and Best Practices

- **Chaining Commands**: Use UNIX pipes to avoid writing large intermediate files to disk.
  - Example: `gff2bed < input.gff | bedops --merge - | bedmap --echo --count - data.bed`
- **Compression with Starch**: Use the `starch` format for high-ratio compression of BED data. It supports random access by chromosome.
  - Compress: `starch input.bed > input.starch`
  - Decompress: `unstarch input.starch > input.bed`
- **Parallelization**: BEDOPS is "embarrassingly parallelizable" by chromosome. Process chromosomes independently and merge results using `starchcat`.
- **Format Conversion**: Always use the specific conversion tools (e.g., `bam2bed`, `gtf2bed`, `vcf2bed`) rather than generic scripts to ensure the resulting BED file meets the strict BEDOPS sorting and formatting requirements.
- **Memory Management**: Because BEDOPS tools are stream-based, they can process files that exceed system RAM, provided the inputs are sorted.

## Reference documentation
- [BEDOPS Overview](./references/anaconda_org_channels_bioconda_packages_bedops_overview.md)
- [BEDOPS Documentation](./references/bedops_readthedocs_io_en_latest.md)