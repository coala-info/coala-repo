---
name: align_trim
description: The provided text does not contain help information or usage instructions for the tool; it is a log of a container build failure (no space left on device).
homepage: https://github.com/artic-network/align_trim
---

# align_trim

## Overview

The `align_trim` tool is a specialized utility for "soft clipping" primer sequences from the ends of aligned reads. In amplicon-based sequencing, primers are synthetic sequences that can introduce false variants if not removed before downstream analysis. This tool uses a primer scheme (in BED format) to identify where reads overlap with primers and masks those regions. It also provides advanced features for subsampling (normalization) to a specific coverage depth and generating detailed reports on amplicon performance.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Conda
conda install bioconda::align_trim

# Via Pip
pip install align_trim
```

## Core Usage Patterns

### Basic Primer Trimming
The most common use case is trimming primers from a sorted BAM file and outputting a new BAM file.

```bash
aligntrim primers.bed --samfile input.bam --output trimmed.bam
```

### Coverage Normalization
To reduce computational load and bias in high-depth samples, use the `--normalise` flag to subsample reads to a specific depth per amplicon.

```bash
# Subsample to 100x coverage per amplicon
aligntrim primers.bed -s input.bam -n 100 -o normalized.bam
```

### Streaming with Samtools
`align_trim` supports stdin and stdout, making it easy to integrate into shell pipes.

```bash
samtools view -h input.bam | aligntrim primers.bed --verbose > trimmed.sam
```

## Expert Tips and Best Practices

### 1. Output Format Detection
The tool determines the output format based on the file extension provided to `--output`. Use `.bam` for compressed binary output and `.sam` for text output. If no extension is provided or `-` is used, it defaults to SAM on stdout.

### 2. Handling Rapid Barcoding or Fragmented Reads
By default, the tool expects reads to be correctly paired. If you are working with protocols that produce non-standard fragments:
- Use `--allow-incorrect-pairs` if reads are assigned to amplicons but primers don't match the expected pairs.
- **Avoid** `--require-full-length` for rapid barcoding kits, as this flag discards any read that doesn't span the entire distance between primer sites.

### 3. Quality Control and Reporting
Always generate reports when processing new primer schemes or troubleshooting "primer dropout" issues:
- `--report (-r)`: Generates a TSV detailing every read's primer assignment and pairing status.
- `--amp-depth-report (-a)`: Provides the mean depth for every amplicon, which is vital for identifying poorly performing primers in a pool.

### 4. Fuzzy Matching
If your alignments don't perfectly align with the BED file coordinates (due to sequencing errors at the very ends of reads), increase the `--primer-match-threshold` (default is 35bp) to allow for more flexibility in primer identification.

### 5. Filtering by Mapping Quality
To ensure only high-confidence alignments are used for trimming and downstream analysis, set the `--min-mapq` flag. The default is 20, but for highly repetitive genomes, increasing this to 30 or 60 can reduce noise.

## Reference documentation
- [align_trim GitHub README](./references/github_com_artic-network_align_trim.md)
- [Bioconda align_trim Overview](./references/anaconda_org_channels_bioconda_packages_align_trim_overview.md)