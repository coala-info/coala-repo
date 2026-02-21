---
name: tgsgapcloser
description: TGS-GapCloser is a specialized tool for genome assembly finishing.
homepage: https://github.com/BGI-Qingdao/TGS-GapCloser
---

# tgsgapcloser

## Overview

TGS-GapCloser is a specialized tool for genome assembly finishing. It targets the "N" regions (gaps) within draft scaffolds and attempts to fill them by aligning long reads or contigs to the gap edges. The tool is designed to handle the high error rates typical of TGS data and can perform internal error correction during the filling process. It is particularly useful for large genomes where TGS coverage might be relatively low.

## Installation and Dependencies

The tool is available via Bioconda and requires several external dependencies for full functionality:
- **Core**: `minimap2` (must be in PATH or linked in the install directory).
- **Error Correction**: `racon` (for TGS-only correction) or `pilon` (requires `java`, `samtools`, and NGS short-reads).

```bash
conda install -c bioconda tgsgapcloser
```

## Core Command Line Usage

### Basic Gap Closing (Pre-corrected Reads)
If your long reads are already error-corrected, use the `--ne` flag to skip the internal correction module and save time.

```bash
tgsgapcloser --scaff draft_scaffolds.fasta \
             --reads corrected_long_reads.fasta \
             --output assembly_v2 \
             --ne
```

### Gap Closing with ONT Reads (Racon Polishing)
For raw Oxford Nanopore reads, provide the path to the Racon executable to polish the gap-filling sequences.

```bash
tgsgapcloser --scaff draft_scaffolds.fasta \
             --reads raw_ont_reads.fasta \
             --output assembly_ont \
             --racon /path/to/bin/racon \
             --tgstype ont
```

### Gap Closing with PacBio Reads
When using PacBio data, explicitly set the TGS type to ensure appropriate alignment parameters.

```bash
tgsgapcloser --scaff draft_scaffolds.fasta \
             --reads raw_pb_reads.fasta \
             --output assembly_pb \
             --racon /path/to/bin/racon \
             --tgstype pb
```

### Hybrid Correction (Pilon + NGS)
To achieve the highest accuracy, use NGS short-reads to polish the TGS-filled gaps via Pilon.

```bash
tgsgapcloser --scaff draft_scaffolds.fasta \
             --reads raw_tgs_reads.fasta \
             --output assembly_hybrid \
             --pilon /path/to/pilon.jar \
             --ngs short_reads.fastq.gz \
             --samtools /path/to/samtools \
             --java /path/to/java \
             --pilon_mem 300G
```

## Expert Tips and Best Practices

- **Input Format Restriction**: TGS-GapCloser **only** accepts TGS reads in FASTA format. Providing FASTQ files will cause the program to crash.
- **Minimap2 Tuning**: Use the `--minmap_arg` flag to pass custom parameters to the underlying aligner. For example, if using HiFi reads, use `--minmap_arg '-x asm20'` to improve alignment sensitivity.
- **Memory Management**: When using Pilon, ensure the `--pilon_mem` value (default 300G) matches your available hardware resources to avoid OOM (Out of Memory) errors.
- **Gap Size Check**: Use `--g_check` to enable gap size difference checking if you want to ensure the filled sequence length is consistent with the estimated gap size in the scaffold.
- **Output Interpretation**:
    - `[prefix].scaff_seq`: The final improved assembly.
    - `[prefix].gap_fill_details`: A text file describing the source of every segment. Look for the 'F' type in column 3 to identify successfully filled gaps.

## Reference documentation

- [TGS-GapCloser GitHub Repository](./references/github_com_BGI-Qingdao_TGS-GapCloser.md)
- [TGS-GapCloser Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tgsgapcloser_overview.md)