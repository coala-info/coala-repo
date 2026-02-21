---
name: flexbar
description: Flexbar (flexible barcode and adapter removal) is a high-performance utility for the preprocessing of high-throughput sequencing data.
homepage: https://github.com/seqan/flexbar
---

# flexbar

## Overview

Flexbar (flexible barcode and adapter removal) is a high-performance utility for the preprocessing of high-throughput sequencing data. It is designed to improve read mapping rates and assembly quality by cleaning raw data. The tool supports both FASTA and FASTQ formats and utilizes SIMD and multi-core parallelism for efficient exact overlap alignments. Key capabilities include demultiplexing barcoded runs, removing adapter sequences using presets or custom files, trimming homopolymers, and extracting Unique Molecular Identifiers (UMIs).

## Installation

The most reliable way to install Flexbar is via Bioconda:

```bash
conda install -c bioconda flexbar
```

## Common CLI Patterns

### 1. Adapter Removal
Flexbar removes adapters from the right side of reads by default.

**Single-end:**
```bash
flexbar -r reads.fq -t target_output -a adapters.fa -ao 3 -ae 0.1
```
*   `-ao 3`: Minimum overlap of 3 bases.
*   `-ae 0.1`: Maximum error rate of 10%.

**Paired-end:**
```bash
flexbar -r r1.fq -p r2.fq -t target_output -a a1.fa -a2 a2.fa -ap ON
```
*   `-ap ON`: Enables pair overlap detection, which increases sensitivity for short adapter fragments.

### 2. Using Presets
For standard Illumina libraries, use built-in presets to avoid providing an adapter FASTA file.

```bash
flexbar -r r1.fq -p r2.fq -aa TruSeq -ap ON
```
*   Common presets include `TruSeq`, `SmallRNA`, and `Nextera`.

### 3. Demultiplexing
Assign reads to separate files based on barcodes.

```bash
flexbar -r reads.fq -b barcodes.fa -bt LTAIL -t demux_output
```
*   `-bt LTAIL`: Specifies the barcode is at the left tail (start) of the read.
*   Output files are named based on the barcode names in the FASTA file.

### 4. Quality-based Trimming
Trim reads based on quality scores (e.g., Illumina 1.8+ format).

```bash
flexbar -r reads.fq -t trimmed_output -q TAIL -qf i1.8 -qt 20
```
*   `-q TAIL`: Trims the right end until the threshold is met.
*   `-qt 20`: Quality threshold (default 20).

### 5. Homopolymer Trimming
Remove repetitive bases at read ends, which is common in certain sequencing technologies.

```bash
flexbar -r reads.fq -ht AT -hml 5
```
*   `-ht AT`: Trims poly-A and poly-T tails.
*   `-hml 5`: Minimum length of homopolymer to trigger trimming.

## Expert Tips

*   **Sensitivity:** If you are missing short adapter sequences, ensure `-ap ON` is used for paired-end data. This uses the overlap of the two reads to identify adapters even when the adapter overlap is very short.
*   **Performance:** Flexbar uses TBB for multi-threading. Ensure your environment has `libtbb` installed if running from binaries.
*   **Alignment Logging:** Use the logging features to inspect alignments if you suspect adapters are not being removed correctly.
*   **Compressed Files:** Flexbar natively supports `.gz` and `.bz2` input and output, saving disk space and I/O time.

## Reference documentation

- [Flexbar GitHub README](./references/github_com_seqan_flexbar.md)
- [Flexbar Wiki Home](./references/github_com_seqan_flexbar_wiki.md)
- [Bioconda Flexbar Overview](./references/anaconda_org_channels_bioconda_packages_flexbar_overview.md)