---
name: samstats
description: samstats computes read-level alignment statistics from SAM or BAM files to report the number of unique fragments sequenced and mapped. Use when user asks to calculate mapping statistics, analyze read-level quality control metrics, or generate alignment reports from queryname-sorted files.
homepage: https://github.com/kundajelab/SAMstats
metadata:
  docker_image: "quay.io/biocontainers/samstats:0.2.2--py_0"
---

# samstats

## Overview

`samstats` is a specialized bioinformatics utility designed to compute alignment statistics from SAM or BAM files. While standard tools like `samtools flagstat` count every alignment record (including secondary and supplementary alignments), `samstats` focuses on the underlying biological reads. This distinction is critical for accurately reporting the number of unique fragments sequenced and mapped in a library. It supports both single-threaded and parallel execution and includes helper scripts for sorting and filtering based on specific bitwise flags.

## Usage Patterns

### Core Commands

The tool provides two primary entry points depending on your performance needs:

- **Standard Execution**: Best for smaller files or environments where thread locking might occur.
  ```bash
  SAMstats --sorted_sam_file input.sam --outf stats.txt --chunk_size 1000
  ```

- **Parallel Execution**: Utilizes multiple cores for processing large datasets.
  ```bash
  SAMstatsParallel --sorted_sam_file input.sam --outf stats.txt --threads 4 --chunk_size 1000
  ```

### Parameters
- `--sorted_sam_file`: Path to the input SAM/BAM file. **Note**: The file must be sorted by read name (queryname) for accurate read-level statistics.
- `--outf`: The destination path for the generated statistics report.
- `--chunk_size`: Number of reads to process in a single batch (default is often 1000).
- `--threads`: (Parallel only) Number of CPU threads to allocate.

## Expert Tips and Best Practices

### Pre-sorting Requirements
`samstats` requires input files to be sorted by **queryname** (`samtools sort -n`) to ensure all alignment records for a single read are grouped together. If your file is coordinate-sorted, use the provided wrapper script to automate the transition:
```bash
bash SAMstats.sort.stat.filter.sh input.bam output_prefix.stats num_threads
```

### Interpreting Results
Unlike `flagstat`, `samstats` output explicitly breaks down QC pass/fail metrics for:
- **Read 1 vs Read 2**: Essential for identifying strand-specific sequencing issues.
- **Primary vs. Secondary/Supplementary**: Helps distinguish the main genomic origin of a read from chimeric or multi-mapping events.
- **Properly Paired Fragments**: Provides a more accurate count of biologically relevant pairs compared to raw alignment counts.

### Performance Tuning
- **Thread Locking**: In some environments, `SAMstatsParallel` may perform slower than the single-threaded version due to Python's Global Interpreter Lock (GIL) or I/O bottlenecks. If performance is poor, revert to `SAMstats`.
- **Memory Management**: Adjust `--chunk_size` based on available RAM. Larger chunks can improve speed but increase memory footprint.



## Subcommands

| Command | Description |
|---------|-------------|
| SAMstats | Compute SAM file mapping statistics for a SAM file sorted by read name |
| SAMstatsParallel | Compute SAM file mapping statistics for a SAM file sorted by read name |

## Reference documentation

- [SAMstats README](./references/github_com_kundajelab_SAMstats_blob_master_README.md)
- [SAMstats Sort and Filter Script](./references/github_com_kundajelab_SAMstats_blob_master_SAMstats.sort.stat.filter.sh.md)
- [Flagstat Helper Script](./references/github_com_kundajelab_SAMstats_blob_master_flagstat.sh.md)