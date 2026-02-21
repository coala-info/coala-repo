---
name: trimadap
description: `trimadap` is a specialized C-based utility designed by Heng Li for the rapid removal of adapter sequences from Illumina sequencing data.
homepage: https://github.com/lh3/trimadap
---

# trimadap

## Overview
`trimadap` is a specialized C-based utility designed by Heng Li for the rapid removal of adapter sequences from Illumina sequencing data. It utilizes SSE2-accelerated Smith-Waterman alignment to identify adapters. While it is characterized as "fast but inaccurate" compared to more exhaustive trimmers, its primary strength lies in its performance as an on-the-fly stream filter. In multi-threaded mode, it can process data as quickly as a system can read a gzip-compressed FASTQ file, making it ideal for initial data cleaning or real-time processing pipelines.

## CLI Usage and Patterns

### Basic Execution
`trimadap` is designed to work with standard streams. By default, it uses the adapter sequences provided in the `illumina.txt` file included with the source.

```bash
# Basic usage as a stream filter
cat reads.fq | trimadap > trimmed_reads.fq

# Processing compressed data
gzip -dc reads.fq.gz | trimadap | gzip > trimmed_reads.fq.gz
```

### Multi-threading
For maximum performance, use the multi-threaded version (`trimadap-mt`). This is essential when processing large-scale Illumina datasets to ensure the trimmer does not become the bottleneck in the pipeline.

```bash
# Using multi-threaded mode (if compiled as trimadap-mt)
trimadap-mt [options] input.fq > output.fq
```

### Common Heuristic Adjustments
Based on the tool's development history, users can often tune the sensitivity and behavior using specific flags (though options may vary by version, the following are standard for this toolset):

- **Minimum Score (`-s` or `min_sc`)**: Adjusts the alignment score threshold. The default is typically 15. Lowering this increases sensitivity but may increase false positives.
- **Minimum Length (`-l` or `min_len`)**: Sets the minimum length of the read to keep after trimming.
- **Adapter Trimming**: The tool identifies the adapter position and can optionally trim the adapter sequence off the 3'-end.

### Expert Tips
- **Stream Integration**: Because `trimadap` is a lightweight stream filter, it is best used in a pipe (`|`) between a decompressor (like `zcat` or `pigz`) and an aligner (like `bwa` or `minimap2`).
- **Conservative Trimming**: Keep in mind that `trimadap` is conservative. If your downstream analysis is extremely sensitive to even short adapter fragments, you may need a second pass with a more exhaustive trimmer, though `trimadap` will have already handled the bulk of the work.
- **Custom Adapters**: While it defaults to standard Illumina adapters, you can provide custom sequences if your library preparation used non-standard indices or universal adapters.

## Reference documentation
- [github_com_lh3_trimadap.md](./references/github_com_lh3_trimadap.md)