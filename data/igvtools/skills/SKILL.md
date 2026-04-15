---
name: igvtools
description: igvtools is a suite of command-line utilities used to preprocess and optimize large genomic datasets for efficient visualization in the Integrative Genomics Viewer. Use when user asks to convert files to TDF format, compute feature density or coverage, sort genomic files by start position, or create index files for rapid data retrieval.
homepage: http://www.broadinstitute.org/igv/
metadata:
  docker_image: "quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0"
---

# igvtools

## Overview

igvtools is a suite of command-line utilities designed to optimize genomic data for visual exploration. It addresses the performance bottlenecks associated with large datasets by converting flat files into efficient binary formats and ensuring data is properly structured for random access. This skill focuses on the four primary operations: `toTDF`, `count`, `sort`, and `index`.

## Core Utilities and CLI Patterns

### 1. toTDF (Tile Data Format)
Converts sorted data files into binary Tiled Data Format (.tdf) files. TDF files allow IGV to load data at multiple zoom levels efficiently.
- **Supported Inputs**: .wig, .cn, .snp, .igv, .gct.
- **Usage**: `igvtools toTDF <input_file> <output_file> <genome>`
- **Expert Tip**: Use the `-z` flag to specify maximum zoom levels (default is 7). Increasing this improves performance at high zoom but increases file size.

### 2. Count
Computes feature density (coverage) across the genome using a sliding window. This is the standard method for generating coverage tracks from BAM or BED files.
- **Supported Inputs**: .sam, .bam, .aligned, .psl, .bed.
- **Usage**: `igvtools count [options] <input_file> <output_file> <genome>`
- **Key Options**:
  - `-w <window_size>`: Set window size in bp (default is 25).
  - `-f <window_functions>`: Choose Mean, Max, or Median (default is Mean).
- **Note**: Input files must be sorted by start position before running `count`.

### 3. Sort
Sorts genomic files by start position. This is a prerequisite for indexing and counting.
- **Supported Inputs**: .cn, .igv, .sam, .bam, .aligned, .psl, .bed, .vcf.
- **Usage**: `igvtools sort [options] <input_file> <output_file>`
- **Expert Tip**: For very large files, use the `-t` option to specify a temporary directory with sufficient space to avoid "too many open files" or "out of memory" errors.

### 4. Index
Creates an index file for rapid data retrieval. IGV requires these indices to load large files without reading the entire dataset into memory.
- **Supported Inputs**: .sam, .bam, .vcf, .psl, .bed.
- **Usage**: `igvtools index <input_file>`
- **Output**: Generates a `.sai` (for alignments) or `.idx` (for features) file in the same directory as the input.
- **Requirement**: The input file must be sorted.

## Workflow Best Practices

- **The Preprocessing Pipeline**: The standard workflow for a new raw feature file (like a BED or VCF) is: `sort` -> `index`. For quantitative data (like BAM coverage), the workflow is: `sort` -> `count` (to .tdf).
- **Genome Identification**: Always ensure the `genome` argument matches the reference genome loaded in the IGV desktop application (e.g., `hg38`, `mm10`).
- **Memory Management**: If running into Java heap space errors on the CLI, use the `-Xmx` flag (e.g., `java -Xmx2g -jar igvtools.jar ...`) to increase allocated memory.
- **TDF vs. WIG**: Prefer `.tdf` over `.wig` for output. TDF is binary and contains precomputed zoom levels, making it significantly faster for large-scale visualization.



## Subcommands

| Command | Description |
|---------|-------------|
| igvtools | IGV Tools is a set of utilities for preprocessing and manipulating genomic data files. |
| igvtools count | The count command computes alignment coverage of an alignment file. The output is a .tdf file, which can be loaded into IGV for viewing. |
| igvtools formatexp | Formats an expression data file for use in IGV. |
| igvtools index | Creates an index for an alignment or feature file (e.g., BED, GFF, or VCF). |
| igvtools sort | Sorts an alignment file by start position. The input file must be a .sam, .bam, .aligned, or .vcf file. |
| igvtools toTDF | The toTDF command converts a sorted data file to a binary tiled data file (TDF). Supported input formats are: .wig, .bed, .gff, .map, .psl, .sam, and .bam. |

## Reference documentation
- [igvtools UI and Commands](./references/igv_org_doc_desktop_UserGuide_tools_igvtools_ui.md)
- [Batch Scripting for Automation](./references/igv_org_doc_desktop_UserGuide_tools_batch.md)
- [Loading and Data Formats](./references/igv_org_doc_desktop_UserGuide_loading_data.md)