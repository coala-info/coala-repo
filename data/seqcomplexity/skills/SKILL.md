---
name: seqcomplexity
description: This tool analyzes the information density and sequence complexity of nucleotide sequences in FASTQ files. Use when user asks to calculate sequence diversity, generate per-read complexity metrics, or identify low-entropy reads for quality control.
homepage: https://github.com/stevenweaver/seqcomplexity
---


# seqcomplexity

## Overview
The `seqcomplexity` skill provides a streamlined interface for analyzing the information density of nucleotide sequences. Built in Rust for high performance, this tool processes FASTQ files to generate either a global complexity summary or detailed per-read metrics. Use this skill when you need to quantify sequence diversity to troubleshoot library preparation issues or filter out low-entropy reads that may interfere with downstream assembly or mapping.

## Usage Patterns

### Basic Complexity Analysis
To calculate the total sequence complexity for an entire FASTQ file:
```bash
seqcomplexity -q path/to/sequence.fastq
```

### Detailed Per-Read Reporting
To generate complexity scores for every individual read in the file (useful for identifying specific problematic sequences):
```bash
seqcomplexity -q path/to/sequence.fastq -p
```

## Expert Tips
- **QC Filtering**: When using the `--per-read` flag, redirect the output to a TSV or CSV file. You can then use standard CLI tools like `awk` or `datamash` to filter out reads falling below a specific complexity threshold.
- **Performance**: Because the tool is implemented in Rust, it is highly efficient. It is recommended for use on large-scale genomic datasets where Python-based complexity scripts might be too slow.
- **Integration**: Run `seqcomplexity` as a standard part of your preprocessing pipeline alongside tools like FastQC or MultiQC to catch low-diversity libraries early.

## Reference documentation
- [seqcomplexity Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqcomplexity_overview.md)
- [seqcomplexity GitHub Repository](./references/github_com_stevenweaver_seqcomplexity.md)