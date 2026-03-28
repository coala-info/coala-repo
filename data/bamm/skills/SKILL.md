---
name: bamm
description: BamM is a high-performance toolkit designed for mapping reads, calculating coverage profiles, and extracting specific read subsets in metagenomic workflows. Use when user asks to map reads to a reference, generate coverage profiles, identify links between contigs, or extract reads based on their alignment to specific references.
homepage: https://github.com/Ecogenomics/BamM
---

# bamm

## Overview

BamM is a high-performance C-based toolkit wrapped in Python, optimized for the heavy lifting required in metagenomics. While general-purpose tools like PySam offer broader feature sets, BamM is purpose-built for speed and stability when calculating coverage and extracting reads. It operates primarily in three modes: mapping reads to a common reference, analyzing the resulting alignments for coverage/linkage, and extracting specific read subsets.

## Command Line Usage

BamM follows a simple subcommand structure: `bamm <command> [options]`.

### Core Commands

- **make**: Generates BAM files by mapping multiple read sets against a shared reference sequence.
  - *Requirement*: Ensure `bwa` and `samtools` are in your PATH.
  - *Usage*: Use this when you have raw FASTQ files and a reference FASTA and need to generate alignments efficiently.

- **parse**: Analyzes existing BAM files to generate coverage profiles or identify links between contigs.
  - *Usage*: Use this to determine how well your contigs are covered or to find read pairs that bridge different contigs (useful for scaffolding or binning).
  - *Tip*: This is significantly faster than standard Python-based parsers for large metagenomes.

- **extract**: Pulls specific reads from a BAM file based on their alignment to a provided list of contigs.
  - *Usage*: Use this when you need to isolate reads belonging to a specific organism or bin for downstream assembly or re-analysis.

### General Options

- To see specific parameters for any mode, use the help flag:
  `bamm make -h`
  `bamm parse -h`
  `bamm extract -h`

## Best Practices and Expert Tips

- **Environment**: BamM is strictly supported on Linux. Avoid using it on macOS or Windows as the C extensions (htslib/libcfu) often fail to compile or execute correctly on those platforms.
- **Validation**: BamM includes internal validation. If a `parse` step fails, it is often due to a malformed BAM header or a missing index. Ensure your BAM files are sorted and indexed (`samtools index`) before parsing.
- **Parameter Tuning**: BamM is designed to be "parameter-free" where possible, meaning the defaults are tuned for standard metagenomic workflows. Only override defaults if your specific library prep (e.g., unusual insert sizes) requires it.
- **Deprecation Note**: While BamM is effective for legacy workflows, the developers recommend **CoverM** for newer projects requiring even higher performance and easier installation.



## Subcommands

| Command | Description |
|---------|-------------|
| bamm filter | Apply stringency filter to Bam file reads |
| bamm make | make a BAM/TAM file (sorted + indexed) |
| bamm_extract | Extract reads which hit the given references |
| bamm_parse | get bamfile type and/or coverage profiles and/or linking reads |

## Reference documentation

- [BamM Homepage](./references/ecogenomics_github_io_BamM.md)
- [BamM GitHub Repository](./references/github_com_Ecogenomics_BamM.md)