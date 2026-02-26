---
name: hmntrimmer
description: "HmnTrimmer is a high-performance tool for preprocessing and quality trimming of NGS data. Use when user asks to trim low-quality read tails, apply sliding window quality filters, filter low-complexity sequences using Dust scores, or remove reads based on minimum length."
homepage: https://github.com/guillaume-gricourt/HmnTrimmer
---


# hmntrimmer

## Overview
HmnTrimmer is a high-performance C++ tool designed for the preprocessing of NGS data. It excels in speed by utilizing the `igzip` library for fast decompression and `SeqAn` for efficient sequence handling. It is particularly useful in workflows requiring rapid quality control of raw reads before assembly or mapping, offering specific trimmers for tail quality, sliding window averages, and sequence complexity.

## Command Line Usage

### Basic Syntax
```bash
HmnTrimmer [OPTIONS] [TRIMMERS]
```

### Input and Output Configuration
HmnTrimmer supports various sequencing layouts. Ensure you match the input flag with the corresponding output flag.

*   **Single-End:**
    `--input-fastq-forward IN.fastq --output-fastq-forward OUT.fastq`
*   **Paired-End:**
    `--input-fastq-forward R1.fastq --input-fastq-reverse R2.fastq --output-fastq-forward OUT_R1.fastq --output-fastq-reverse OUT_R2.fastq`
*   **Interleaved:**
    `--input-fastq-interleaved IN.fastq --output-fastq-interleaved OUT.fastq`
*   **Discarded Reads:**
    `--output-fastq-discard DISCARDED.fastq` (Outputs reads that fail filters; paired-end discards are interleaved).

### Trimming Modules
Trimmers are applied in a specific order: **Information (Dust) -> Quality -> Length**.

#### 1. Quality Trimming
*   **Tail Trimming:** Removes bases from the end of the read based on a quality threshold.
    *   Format: `<quality_cutoff>:<min_bases_below>:<length_percent_to_keep>`
    *   Example: `--quality-tail 20:1:80` (Trim if quality < 20; keep read if at least 80% of original length remains).
*   **Sliding Window:** Trims the end of the read when the average quality in a window drops below a threshold.
    *   Format: `<mean_quality>:<window_size>`
    *   Example: `--quality-sliding-window 20:5`

#### 2. Information/Complexity Filtering
*   **Dust Score:** Filters low-complexity sequences.
    *   Example: `--information-dust 20`

#### 3. Length Filtering
*   **Minimum Length:** Discards reads shorter than the specified value after all other trimming is complete.
    *   Example: `--length-min 50`

### Performance Optimization
*   **Threads:** Scale processing using `--threads` (typically 1 to 8).
*   **Batch Size:** Adjust the number of reads processed in memory at once with `--reads-batch` (default is often sufficient, but can be tuned between 100 and 50,000,000).

## Generating Reports
HmnTrimmer can output a JSON execution report which can then be rendered into an HTML visualization.

1.  **Generate JSON:**
    `HmnTrimmer --input-fastq-forward in.fq --output-fastq-forward out.fq --output-report stats.json`
2.  **Render HTML:**
    Use the provided Python script (requires `django`, `matplotlib`, `seaborn`):
    `python3 RenderingReportFile.py --input-file stats.json --output-file report.html --template-file template.html`

## Best Practices
*   **Order of Operations:** Remember that HmnTrimmer processes quality before length. If you set a high `--length-min` and aggressive quality trimming, you may lose a significant portion of your library.
*   **Compression:** Since HmnTrimmer uses `igzip`, it is highly efficient at handling `.gz` files directly. Always provide compressed inputs to save I/O time.
*   **Logging:** Use `--verbose` (levels 1-6) to debug issues with read headers or file formatting. Level 1 is errors only; level 6 is full trace.

## Reference documentation
- [HmnTrimmer GitHub Repository](./references/github_com_guillaume-gricourt_HmnTrimmer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hmntrimmer_overview.md)