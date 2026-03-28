---
name: ngsderive
description: ngsderive is a forensic tool used to infer missing or unverified metadata and library parameters from next-generation sequencing data. Use when user asks to infer RNA-seq strandedness, identify Illumina instruments, determine PHRED quality encoding, annotate splice junctions, or estimate read length and endedness.
homepage: https://github.com/claymcleod/ngsderive
---

# ngsderive

## Overview

ngsderive is a specialized forensic tool used to "back-compute" missing or unverified metadata from NGS data. It is particularly valuable when working with public datasets or legacy files where the original experimental protocol is unknown. By analyzing the internal patterns of sequencing reads and alignments, it provides "best guess" estimations for library preparation and sequencing parameters, as well as concrete annotations for splice junctions.

## Core Workflows

### Inferring RNA-Seq Strandedness
Use this to determine if a library is Stranded-Forward, Stranded-Reverse, or Unstranded.
- **Command**: `ngsderive strandedness <bam_file>`
- **Best Practice**: If the results are ambiguous, increase the number of genes sampled using `-g` or `--n-genes` (default is 1000).
- **Note**: In version 4.0.0+, `--split-by-rg` is enabled by default, providing an "overall" summary and per-read-group breakdowns.

### Identifying Illumina Instruments
Infers the specific Illumina model used based on read name and flowcell naming conventions.
- **Command**: `ngsderive instrument <bam_or_fastq>`
- **Expert Tip**: This command provides a confidence score. If the read names have been renamed or stripped of original Illumina headers, the tool may fail or provide low-confidence guesses.

### Determining PHRED Encoding
Identifies whether quality scores are encoded in Sanger (ASCII+33) or older Illumina/Solexa formats.
- **Command**: `ngsderive encoding <bam_or_fastq>`
- **Parameter**: Use `-n` or `--n-reads` to specify how many reads to sample (default is all reads in the file).

### Splice Junction Annotation
Categorizes junctions as known, novel, or partially novel against a reference gene model.
- **Command**: `ngsderive junction-annotation --gene-model <reference.gtf> <bam_file>`
- **Best Practice**: By default, unannotated contigs are discarded. Use the appropriate flags if you wish to include them in the summary as "novel."

### Estimating Read Length and Endedness
- **Read Length**: `ngsderive readlen <bam_or_fastq>` computes the distribution and guesses the original pre-trimmed length.
- **Endedness**: `ngsderive endedness <bam_file>` determines if the data is single-end or paired-end.

## Expert Tips and Best Practices

- **Output Format**: All results are returned as TSV (Tab-Separated Values). Since version 4.0.0, all headers use **PascalCase** (e.g., `ReadGroup`, `PredictedStrandedness`).
- **Read Group Awareness**: Always check for discrepancies between the BAM header read groups and the sequences actually found in the file. `ngsderive` logs errors if discrepancies are found.
- **Sampling vs. Full Scan**: For large files, commands like `encoding` and `strandedness` allow for sampling (`--n-reads` or `--n-genes`) to speed up execution without significantly sacrificing accuracy.
- **Forensic Nature**: Remember that most subcommands (except `junction-annotation`) provide a "best guess." Always validate these results against known experimental records when possible.



## Subcommands

| Command | Description |
|---------|-------------|
| ngsderive encoding | Encodes sequencing files. |
| ngsderive endedness | Derive the endedness of Next-Generation Sequencing files. |
| ngsderive instrument | Process Next-generation sequencing files (BAM or FASTQ) to derive instrument information. |
| ngsderive junction-annotation | Annotate junctions from NGS files based on a gene model. |
| ngsderive readlen | Derives read length distribution from sequencing files. |
| ngsderive strandedness | Derive strandedness from NGS files. |

## Reference documentation

- [ngsderive README](./references/github_com_stjudecloud_ngsderive_blob_master_README.md)
- [Strandedness Subcommand](./references/stjudecloud_github_io_ngsderive_subcommands_strandedness.md)
- [Instrument Subcommand](./references/stjudecloud_github_io_ngsderive_subcommands_instrument.md)
- [Junction Annotation Subcommand](./references/stjudecloud_github_io_ngsderive_subcommands_junction_annotation.md)
- [Encoding Subcommand](./references/stjudecloud_github_io_ngsderive_subcommands_encoding.md)
- [Read Length Subcommand](./references/stjudecloud_github_io_ngsderive_subcommands_readlen.md)
- [Changelog and Version 4.0.0 Changes](./references/github_com_stjudecloud_ngsderive_blob_master_CHANGELOG.md)