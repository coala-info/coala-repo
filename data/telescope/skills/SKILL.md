---
name: telescope
description: Telescope resolves the ambiguity of multi-mapping reads to provide locus-specific expression profiling of repetitive elements like transposable elements. Use when user asks to reassign ambiguous fragments to their most likely locus of origin, quantify transposable element expression, or generate updated alignment files with final locus assignments.
homepage: https://github.com/mlbendall/telescope
---


# telescope

## Overview
Telescope is a computational tool designed to resolve the ambiguity of multi-mapping reads in high-throughput sequencing, a common challenge when studying repetitive elements like Transposable Elements (TEs). By using a statistical model (EM algorithm), it reassigns reads to the most likely locus of origin rather than discarding them or distributing them randomly. This allows for accurate, locus-specific expression profiling of TEs, which is critical for understanding their role in health and disease.

## Core Workflows

### 1. Initial Read Assignment
The primary command is `telescope assign`. It requires a SAM/BAM file of alignments and a GTF annotation file.

**Key Requirements:**
- **Alignment Order**: Input BAM files must be collated/sorted by read name (`samtools sort -n` or `samtools collate`). Coordinate-sorted files will fail.
- **Mapping Parameters**: Reads should be aligned with settings that allow multiple mapping locations (e.g., `bowtie2 -k 100` or similar).

**Basic Command:**
```bash
telescope assign [samfile] [gtffile]
```

### 2. Common CLI Patterns
- **Custom Attributes**: If your GTF uses a tag other than "locus" to identify TE units, specify it:
  ```bash
  telescope assign --attribute gene_id [samfile] [gtffile]
```
- **Output Management**: Use tags and directories to organize experiments:
  ```bash
  telescope assign --outdir ./results --exp_tag sample_01 [samfile] [gtffile]
```
- **Generating Updated Alignments**: To get a BAM file where reads are tagged with their final assigned locus:
  ```bash
  telescope assign --updated_sam [samfile] [gtffile]
```

### 3. Reassignment Modes
Telescope supports different strategies for the final count column in the report:
- `exclude`: (Default) Fragments with multiple "best" assignments are ignored.
- `choose`: Randomly picks one of the best assignments.
- `average`: Divides the fragment count equally among best assignments.
- `unique`: Only counts uniquely aligned reads.

Specify the mode using:
```bash
telescope assign --reassign_mode average [samfile] [gtffile]
```

### 4. Resuming and Checkpointing
For large runs that were interrupted, use the resume functionality:
```bash
telescope resume [checkpoint_file]
```

## Expert Tips
- **Validation**: Always run `telescope test` after installation to ensure the environment and floating-point precision are correct for the EM algorithm.
- **Annotation Sources**: Use specialized TE gene models (like those from the `telescope_annotation_db`) rather than standard gene annotations for best results.
- **Performance**: While `--ncpu` is an option, check the current version's documentation as multi-core support for the EM step may be limited; the primary bottleneck is often I/O and alignment parsing.



## Subcommands

| Command | Description |
|---------|-------------|
| telescope assign | Reassign ambiguous fragments that map to repetitive elements |
| telescope assign | Assigns reads to genomic features. |
| telescope resume | Resume a previous telescope run |

## Reference documentation
- [Telescope README](./references/github_com_mlbendall_telescope_blob_main_README.md)
- [Version History and Changes](./references/github_com_mlbendall_telescope_blob_main_CHANGELOG.md)
- [Environment and Dependencies](./references/github_com_mlbendall_telescope_blob_main_environment.yml.md)