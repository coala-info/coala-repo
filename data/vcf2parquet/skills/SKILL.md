---
name: vcf2parquet
description: The `vcf2parquet` tool transforms VCF records into the Apache Parquet format. Use when user asks to convert VCF files to Parquet, apply specific compression, split large VCFs into partitioned Parquet files, or optimize memory usage during conversion.
homepage: https://github.com/natir/vcf2parquet
---


# vcf2parquet

## Overview

The `vcf2parquet` tool is a high-performance utility written in Rust designed to bridge the gap between traditional bioinformatics file formats and modern columnar data storage. It transforms row-based VCF records into the Apache Parquet format, which significantly reduces disk footprint and accelerates downstream data filtering and aggregation. This skill provides the necessary CLI patterns to perform direct conversions, apply specific compression algorithms, and split large datasets into partitioned files.

## Installation

The tool is available via Bioconda. It is recommended to use `mamba` for faster dependency resolution:

```bash
mamba install vcf2parquet
# OR
conda install bioconda::vcf2parquet
```

## Core CLI Usage

The tool follows a specific structure: global options (input, batch size, compression) followed by a subcommand (`convert` or `split`).

### Basic Conversion
To convert a VCF file to a single Parquet file:
```bash
vcf2parquet -i input.vcf.gz convert -o output.parquet
```

### Compression and Performance Tuning
You can specify the compression method and the batch size (number of records processed in memory at once).
- **Default compression**: `snappy`
- **Options**: `uncompressed`, `snappy`, `gzip`, `lzo`, `brotli`, `lz4`

```bash
# Using LZ4 compression with a smaller batch size for memory efficiency
vcf2parquet -i input.vcf.gz -c lz4 -b 50000 convert -o output.parquet
```

### Splitting into Multiple Files
For extremely large VCFs, use the `split` subcommand to create multiple Parquet files. Each file will contain the number of records specified by the `--batch-size` (default 100,000).

```bash
vcf2parquet -i input.vcf.gz split -f "data_part_{}.parquet"
```
*Note: The `{}` in the filename acts as a placeholder for the partition index.*

## Expert Tips and Best Practices

- **Input Compatibility**: The tool natively handles compressed VCFs (`.gz`, `.bz2`, `.xz`). There is no need to decompress files before conversion, which saves temporary disk space.
- **Downstream Compatibility**: If you plan to use the output with **Polars** or **DuckDB**, `lz4` or `snappy` often provide the best balance between compression ratio and decompression speed.
- **Memory Management**: If you encounter "Out of Memory" (OOM) errors on systems with limited RAM, reduce the `--batch-size` (e.g., `-b 10000`). The default is 100,000 records.
- **Partitioning for Big Data**: When working with cloud storage (S3/GCS), use the `split` subcommand. Smaller, partitioned Parquet files allow for better parallelization during distributed processing.
- **Schema Handling**: `vcf2parquet` flattens VCF fields. Standard INFO and FORMAT fields are mapped to Parquet columns, making them directly queryable via SQL in Parquet-compatible engines.

## Reference documentation

- [vcf2parquet Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2parquet_overview.md)
- [vcf2parquet GitHub Repository](./references/github_com_natir_vcf2parquet.md)