---
name: fastq-scan
description: The `fastq-scan` tool is a lightweight C++ utility designed to parse FASTQ files and produce comprehensive quality control metrics.
homepage: https://github.com/rpetit3/fastq-scan
---

# fastq-scan

## Overview
The `fastq-scan` tool is a lightweight C++ utility designed to parse FASTQ files and produce comprehensive quality control metrics. Unlike traditional tools like FastQC which generate HTML reports, `fastq-scan` outputs structured JSON, making it highly suitable for automated pipelines, custom reporting scripts, and database ingestion. Use this skill when you need to quickly assess the quality of a sequencing run or calculate estimated coverage based on a known genome size.

## Core Usage
The tool reads exclusively from `STDIN` and writes to `STDOUT`.

### Basic Command
```bash
cat input.fastq | fastq-scan
```

### Handling Compressed Files
Since `fastq-scan` reads from standard input, use `zcat` or `gzip -dc` for `.gz` files:
```bash
zcat input.fastq.gz | fastq-scan
```

## Command Line Options
- `-g INT`: **Genome Size**. Provide the expected genome size in base pairs to calculate estimated sequencing coverage (`total_bp / genome_size`). Defaults to 1 (coverage will be 0.00 if not set).
- `-p INT`: **ASCII Offset**. Specify the PHRED quality score offset. Valid values are `33` (Sanger/Illumina 1.8+) or `64` (Legacy Illumina). Defaults to 33.
- `-v`: Print version information.
- `-h`: Show help message.

## Expert Tips and Best Practices

### Estimating Coverage
To get a meaningful coverage estimate, always provide the `-g` flag with the target organism's genome size:
```bash
# Example for a 5Mbp bacterial genome
zcat reads.fastq.gz | fastq-scan -g 5000000
```

### Integration with jq
Because the output is JSON, you can use `jq` to extract specific metrics for downstream logic or logging:
```bash
# Extract only the mean read quality
cat reads.fq | fastq-scan | jq '.qc_stats.qual_mean'

# Check if total reads meet a threshold
cat reads.fq | fastq-scan | jq '.qc_stats.read_total > 1000000'
```

### Performance Considerations
`fastq-scan` is optimized for speed by using a fast C++ parser. It is significantly faster than many Python-based alternatives for large datasets. When processing paired-end data, you can concatenate the files into the stream to get aggregate statistics for the entire library:
```bash
cat R1.fq R2.fq | fastq-scan -g 3000000000
```

### Quality Score Offsets
If you are working with older datasets (e.g., Illumina 1.3-1.7), ensure you set `-p 64`. Using the wrong offset will result in incorrect quality mean and standard deviation calculations.

## Reference documentation
- [github_com_rpetit3_fastq-scan.md](./references/github_com_rpetit3_fastq-scan.md)
- [anaconda_org_channels_bioconda_packages_fastq-scan_overview.md](./references/anaconda_org_channels_bioconda_packages_fastq-scan_overview.md)