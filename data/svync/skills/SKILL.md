---
name: svync
description: svync is a command-line utility that standardizes structural variant VCF files by mapping inconsistent tags and nomenclature into a unified schema. Use when user asks to normalize structural variant caller outputs, map VCF INFO tags, or prepare genomic data for multi-caller integration.
homepage: https://github.com/nvnieuwk/svync
metadata:
  docker_image: "quay.io/biocontainers/svync:0.3.0--h9ee0642_0"
---

# svync

## Overview

svync is a command-line utility designed to solve the "interoperability problem" in structural variant calling. Because different SV callers often use inconsistent INFO tags, FORMAT fields, and variant type nomenclature, comparing their results is historically difficult. svync uses a configuration-driven approach to map these disparate attributes into a unified schema. It is best used as a preprocessing step in genomic pipelines before performing multi-caller integration or entering VCF files into a database.

## Installation and Setup

The most reliable way to install svync is via the Bioconda channel:

```bash
conda install -c bioconda svync
```

Alternatively, for environments without Conda, precompiled binaries are available for Linux and macOS, or it can be built from source using the Go toolchain (`go build .`).

## Command Line Usage

The tool follows a standard CLI pattern requiring an input VCF and a configuration file.

### Basic Command
```bash
svync --config <config_file> --input <input_vcf> --output <output_vcf>
```

### Key Arguments
- `--config` / `-c`: (Required) The path to the configuration file that defines the standardization logic.
- `--input` / `-i`: (Required) The source VCF file containing structural variants.
- `--output` / `-o`: The destination for the standardized VCF. If omitted, the tool defaults to `stdout`, which is ideal for piping into other tools like `bcftools` or `bgzip`.
- `--nodate` / `--nd`: Prevents the tool from adding the current execution date to the VCF header, which is useful for maintaining bit-identical reproducibility in pipelines.
- `--mute-warnings` / `--mw`: Suppresses warning messages during the synchronization process.

## Expert Tips and Best Practices

### Streamlining Workflows
Since svync defaults to `stdout`, you can avoid creating intermediate files by piping the output directly to compression tools:
```bash
svync -c standard.yaml -i raw_calls.vcf | bgzip -c > standardized_calls.vcf.gz
```

### Configuration Logic
While the tool requires a configuration file to function, the logic typically involves:
- **Field Mapping**: Renaming caller-specific INFO tags to standard VCF tags (e.g., mapping a tool's custom depth tag to a standard DP tag).
- **Type Standardization**: Ensuring variant types (DEL, DUP, INV, etc.) use consistent strings across all files in a project.
- **Value Transformation**: Adjusting coordinates or calculating lengths if a specific caller uses a non-standard 0/1-based coordinate system or different end-position logic.

### Handling Empty VCFs
svync is designed to be robust in production pipelines; it will correctly output a valid VCF header even if the input file contains no variant records, preventing downstream tools from crashing on empty inputs.

## Reference documentation
- [svync Overview - Anaconda](./references/anaconda_org_channels_bioconda_packages_svync_overview.md)
- [svync Repository - GitHub](./references/github_com_nvnieuwk_svync.md)