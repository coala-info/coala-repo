---
name: longgf
description: LongGF detects gene fusions from long-read transcriptome sequencing data by analyzing overlaps between alignment records and gene definitions. Use when user asks to identify gene fusions in long-read cDNA or direct mRNA sequencing data, detect fusions from name-sorted BAM files, or find reads spanning multiple gene loci.
homepage: https://github.com/WGLab/LongGF
---


# longgf

## Overview

LongGF is a high-performance tool designed to detect gene fusions from long-read transcriptome sequencing data, including both cDNA and direct mRNA sequencing. It addresses the limitations of short-read fusion detectors by handling the specific alignment errors and higher noise levels found in long-read data. The tool operates by analyzing overlaps between alignment records and gene definitions to identify reads that span multiple gene loci.

## Installation

The most efficient way to install LongGF is via Bioconda:

```bash
conda install -c bioconda longgf
```

## Command Line Usage

The basic syntax for LongGF requires five positional arguments followed by optional flags:

```bash
LongGF <input_bam> <input_gtf> <min-overlap-len> <bin_size> <min-map-len> [pseudogene] [Secondary_alignment] [min_sup_read]
```

### Required Arguments

| Argument | Description | Recommended Value |
| :--- | :--- | :--- |
| `input_bam` | BAM file of long-read data. **Must be sorted by NAME.** | N/A |
| `input_gtf` | GTF file containing gene definitions. | N/A |
| `min-overlap-len` | Minimum length of an alignment record overlap with a gene. | 100 |
| `bin_size` | The bin size used during discretization. | 30, 50, or 100 |
| `min-map-len` | Minimum length of an alignment record against the reference. | 100, 200, or 300 |

### Optional Parameters

*   **pseudogene (0/1):** Set to `1` to include pseudogenes from the GTF file. Default is `0`.
*   **Secondary_alignment (0/1):** Set to `1` to use secondary alignments in the analysis. Default is `0`.
*   **min_sup_read (int):** The minimum number of supporting reads required to report a fusion. Default is `2`.

## Best Practices and Expert Tips

### 1. Critical BAM Pre-processing
LongGF requires the input BAM to be sorted by **read name**, not by genomic position. If your BAM is position-sorted, you must re-sort it before running LongGF:

```bash
samtools sort -n -o name_sorted.bam input_position_sorted.bam
```

### 2. Capturing and Filtering Results
LongGF outputs its results to standard output (STDOUT). It is best practice to redirect this to a log file and then parse for the "SumGF" tag to see the final list of detected fusions:

```bash
# Run the tool
LongGF sample.name_sorted.bam ref.gtf 100 50 100 > longgf_output.log

# Extract detected fusions
grep "SumGF" longgf_output.log
```

### 3. Parameter Tuning
*   **bin_size:** If you are getting too many false positives in highly repetitive regions, try increasing the `bin_size`.
*   **min-map-len:** For very long reads (e.g., Nanopore), increasing `min-map-len` to 300 can help filter out short, spurious alignments that might be misidentified as fusions.
*   **Secondary Alignments:** Only enable `Secondary_alignment:1` if you suspect fusions are being missed due to multi-mapping reads, but be aware this may increase the false discovery rate.

## Reference documentation
- [LongGF GitHub Repository](./references/github_com_WGLab_LongGF.md)
- [LongGF Bioconda Package](./references/anaconda_org_channels_bioconda_packages_longgf_overview.md)