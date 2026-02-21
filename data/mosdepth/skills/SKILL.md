---
name: mosdepth
description: mosdepth is a high-performance utility designed for rapid depth-of-coverage calculations from alignment files (BAM or CRAM).
homepage: https://github.com/brentp/mosdepth
---

# mosdepth

## Overview

mosdepth is a high-performance utility designed for rapid depth-of-coverage calculations from alignment files (BAM or CRAM). By leveraging the htslib library and optimized algorithms, it provides a significantly faster alternative to `samtools depth`. It is particularly effective for generating summary statistics for whole-genome sequencing (WGS), targeted capture (Exome), and identifying "callable" genomic regions based on coverage thresholds.

## Common CLI Patterns

### Whole Genome Sequencing (WGS)
For WGS, it is often useful to calculate mean depth in fixed-size windows (e.g., 500bp) to identify large-scale coverage variations or CNVs.
```bash
mosdepth -n --fast-mode --by 500 sample_wgs sample.cram
```
*   `-n`: Suppresses per-base output (saves significant time and disk space).
*   `--fast-mode`: Skips internal CIGAR operations and mate overlap corrections; recommended for most WGS use cases.

### Exome or Targeted Sequencing
To calculate mean coverage for specific regions, provide a BED file.
```bash
mosdepth --by capture_regions.bed sample_exome sample.bam
```
*   If the BED file has 4 columns, the 4th column (name) is propagated to the output.
*   Output: `sample_exome.regions.bed.gz` contains the mean depth for each interval.

### Quantized Output (Callable Loci)
Create merged BED regions based on coverage bins, useful for defining "callable" vs "low-coverage" areas.
```bash
export MOSDEPTH_Q0=NO_COVERAGE
export MOSDEPTH_Q1=LOW_COVERAGE
export MOSDEPTH_Q2=CALLABLE
export MOSDEPTH_Q3=HIGH_COVERAGE

mosdepth -n --quantize 0:1:5:150: sample_quantized sample.bam
```
*   The bins defined are 0, 1-4, 5-149, and 150+.
*   Output: `sample_quantized.quantized.bed.gz`.

### Threshold Output
Calculate how many bases in each region meet specific coverage thresholds.
```bash
mosdepth --by regions.bed --thresholds 1,10,20,30 sample_thresholds sample.bam
```
*   Output: `sample_thresholds.thresholds.bed.gz` contains the count of bases meeting each threshold per region.

## Expert Tips and Best Practices

*   **Thread Scaling**: Use `-t` to specify decompression threads. Usually, 3-4 threads provide the best balance of speed without hitting I/O bottlenecks.
*   **CRAM Support**: When working with CRAM files, always provide the reference fasta using `-f` to ensure proper decoding.
*   **Precision Control**: By default, mosdepth outputs 2 decimal places. For higher precision in the distribution files, set the environment variable `MOSDEPTH_PRECISION=5`.
*   **Median vs Mean**: Use `-m` or `--use-median` to output the median depth per region instead of the mean. Note that this is typically used with the `--by` flag.
*   **D4 Format**: For extremely fast per-base depth access, use the `--d4` flag. D4 is a specialized format that is much faster to write and query than compressed BED files.
*   **Filtering**: Use `-Q` to set a minimum mapping quality (MAPQ) threshold (e.g., `-Q 20`) to exclude poorly mapped reads from depth calculations.
*   **Fragment Mode**: Use `-a` or `--fragment-mode` to count the coverage of the entire fragment (including the insert) for proper pairs, rather than just the aligned reads.

## Reference documentation
- [mosdepth README](./references/github_com_brentp_mosdepth.md)
- [mosdepth Wiki/FAQ](./references/github_com_brentp_mosdepth_wiki.md)