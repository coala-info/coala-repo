---
name: f5c
description: f5c is an optimized tool for processing Oxford Nanopore raw signal data to perform methylation calling and event alignment. Use when user asks to index nanopore reads, call methylated bases, align raw signals to a reference genome, or calculate methylation frequencies.
homepage: https://github.com/hasindu2008/f5c
---

# f5c

## Overview
f5c is an optimized re-implementation of core modules from Nanopolish (index, call-methylation, and eventalign). It is designed to process Oxford Nanopore Technologies (ONT) raw signal data to detect methylated bases or align raw signals to a reference genome. f5c is significantly faster than the original Nanopolish implementation and can utilize NVIDIA GPUs (via CUDA) or AMD GPUs to accelerate the computationally intensive adaptive banded event alignment algorithm. It natively supports the high-performance BLOW5/SLOW5 data format, which is recommended for optimal I/O performance.

## Core Workflow

### 1. Indexing
Before analysis, you must link basecalled reads to their corresponding raw signal files.
```bash
# For FAST5 files
f5c index -d /path/to/raw_fast5s/ reads.fastq

# For S/BLOW5 files (Recommended)
f5c index reads.fastq
```
*Note: If using S/BLOW5, the raw signal is automatically found if the .slow5/.blow5 file is in the same directory or specified via `--slow5`.*

### 2. Calling Methylation
Detect methylated cytosines (e.g., CpG sites).
```bash
f5c call-methylation -b aligned_reads.bam -g reference.fa -r reads.fastq > methylation_calls.tsv
```

### 3. Event Alignment
Align raw signals to the reference k-mers.
```bash
f5c eventalign -b aligned_reads.bam -g reference.fa -r reads.fastq > events.tsv
```

## Expert Tips and Best Practices

### Performance Optimization
*   **Use BLOW5**: For the best performance, convert FAST5/POD5 to BLOW5 using `slow5tools` or `blue-crab`. f5c processes BLOW5 much faster than FAST5.
*   **GPU Acceleration**: If using a CUDA-enabled binary, add `--device cuda` to your command.
*   **Resource Tuning**:
    *   `-t`: Number of CPU threads (e.g., `-t 16`).
    *   `-K`: Batch size in reads (default 512). Increase for GPUs with high VRAM.
    *   `-B`: Batch size in signal points (e.g., `-B 2M`).
*   **I/O**: When using FAST5, use `-o` to specify the number of I/O threads to parallelize the slow HDF5 reading process.

### Chemistry-Specific Flags
f5c requires explicit pore versioning for certain chemistries if the information is not in the signal file:
*   **R10.4.1**: Use `--pore r10`.
*   **RNA004**: Use `--pore rna004`.
*   **S/BLOW5**: These versions are typically autodetected.

### Methylation Frequency
After running `call-methylation`, use the `meth-freq` module to calculate site-specific frequencies:
```bash
f5c meth-freq -i methylation_calls.tsv > frequencies.tsv
```



## Subcommands

| Command | Description |
|---------|-------------|
| f5c call-methylation | Call methylation from nanopore reads using f5c |
| f5c eventalign | Align nanopore events to a reference genome |
| f5c freq-merge | Merge multiple methylation frequency files into one. |
| f5c index | Build an index for accessing the base sequence (fastq/fasta) and raw signal (fast5/slow5) for a given read ID. f5c index is an extended and optimised version of nanopolish index by Jared Simpson |
| f5c meth-freq | Calculate methylation frequency from methylation calls |
| f5c resquiggle | f5c resquiggle aligns nanopore signals to reference sequences |

## Reference documentation
- [f5c README](./references/github_com_hasindu2008_f5c_blob_master_README.md)
- [f5c Documentation Overview](./references/hasindu2008_github_io_f5c_docs_overview.md)