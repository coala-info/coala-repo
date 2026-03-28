---
name: yacrd
description: yacrd identifies and processes chimeric reads in long-read sequencing data by analyzing pile-up coverage from all-against-all alignments. Use when user asks to detect chimeric sequences, filter low-quality reads, or scrub bad regions from genome assembly datasets.
homepage: https://github.com/natir/yacrd
---


# yacrd

## Overview

yacrd (Yet Another Chimeric Read Detector) is a specialized tool for the quality control of long-read sequencing data. It identifies chimeric reads—sequences where unrelated genomic fragments have been incorrectly joined—by analyzing pile-up coverage from all-against-all alignments. By detecting regions with insufficient coverage (bad regions), yacrd classifies reads as Chimeric, NotCovered, or NotBad. This process is essential for reducing misassemblies and improving the contiguity of genome assemblies.

## Core Workflow

The standard yacrd workflow involves two primary steps: generating overlaps and detecting/processing chimeras.

### 1. Generate Overlaps
Use an all-against-all mapper like `minimap2` to generate a Pairwise Alignment Format (PAF) file.
```bash
minimap2 -x ava-ont reads.fq reads.fq > overlap.paf
```

### 2. Detect and Process
Run yacrd to generate a report and optionally perform post-detection operations (filter, extract, split, or scrub).
```bash
yacrd -i overlap.paf -o report.yacrd scrubb -i reads.fq -o reads.scrubbed.fq
```

## Post-Detection Operations

yacrd provides four primary subcommands for handling identified reads:

- **filter**: Removes reads marked as `Chimeric` or `NotCovered` from the output.
- **extract**: Only writes reads marked as `Chimeric` or `NotCovered` to the output.
- **split**: Removes "bad regions" found in the middle of reads and discards `NotCovered` reads.
- **scrubb**: Removes all "bad regions" (including ends) and discards `NotCovered` reads.

## Recommended Parameters by Platform

For datasets with coverage > 30x, use these specific configurations:

### Oxford Nanopore (ONT)
- **Minimap2**: `-x ava-ont -g 500`
- **yacrd**: `-c 4 -n 0.4`
```bash
minimap2 -x ava-ont -g 500 reads.fasta reads.fasta > overlap.paf
yacrd -i overlap.paf -o report.yacrd -c 4 -n 0.4 scrubb -i reads.fasta -o reads.scrubb.fasta
```

### PacBio P6-C4
- **Minimap2**: `-x ava-pb -g 800`
- **yacrd**: `-c 4 -n 0.4`

### PacBio Sequel
- **Minimap2**: `-x ava-pb -g 5000`
- **yacrd**: `-c 3 -n 0.4`

## Expert Tips and Best Practices

- **Version Compatibility**: Use `minimap2` version 2.18 or earlier. Changes in seed selection in v2.19+ may impact yacrd's detection heuristics.
- **File Extensions**: yacrd relies on file extensions for format detection. Ensure your files contain:
  - `.paf` for Minimap2 output.
  - `.m4` or `.mhap` for BLASR/MHAP output.
  - `.fa` or `.fasta` for Fasta.
  - `.fq` or `.fastq` for Fastq.
  - `.yacrd` for yacrd reports.
- **Compression**: yacrd natively supports `.gz`, `.bz2`, and `.lzma`. Output files will automatically match the input compression format.
- **Report Re-usage**: You can use a previously generated `.yacrd` report as the input (`-i`) for post-detection operations to save time on re-computation.
- **Classification Logic**:
  - **Chimeric**: A "bad region" exists strictly between the start and end of the read.
  - **NotCovered**: Total "bad region" length exceeds 80% of the read length.
  - **NotBad**: Reads that do not meet the above criteria.



## Subcommands

| Command | Description |
|---------|-------------|
| filter | Record mark as chimeric or NotCovered is filter |
| split | Record mark as chimeric or NotCovered is split |
| yacrd | All bad region of read is removed |
| yacrd extract | Record mark as chimeric or NotCovered is extract |

## Reference documentation
- [yacrd Main Documentation](./references/github_com_natir_yacrd_blob_master_Readme.md)
- [yacrd Project Metadata](./references/github_com_natir_yacrd_blob_master_Cargo.toml.md)