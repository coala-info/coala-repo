---
name: fastq-count
description: fastq-count is a high-performance utility that calculates the total number of reads and bases in FASTQ datasets. Use when user asks to count reads and bases, process paired-end data, or generate summary statistics for compressed FASTQ files.
homepage: https://github.com/sndrtj/fastq-count
metadata:
  docker_image: "quay.io/biocontainers/fastq-count:0.1.0--h7b50bb2_6"
---

# fastq-count

## Overview

`fastq-count` is a specialized, high-performance utility written in Rust for the bioinformatics domain. Its primary purpose is to provide a fast and lightweight method for calculating the total number of reads and bases within FASTQ datasets. Unlike more complex sequence analysis tools, `fastq-count` focuses on speed and simplicity, making it an ideal choice for initial quality control checks or pipeline steps where only basic summary statistics are required. It natively handles paired-end data and transparently decompresses gzip files.

## Installation

The tool is most easily installed via the Bioconda channel:

```bash
conda install -c bioconda fastq-count
```

## Command Line Usage

### Basic Counting
To count reads and bases in a single FASTQ file:
```bash
fastq-count sample_R1.fastq
```

### Paired-End Data
To process paired-end reads simultaneously:
```bash
fastq-count sample_R1.fastq sample_R2.fastq
```

### Compressed Files
The tool automatically detects and decompresses gzip files. **Note**: Compressed files must use the `.gz` extension.
```bash
fastq-count sample_R1.fastq.gz sample_R2.fastq.gz
```

## Output Format

The tool returns a JSON object containing the total counts. This makes it highly compatible with downstream processing tools like `jq`.

**Example Output:**
```json
{
  "reads": 1500000,
  "bases": 225000000
}
```

### Parsing Output with jq
To extract only the read count for use in a shell variable:
```bash
READ_COUNT=$(fastq-count sample.fq.gz | jq '.reads')
```

## Best Practices and Tips

- **File Extensions**: Always ensure your compressed files end in `.gz`. The tool relies on the filename suffix to trigger the `MultiGZDecoder`.
- **Performance**: Because it is written in Rust, `fastq-count` is significantly faster than equivalent Python or Perl scripts. Use it in high-throughput pipelines to minimize bottlenecks during the QC phase.
- **Paired-End Logic**: When providing two files (R1 and R2), the tool aggregates the counts. If you need individual counts per file for validation, run the command on each file separately.
- **Memory Efficiency**: The tool is designed to stream data, meaning it can handle very large FASTQ files without requiring large amounts of RAM.

## Reference documentation
- [fastq-count Overview](./references/anaconda_org_channels_bioconda_packages_fastq-count_overview.md)
- [fastq-count GitHub Repository](./references/github_com_sndrtj_fastq-count.md)