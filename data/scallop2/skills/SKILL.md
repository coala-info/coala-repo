---
name: scallop2
description: Scallop2 is a reference-based transcript assembler optimized for reconstructing transcripts from paired-end and multiple-end RNA-seq data. Use when user asks to assemble transcripts from RNA-seq alignments, reconstruct transcriptomes from BAM files, or identify isoforms using splice graphs.
homepage: https://github.com/Shao-Group/scallop2
---


# scallop2

## Overview

Scallop2 is a specialized tool for assembling transcripts using a reference-based approach. It builds upon the original Scallop assembler but is specifically optimized to handle the complexities of paired-end and multiple-end RNA-seq data. By analyzing splice graphs derived from read alignments, it reconstructs the most likely set of transcripts, making it a critical step in transcriptome analysis workflows.

## Installation

The most efficient way to install Scallop2 is via Conda:

```bash
conda install bioconda::scallop2
```

## Basic Usage

The core workflow requires a sorted BAM file as input and produces a GTF file containing the reconstructed transcripts.

```bash
scallop2 -i input.sort.bam -o output.gtf
```

**Note:** The input BAM file must be sorted by coordinate. If it is not, use samtools:
`samtools sort input.bam > input.sort.bam`

## Library Type Configuration

Specifying the library type is highly recommended for accurate assembly. Scallop2 supports three types:
- `unstranded`
- `first` (fr-firststrand)
- `second` (fr-secondstrand)

If not specified, Scallop2 attempts to infer the type using the `XS` tag in the BAM file.

### Previewing Library Type
Before running a full assembly, use the preview flag to check the inferred library type:
```bash
scallop2 -i input.sort.bam --preview
```

## Common CLI Patterns and Parameters

### Filtering Low-Expression Transcripts
Adjust coverage thresholds to filter out noise or lowly expressed isoforms:
- `--min_transcript_coverage <float>`: Minimum coverage for multi-exon transcripts (Default: 1.5).
- `--min_single_exon_coverage <float>`: Minimum coverage for single-exon transcripts (Default: 20).

### Controlling Transcript Length
Scallop2 uses a formula to determine the minimum allowed length: `min_length = base + (increase * num_exons)`.
- `--min_transcript_length_base <int>`: Default 150.
- `--min_transcript_length_increase <int>`: Default 50.

### Quality Control
- `--min_mapping_quality <int>`: Ignore reads with mapping quality below this value (Default: 1).
- `--max_num_cigar <int>`: Ignore reads with excessively large CIGAR strings (Default: 1000).

## Expert Tips

1. **XS Tag Dependency**: If your aligner (e.g., STAR) did not generate `XS` tags and your library is stranded, you **must** manually specify `--library_type`. Without `XS` tags, Scallop2 cannot automatically infer strand orientation.
2. **Verbosity Levels**: Use `--verbose 2` if you need to debug the graph decomposition process, or `--verbose 0` for quiet operation in automated pipelines.
3. **Non-Full-Length Transcripts**: If you are interested in fragments that couldn't be assembled into full transcripts, use the `-f` or `--transcript_fragments` option to write them to a separate file.
4. **Splice Junction Support**: In high-depth datasets, consider increasing `--min_splice_bundary_hits` (Default: 1) to reduce the assembly of transcripts supported by only a single chimeric or poorly aligned read.

## Reference documentation
- [Scallop2 GitHub Repository](./references/github_com_Shao-Group_scallop2.md)
- [Scallop2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scallop2_overview.md)