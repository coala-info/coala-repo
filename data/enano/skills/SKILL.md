---
name: enano
description: ENANO is a specialized compression tool designed for high-ratio lossless compression of nanopore sequencing data. Use when user asks to compress FASTQ files, decompress ENANO files, or optimize storage for genomic datasets.
homepage: https://github.com/guilledufort/EnanoFASTQ
metadata:
  docker_image: "quay.io/biocontainers/enano:1.0--h077b44d_7"
---

# enano

## Overview

ENANO is a specialized compression tool designed to handle the unique data structures of nanopore sequencing. It utilizes context-aware modeling for both basecall sequences and quality scores to achieve high-ratio lossless compression. Use this tool when managing large-scale genomic datasets where storage efficiency and computational speed are priorities.

## Installation

The most reliable way to install enano is via Bioconda:

```bash
conda install -c bioconda enano
```

## Command Line Usage

### Compression

To compress a FASTQ file, use the following syntax:

```bash
enano [options] <input.fastq> <output.enano>
```

**Common Options:**
- `-c`: Enable **Max Compression Mode**. Use this when storage space is the primary constraint and you can afford slightly longer processing times. (Default is Fast Mode).
- `-t <num>`: Set the number of threads. Match this to your CPU's physical cores for optimal performance (Default: 8).
- `-k <length>`: Set basecall sequence context length (Default: 7, Max: 13).
- `-l <length>`: Set DNA neighborhood sequence length for quality score context (Default: 6).

### Decompression

To restore the original FASTQ file:

```bash
enano -d [options] <input.enano> <output.fastq>
```

**Note:** The `-t` flag is also applicable during decompression to speed up the process.

## Best Practices and Expert Tips

### Performance Optimization
- **Thread Scaling**: ENANO scales well with multithreading. For large datasets (e.g., Human WGS), always specify `-t` to utilize available hardware.
- **Memory Efficiency**: ENANO is designed to be computationally efficient; however, when using Max Compression Mode (`-c`), ensure the system has sufficient RAM for the increased context modeling.

### Verification
Since ENANO is a lossless compressor, you can verify the integrity of the data by comparing the original and decompressed files:

```bash
cmp original.fastq decompressed.fastq
```
If the output is empty, the files are identical.

### Workflow Integration
- **Piping**: While ENANO typically takes file arguments, it is best used as a final step in a sequencing pipeline to archive raw data before moving it to long-term storage or cloud buckets.
- **Default Parameters**: The default values for `-k` and `-l` are optimized for standard nanopore datasets. Only adjust these if you are working with non-standard basecalling models or specific metagenomic samples where sequence context varies significantly.

## Reference documentation
- [ENANO Overview](./references/anaconda_org_channels_bioconda_packages_enano_overview.md)
- [EnanoFASTQ Repository](./references/github_com_guilledufort_EnanoFASTQ.md)