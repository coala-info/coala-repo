---
name: array-as-vcf
description: `array-as-vcf` is a specialized utility that transforms proprietary SNP array text exports into the standard Variant Call Format (VCF).
homepage: https://github.com/LUMC/array-as-vcf
---

# array-as-vcf

## Overview

`array-as-vcf` is a specialized utility that transforms proprietary SNP array text exports into the standard Variant Call Format (VCF). It simplifies the bioinformatics pipeline by auto-detecting the specific array format and handling the retrieval of reference (REF) and alternate (ALT) alleles. While it can query the Ensembl API dynamically, it is most efficient when used with local JSON lookup tables to avoid network latency and rate-limiting during large-scale conversions.

## Supported Formats

The tool automatically detects the following TSV export formats:
- Affymetrix
- Cytoscan HD Array
- Lumi 317k and 370k arrays
- Multi-sample OpenArray

## Command Line Usage

### Basic Conversion
To convert an array file to VCF, you must provide the file path, the target genome build, and a sample name. The output is sent to `stdout`.

```bash
array-as-vcf --path input_array.tsv --build GRCh37 --sample-name MySample > output.vcf
```

### Optimization with Lookup Tables
Querying Ensembl for every rsID is slow. Use a lookup table to significantly speed up the process.

**1. Generate a lookup table from a new file:**
```bash
array-as-vcf -p input.tsv -s MySample -b GRCh38 --dump my_cache.json > output.vcf
```

**2. Use an existing lookup table:**
```bash
array-as-vcf -p input.tsv -s MySample -b GRCh38 --lookup-table my_cache.json > output.vcf
```

### Handling Chromosome Prefixes
If your downstream tools require specific chromosome naming (e.g., "chr1" instead of "1"), use the prefix option:

```bash
array-as-vcf -p input.tsv -s MySample -b GRCh38 --chr-prefix chr > output.vcf
```

## Expert Tips and Best Practices

- **Network Dependency**: Without a lookup table, the tool requires a stable internet connection to reach Ensembl. For offline environments or high-throughput processing, always pre-generate and provide a `--lookup-table`.
- **Lookup Table Schema**: If manually creating or editing the JSON lookup table, use the following format: `{"rsID": "REF:ALT:REF_IS_MINOR"}` (e.g., `{"rs1000003": "A:G:F"}`).
- **Memory Management**: Since the tool processes TSV exports, ensure the environment has sufficient memory for large multi-sample OpenArray files, though the tool is generally lightweight.
- **Error Handling**: If the tool fails to auto-detect the format, verify that the input is a raw TSV export from the supported platforms and has not been pre-filtered or modified in a way that removes header signatures.

## Reference documentation
- [array-as-vcf Overview](./references/anaconda_org_channels_bioconda_packages_array-as-vcf_overview.md)
- [LUMC array-as-vcf Repository](./references/github_com_LUMC_array-as-vcf.md)