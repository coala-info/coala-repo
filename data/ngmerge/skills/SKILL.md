---
name: ngmerge
description: NGmerge merges overlapping paired-end reads into consensus sequences and removes adapter sequences by aligning reads against each other. Use when user asks to merge overlapping FASTQ reads, remove adapter sequences from paired-end data, or process interleaved sequencing files.
homepage: https://github.com/harvardinformatics/NGmerge
metadata:
  docker_image: "quay.io/biocontainers/ngmerge:0.5--h89d970f_0"
---

# ngmerge

## Overview
NGmerge is a specialized tool for the post-sequencing processing of paired-end FASTQ files. It primarily addresses two tasks: merging overlapping read pairs into a single, longer consensus sequence ("stitch mode") and identifying/removing adapter sequences by aligning the reads against each other ("adapter-removal mode"). Unlike many adapter trimmers that rely on matching known adapter sequences, NGmerge uses the alignment of the reads themselves to infer where the adapter starts, making it robust against diverse or unknown adapter designs. It supports multithreading, handles gzipped inputs, and provides various methods for calculating quality scores in merged regions.

## Common CLI Patterns

### Stitching Overlapping Reads (Default Mode)
To combine overlapping R1 and R2 reads into a single merged FASTQ file:
```bash
NGmerge -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -o sample_merged.fastq.gz -z
```
*   **Note**: The `-z` flag ensures the output is gzip-compressed.

### Adapter Removal (Maintaining Pairs)
To trim adapters while keeping the reads as separate R1 and R2 files:
```bash
NGmerge -a -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -o sample_trimmed -z
```
*   **Note**: In adapter-removal mode (`-a`), the `-o` argument acts as a prefix. The tool will generate `sample_trimmed_1.fastq.gz` and `sample_trimmed_2.fastq.gz`.

### Handling Interleaved Files
If your input is a single interleaved FASTQ file (where R1 and R2 follow each other), omit the `-2` flag:
```bash
NGmerge -1 interleaved.fastq -o merged.fastq
```

### Capturing Unmerged Reads
In stitch mode, reads that fail to meet the overlap or mismatch criteria are discarded by default. Use `-f` to save them:
```bash
NGmerge -1 R1.fq -2 R2.fq -o merged.fq -f failed_reads
```
*   This creates `failed_reads_1.fastq` and `failed_reads_2.fastq`.

## Alignment and Quality Tuning

### Adjusting Overlap Sensitivity
*   **Minimum Overlap**: Use `-m <int>` (default: 20) to change the required overlap length. Increase this for high-complexity libraries to reduce false merges.
*   **Mismatch Threshold**: Use `-p <float>` (default: 0.10) to set the maximum allowed fraction of mismatches in the overlapping region.
*   **Dovetailing**: Use `-d` to allow alignments where reads extend past the 3' ends of each other (standard in adapter-removal mode, optional in stitch mode).

### Quality Score Calculation
When merging reads, NGmerge must determine the quality score for the consensus bases.
*   **Default**: Uses a sophisticated calculation based on the probability of error.
*   **Fastq-join Method**: Use `-g` to use the simpler `fastq-join` method (taking the maximum quality score of the two reads).
*   **Custom Profile**: Use `-w <file>` to provide a specific error profile for quality score estimation.

## Expert Tips
*   **Performance**: Always specify `-n <threads>` to utilize multiple CPU cores, as the alignment process is computationally intensive.
*   **Input Flexibility**: NGmerge can read from standard input using `-` (e.g., `-1 -`), allowing it to be piped from other tools like `samtools fastq`.
*   **Quality Trimming Warning**: Avoid aggressive quality trimming at the 5' ends of reads before using NGmerge, as the tool relies on the 5' ends to define the boundaries of the merged fragments.
*   **Log Files**: Use `-l <file>` to generate a log of the stitching results for every read pair, which is useful for troubleshooting low merge rates.

## Reference documentation
- [NGmerge GitHub README](./references/github_com_harvardinformatics_NGmerge.md)
- [Bioconda NGmerge Overview](./references/anaconda_org_channels_bioconda_packages_ngmerge_overview.md)