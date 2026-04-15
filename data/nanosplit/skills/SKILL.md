---
name: nanosplit
description: NanoSplit categorizes Oxford Nanopore FASTQ reads into separate files based on their average quality score. Use when user asks to split FASTQ files by quality, filter nanopore reads into pass and fail categories, or adjust quality score thresholds for sequencing data.
homepage: https://github.com/wdecoster/nanosplit
metadata:
  docker_image: "quay.io/biocontainers/nanosplit:0.1.4--py35_0"
---

# nanosplit

## Overview

NanoSplit is a specialized utility for Oxford Nanopore Technologies (ONT) data management. It categorizes reads from a FASTQ file into two separate compressed files based on their average quality score. This tool is essential for downstream analysis workflows where only high-quality "pass" reads are desired, or for auditing "fail" reads to troubleshoot sequencing runs. It natively handles compressed input and output to minimize storage footprints.

## Command Line Usage

The basic syntax for NanoSplit requires a FASTQ file as a positional argument.

### Basic Filtering
To split a file using the default average quality score of 12:
```bash
NanoSplit reads.fastq.gz
```

### Custom Quality Thresholds
Adjust the quality cutoff using the `-q` flag. For example, to set the threshold to 10:
```bash
NanoSplit -q 10 reads.fastq.gz
```

### Managing Output
By default, NanoSplit writes to the current directory. Use `--outdir` to specify a destination:
```bash
NanoSplit -q 12 --outdir ./processed_data/ input.fastq.gz
```

## Best Practices and Tips

- **Input Formats**: NanoSplit accepts both raw `.fastq` and gzipped `.fastq.gz` files. There is no need to decompress files before processing.
- **Automatic Compression**: The tool automatically writes output to gzip-compressed files, which is the standard for ONT data storage.
- **Quality Score Selection**: While the default is 12, the appropriate threshold often depends on the flow cell chemistry and basecaller used. Common thresholds in the ONT community range from 7 to 15.
- **Directory Preparation**: Ensure the output directory exists before running the command with `--outdir`, as the tool may not automatically create parent directories.

## Reference documentation
- [NanoSplit GitHub Repository](./references/github_com_wdecoster_nanosplit.md)
- [Bioconda NanoSplit Overview](./references/anaconda_org_channels_bioconda_packages_nanosplit_overview.md)