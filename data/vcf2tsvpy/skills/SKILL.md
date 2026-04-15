---
name: vcf2tsvpy
description: vcf2tsvpy converts genomic variant data from VCF format into a flat TSV structure, automatically expanding INFO tags and genotype fields into distinct columns. Use when user asks to convert VCF to TSV, expand VCF INFO tags or genotype fields into separate columns, create a tidy dataset from VCF, skip genotype or INFO data, include data type headers, keep rejected calls, or compress the output TSV.
homepage: https://github.com/sigven/vcf2tsvpy
metadata:
  docker_image: "quay.io/biocontainers/vcf2tsvpy:0.6.1--pyhda70652_0"
---

# vcf2tsvpy

## Overview
vcf2tsvpy is a high-performance Python utility designed to transform genomic variant data from VCF format into a flat TSV structure. Unlike simple parsers, it automatically expands all INFO tags and genotype (FORMAT) fields into distinct columns. By default, the tool generates a "tidy" dataset with one row per sample genotype for every variant, facilitating per-sample analysis. It is built on the `cyvcf2` library for efficient parsing of compressed genomic files.

## Basic Usage
The fundamental command requires an input VCF (preferably bgzipped) and a target output path:

```bash
vcf2tsvpy --input_vcf input.vcf.gz --out_tsv output.tsv
```

## Expert Tips and Best Practices

### Managing Output Size
For multi-sample VCFs, the output file size can grow exponentially because the tool creates one line per sample per variant.
- **Variant-only analysis**: If you do not need individual genotype information, use `--skip_genotype_data`. This significantly reduces file size and processing time.
- **Reducing annotation bloat**: Use `--skip_info_data` if you only require the fixed VCF columns and genotype calls.

### Handling Duplicate Tags
In some VCFs, the same tag (e.g., `DP` for depth) exists in both the INFO and FORMAT headers. 
- As of version 0.6.1, the tool automatically prepends `INFO_` to the INFO-level tag (e.g., `INFO_DP`) to prevent column name collisions in the TSV.

### Data Type Awareness
When preparing data for automated pipelines or database ingestion:
- Use the `--print_data_type_header` flag. This adds a secondary header line indicating the VCF data types (Integer, Float, String, etc.) for each column, which is helpful for schema mapping.

### Filtering and Quality
- **Default Filtering**: By default, the tool only outputs "PASS" variants and non-rejected genotypes.
- **Include All Data**: To include variants that failed filters or have missing genotypes (`./.`), add the `--keep_rejected_calls` flag.

### Storage Efficiency
- Use the `--compress` flag to automatically gzip the resulting TSV file, which is highly recommended for large-scale whole-genome or exome datasets.

## Installation
The tool is most easily managed via Conda:
```bash
conda install -c bioconda vcf2tsvpy
```

## Reference documentation
- [vcf2tsvpy GitHub Repository](./references/github_com_sigven_vcf2tsvpy.md)
- [vcf2tsvpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2tsvpy_overview.md)