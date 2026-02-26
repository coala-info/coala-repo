---
name: yanagiba
description: Yanagiba filters and trims Oxford Nanopore sequencing reads. Use when user asks to filter reads by length, filter reads by quality, trim reads, or calculate read quality.
homepage: https://github.com/Adamtaranto/Yanagiba
---


# yanagiba

## Overview
Yanagiba is a specialized utility for the post-processing of Oxford Nanopore Technologies (ONT) data. It streamlines the transition from raw basecalled data to downstream analysis by allowing users to discard short or low-quality reads and perform precise head/tail trimming. While optimized for use with Albacore summary files to determine read metrics, it can also calculate quality scores directly from FASTQ files using internal heuristics.

## Command Line Usage

### Basic Filtering
To filter reads based on a minimum length and quality score using an Albacore summary file:
```bash
yanagiba --infile reads.fastq.gz --summaryfile sequencing_summary.txt --minlen 1000 --minqual 12 --outfile filtered_reads.fastq.bgz
```

### Trimming and Slicing
To remove specific lengths from the start (head) or end (tail) of every retained read:
```bash
yanagiba -i reads.fastq.gz -s summary.txt --headtrim 50 --tailtrim 50 -o trimmed.fastq.bgz
```

### Processing without a Summary File
If an Albacore summary file is unavailable, Yanagiba will attempt to calculate the mean quality score directly from the FASTQ. Note that calculated scores may be lower than those from official basecallers; adjust thresholds accordingly.
```bash
yanagiba -i reads.fastq.gz -q 8 -o output.fastq.bgz
```

## Expert Tips and Best Practices

*   **Input Requirements**: Ensure the Albacore summary file is tab-delimited and contains the mandatory headers: `read_id`, `sequence_length_template`, and `mean_qscore_template`.
*   **Output Format**: Yanagiba outputs files in `.bgz` (Blocked GNU Zip) format. To convert these back to standard FASTQ for tools that do not support BGZ, use:
    `gunzip -c output.fastq.bgz > output.fastq`
*   **Handling Duplicates**: In cases where the same read ID appears multiple times in the input FASTQ, use the `-u` or `--forceunique` flag to retain only the first instance encountered.
*   **Quality Thresholds**: When working with reads called by Metrichor or when calculating scores directly from FASTQ (without a summary file), the quality scores often trend lower. It is recommended to lower the `--minqual` setting (e.g., to 7 or 8) to avoid over-filtering.
*   **Resource Efficiency**: Using the `--summaryfile` is significantly faster than allowing the tool to calculate quality scores from the FASTQ, as it avoids parsing the full quality string for every record.

## Reference documentation
- [Yanagiba GitHub Repository](./references/github_com_Adamtaranto_Yanagiba.md)
- [Bioconda Yanagiba Overview](./references/anaconda_org_channels_bioconda_packages_yanagiba_overview.md)