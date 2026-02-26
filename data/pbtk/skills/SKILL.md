---
name: pbtk
description: The pbtk toolkit provides a collection of C++ utilities for processing, converting, and managing PacBio-specific BAM files. Use when user asks to convert BAM files to FASTA or FASTQ formats, merge multiple PacBio datasets, generate PBI index files, extract HiFi reads, or filter data by ZMW metadata.
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# pbtk

## Overview
The PacBio BAM toolkit (`pbtk`) is a collection of C++ utilities for handling PacBio-specific BAM files. It is the successor to tools previously found in the `pbbam` library. Use this skill to perform essential post-sequencing tasks such as data conversion for non-BAM-compatible pipelines, dataset consolidation, and read-level filtering based on quality or ZMW (Zero-Mode Waveguide) metadata.

## Core CLI Utilities

### Data Conversion
Convert PacBio BAM files to standard sequence formats while preserving or stripping metadata.
*   **bam2fasta**: `bam2fasta -o <output_prefix> <input.bam>`
*   **bam2fastq**: `bam2fastq -o <output_prefix> <input.bam>`
    *   *Tip*: Use the `-u` flag to output uncompressed files if piping to another tool.
    *   *Tip*: These tools automatically handle the conversion of PacBio's multi-line BAM records into single-line FASTA/FASTQ entries.

### Dataset Management
*   **pbmerge**: Consolidates multiple PacBio BAM files into a single output.
    *   `pbmerge -o merged.bam input1.bam input2.bam input3.bam`
    *   *Best Practice*: Always use `pbmerge` instead of `samtools merge` for PacBio data. `pbmerge` ensures that the specialized header information (like `@RG` tags and SMRT Cell metadata) is correctly unified and preserved.
*   **pbindex**: Generates a `.pbi` index file.
    *   `pbindex <input.bam>`
    *   *Note*: The `.pbi` file is a PacBio-specific index that contains significantly more metadata than a standard `.bai` file, enabling faster filtering by ZMW or read quality.

### Filtering and Extraction
*   **extracthifi**: Specifically extracts HiFi (Circular Consensus Sequencing) reads from a BAM file.
    *   `extracthifi <input.ccs.bam> <output.hifi.bam>`
*   **zmwfilter**: Filters reads based on a list of ZMW holes or specific criteria.
    *   `zmwfilter --zmw-list <holes.txt> <input.bam> -o <filtered.bam>`
*   **pbindexdump**: Exports the contents of a `.pbi` index to a human-readable format (JSON or CSV) for inspection.
    *   `pbindexdump <input.bam.pbi>`

## Expert Tips and Best Practices
1.  **Preserve Metadata**: PacBio BAM files contain per-pulse and per-ZMW kinetics data. When converting to FASTA/FASTQ, this information is lost. Only convert to these formats for tools that cannot ingest BAM directly.
2.  **Index First**: Many `pbtk` tools and downstream PacBio tools (like `pbmm2`) require the `.pbi` index. Run `pbindex` immediately after any merge or modification.
3.  **Memory Efficiency**: `pbmerge` is highly efficient at merging large datasets because it operates on the BAM index level when possible.
4.  **Kinetics Processing**: For specialized methylation or kinetics analysis, use `ccs-kinetics-bystrandify` to reorganize kinetics data by strand, which is often required for downstream epigenetic callers.

## Reference documentation
- [pbtk - PacBio BAM toolkit Overview](./references/anaconda_org_channels_bioconda_packages_pbtk_overview.md)
- [PacBio Secondary Analysis Tools on Bioconda](./references/github_com_PacificBiosciences_pbbioconda.md)