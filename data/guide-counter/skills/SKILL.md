---
name: guide-counter
description: "guide-counter quantifies sgRNA sequences from CRISPR screen FASTQ files to produce a count matrix for downstream analysis. Use when user asks to count CRISPR guides, quantify sgRNA abundance, or generate a count table from sequencing data."
homepage: https://github.com/fulcrumgenomics/guide-counter
---

# guide-counter

## Overview

`guide-counter` is a specialized bioinformatics tool designed for the rapid and accurate quantification of sgRNA (single guide RNA) sequences from CRISPR screen experiments. It serves as a drop-in replacement for the `mageck count` command, offering significantly faster runtimes and improved data recovery. By default, the tool identifies guides with up to one mismatch, ensuring that sequencing errors do not lead to a non-trivial loss of data. It produces a count matrix that is fully compatible with downstream statistical analysis tools like `mageck test`.

## Command Line Usage

The primary command for this tool is `guide-counter count`.

### Basic Syntax
```bash
guide-counter count \
  --input sample1.fq.gz sample2.fq.gz \
  --library library_file.txt \
  --output output_prefix
```

### Key Arguments
- `--input`: One or more FASTQ files (gzipped or uncompressed).
- `--library`: A tab-delimited file containing the guide library.
- `--output`: The prefix for the generated output files (e.g., `output_prefix.counts.txt`).
- `--samples`: (Optional) Custom names for the samples, matched positionally to the input FASTQs. If omitted, filenames are used.
- `--control-pattern`: (Optional) A string pattern to identify control guides within the library.
- `--essential-genes`: (Optional) A file containing known essential genes to compute coverage metrics.
- `--nonessential-genes`: (Optional) A file containing known non-essential genes for QC purposes.

## Best Practices and Expert Tips

### 1. Data Recovery Optimization
Unlike some older tools that require exact matches, `guide-counter` allows for 1 mismatch by default. This typically results in higher read counts per sample, especially in datasets with lower sequencing quality. If your experiment requires absolute precision, ensure you check if the specific version supports an exact-match flag, though the default mismatch handling is generally preferred for biological discovery.

### 2. Downstream Integration
The output format is designed to be a seamless transition into the MAGeCK pipeline. After generating your counts, you can immediately run:
```bash
mageck test \
  --count-table output_prefix.counts.txt \
  --control-id ControlSample \
  --treatment-id TreatmentSample \
  --output-prefix results
```

### 3. Performance Tuning
`guide-counter` is written in Rust and is highly optimized for single-core performance. When processing very large datasets (hundreds of millions of reads), it significantly outperforms Python-based alternatives. Ensure your environment has sufficient I/O throughput, as the tool is often limited by disk read speeds rather than CPU.

### 4. Metadata Preparation
For the best QC results, provide the `--essential-genes` and `--nonessential-genes` files. These files can be simple text files with one gene name per line or tab-delimited files where the gene name is in the first column. This allows the tool to calculate mean coverage for these specific subsets, providing an immediate check on the screen's biological signal.



## Subcommands

| Command | Description |
|---------|-------------|
| guide-counter | A tool for counting guide RNAs in FASTQ files. |
| guide-counter count | Counts the guides observed in a CRISPR screen, starting from one or more FASTQs. FASTQs are one per sample and currently only single-end FASTQ inputs are supported. |

## Reference documentation
- [guide-counter README](./references/github_com_fulcrumgenomics_guide-counter_blob_main_README.md)
- [guide-counter Repository Overview](./references/github_com_fulcrumgenomics_guide-counter.md)