---
name: samstats
description: `samstats` is a specialized tool for calculating mapping statistics from SAM (Sequence Alignment/Map) files.
homepage: https://github.com/kundajelab/SAMstats
---

# samstats

## Overview

`samstats` is a specialized tool for calculating mapping statistics from SAM (Sequence Alignment/Map) files. Unlike standard tools that report statistics based on every alignment record in a file, `samstats` aggregates data at the read level. This provides a more accurate view of the underlying sequencing library by ensuring that a single read with multiple alignment entries does not artificially inflate mapping counts. It is primarily used in bioinformatics pipelines for quality control (QC) to determine the percentage of reads that are uniquely mapped, unmapped, or properly paired.

## Command Line Usage

The tool provides two primary executables: `SAMstats` for single-threaded processing and `SAMstatsParallel` for multi-threaded execution.

### Basic Syntax

To run the standard single-threaded version:

```bash
SAMstats --sorted_sam_file <input.sam> --outf <output_stats.txt> --chunk_size 1000
```

To run the multi-threaded version:

```bash
SAMstatsParallel --sorted_sam_file <input.sam> --outf <output_stats.txt> --chunk_size 1000 --threads 4
```

### Parameters

- `--sorted_sam_file`: Path to the input SAM file. **Note**: The file must be sorted by coordinate or read name for the tool to correctly group read pairs and multi-mappers.
- `--outf`: The destination path for the generated statistics report.
- `--chunk_size`: The number of reads to process in a single batch. Increasing this can improve performance but increases memory usage.
- `--threads`: (Only for `SAMstatsParallel`) The number of CPU cores to utilize.

## Expert Tips and Best Practices

- **Input Requirements**: Always ensure your SAM file is sorted before running `samstats`. If you have a BAM file, convert it to SAM using `samtools view` first, as the tool expects SAM format.
- **Performance Considerations**: While `SAMstatsParallel` is available, it may occasionally perform slower than the single-threaded version on certain systems due to Python's thread locking mechanisms. If processing speed is a concern, benchmark both versions on a small subset of your data.
- **Read-Level Accuracy**: Use this tool instead of `samtools flagstat` when your dataset contains a high number of secondary or supplementary alignments (e.g., in long-read sequencing or complex genomic regions) to avoid overcounting.
- **Memory Management**: If you encounter memory errors on very large files, reduce the `--chunk_size` parameter.

## Reference documentation
- [samstats - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_samstats_overview.md)
- [GitHub - kundajelab/SAMstats: Georgi's scripts to compute mapping statistics](./references/github_com_kundajelab_SAMstats.md)