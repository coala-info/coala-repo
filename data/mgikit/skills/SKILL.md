---
name: mgikit
description: mgikit is a bioinformatics toolkit designed to demultiplex and reformat raw sequencing data from MGI platforms. Use when user asks to identify index templates, demultiplex reads into sample-specific FASTQ files, convert MGI headers to Illumina format, or merge quality control reports.
homepage: https://sagc-bioinformatics.github.io/mgikit/
---


# mgikit

## Overview

`mgikit` is a specialized bioinformatics toolkit designed for MGI sequencing platforms. It streamlines the transition from raw MGI data to analysis-ready FASTQ files by handling barcode identification, read assignment, and quality reporting. Use this skill to identify index locations in mixed libraries, perform high-performance demultiplexing, and convert MGI-specific headers into the more widely supported Illumina format for downstream compatibility.

## Core Workflows

### 1. Index Template Detection
If the exact location of barcodes within the read is unknown or if the library is mixed, use the `template` command first. It scans a subset of reads to identify the best-matching index positions.

```bash
mgikit template -f R1.fq.gz -r R2.fq.gz -s sample_sheet.csv -o detection_results
```
*   **Tip**: Use `--popular-template` to force a single consistent template across all samples if the library is not mixed.
*   **Tip**: Adjust `--testing-reads` (default 5,000) if you have a very complex pool with low-concentration samples.

### 2. Demultiplexing
The primary command for assigning reads to samples based on barcodes.

**Standard Paired-End Run:**
```bash
mgikit demultiplex -f R1.fq.gz -r R2.fq.gz -s sample_sheet.csv -o output_dir --threads 8
```

**Directory-based Input (MGI Flowcell Structure):**
```bash
mgikit demultiplex -i /path/to/lane_dir -s sample_sheet.csv -o output_dir
```

*   **Mismatches**: Default is 1. For dual indexes (i7 and i5), the mismatch limit applies to the sum of both indexes.
*   **Illumina Compatibility**: By default, `mgikit` outputs Illumina-formatted headers and file names. Use `--disable-illumina` to keep original MGI formatting.
*   **Trimming**: Barcodes are trimmed by default. Use `--keep-barcode` if you need the barcode sequence to remain at the end of the reads.

### 3. Reformatting Existing Files
Use `reformat` to convert previously demultiplexed MGI files or raw data into Illumina format without re-running the full demultiplexing logic.

```bash
mgikit reformat -f sample_R1.fq.gz -r sample_R2.fq.gz --lane L01 --sample-index 1 -o reformatted_output
```

### 4. Merging Reports
When a run spans multiple lanes, use `report` to aggregate the individual lane statistics into a single comprehensive summary.

```bash
mgikit report --qc-report lane1.info --qc-report lane2.info -o merged_run_report
```

## Expert Tips and Best Practices

*   **Memory Management**: If running on a shared cluster or a machine with limited RAM, use the `--memory` flag (in GB) to cap usage. The tool uses a writing buffer (`--writing-buffer-size`) that can be lowered to save memory at the cost of speed.
*   **Handling Errors**: If a run has a high number of unassigned reads, `mgikit` may stop. Use `--ignore-undetermined` to force the process to continue with a warning.
*   **Compression**: The default compression level is 1 (fast). For long-term storage, increase `--compression-level` up to 12, though this significantly slows down processing.
*   **Validation**: Always use the `--validate` flag when working with potentially corrupted FASTQ files to ensure data integrity during the demultiplexing process.
*   **Line Endings**: Ensure your sample sheet uses Unix line breakers (`\n`). Files created on Windows may cause parsing errors.

## Reference documentation
- [MGIKIT Main Documentation](./references/sagc-bioinformatics_github_io_mgikit.md)
- [Demultiplexing Guide](./references/sagc-bioinformatics_github_io_mgikit_demultiplex.md)
- [Template Detection Guide](./references/sagc-bioinformatics_github_io_mgikit_template.md)
- [Reformat Guide](./references/sagc-bioinformatics_github_io_mgikit_reformat.md)
- [Report Merging Guide](./references/sagc-bioinformatics_github_io_mgikit_report.md)