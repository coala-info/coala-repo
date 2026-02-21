---
name: scallop-umi
description: The `scallop-umi` tool (and its successor `scallop2`) is a specialized transcript assembler that leverages the connectivity information in paired-end or linked-read RNA-seq data.
homepage: https://github.com/Shao-Group/scallop-umi
---

# scallop-umi

## Overview
The `scallop-umi` tool (and its successor `scallop2`) is a specialized transcript assembler that leverages the connectivity information in paired-end or linked-read RNA-seq data. It transforms read alignments into splice graphs and decomposes them to reconstruct the most likely set of expressed transcripts. It is particularly effective for resolving complex alternative splicing events that standard assemblers might miss.

## Installation and Setup
The most reliable way to install the tool is via Bioconda:
```bash
conda install -c bioconda scallop-umi
```
Ensure your input BAM file is sorted by coordinate before processing:
```bash
samtools sort input.bam -o input.sort.bam
```

## Core Usage Patterns

### Basic Assembly
To run a standard assembly with default parameters:
```bash
scallop2 -i input.sort.bam -o output.gtf
```

### Specifying Library Type
Providing the library orientation is highly recommended to improve assembly quality. Options include `unstranded`, `first` (fr-firststrand), or `second` (fr-secondstrand).
```bash
scallop2 -i input.sort.bam -o output.gtf --library_type first
```
If unsure, use the preview flag to check the inferred library type based on XS tags:
```bash
scallop2 -i input.sort.bam --preview
```

### Filtering and Sensitivity Tuning
Adjust these parameters to control the stringency of the assembly:
- **Coverage Thresholds**: Increase `--min_transcript_coverage` (default 1.5) to filter out lowly expressed multi-exon transcripts. For single-exon transcripts, use `--min_single_exon_coverage` (default 20).
- **Length Constraints**: The minimum length is calculated as `base + (increase * num_exons)`. Adjust `--min_transcript_length_base` (default 150) and `--min_transcript_length_increase` (default 50) to filter short fragments.
- **Mapping Quality**: Use `-min_mapping_quality` (default 1) to ignore multi-mapping or low-confidence reads.

### Advanced Refinement
- **Duplicate Handling**: Use `--assemble_duplicates` (default 10) to set the number of consensus runs during graph decomposition.
- **Splice Junction Support**: Increase `--min_splice_bundary_hits` (default 1) if you want to require more than one spliced read to support a junction.
- **Fragment Output**: To capture non-full-length transcripts that don't meet the full assembly criteria, use the `-f` or `--transcript_fragments` option to write them to a separate file.

## Expert Tips
- **XS Tags**: Scallop relies heavily on the `XS` tag in the BAM file to determine strand information. If your aligner (like STAR or HISAT2) did not generate these, you must manually specify `--library_type`.
- **Memory and Performance**: For large datasets, Scallop typically completes within an hour. If the process is slow, check the `--min_bundle_gap` (default 100); increasing this can merge smaller bundles, while decreasing it can help process highly dense regions more granularly.
- **Verbosity**: Use `--verbose 2` if you need to debug the graph decomposition process or understand why specific transcripts are being filtered.

## Reference documentation
- [Scallop2 GitHub Repository](./references/github_com_Shao-Group_scallop2.md)
- [Scallop-umi Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scallop-umi_overview.md)