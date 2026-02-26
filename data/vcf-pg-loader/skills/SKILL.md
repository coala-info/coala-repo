---
name: vcf-pg-loader
description: vcf-pg-loader loads genomic variant data from VCF files into a PostgreSQL database. Use when user asks to load VCF data, initialize a database schema, import GWAS summary statistics, validate loaded data, query the database, or verify installation.
homepage: https://github.com/Zacharyr41/vcf-pg-loader
---


# vcf-pg-loader

## Overview

The `vcf-pg-loader` is a high-performance CLI tool designed to bridge the gap between genomic flat files and relational databases. It is specifically optimized for Polygenic Risk Score (PRS) research, providing a robust infrastructure for handling large-scale variant data, genotype dosages, and clinical-grade compliance. By utilizing streaming parsing and the PostgreSQL binary COPY protocol, it ensures maximum throughput while maintaining data integrity through built-in variant normalization and quality control metrics.

## Core CLI Patterns

### 1. Environment Setup and Verification
Before running load operations, ensure your environment is correctly configured.
- **Verify Installation**: Run `vcf-pg-loader doctor` to check dependencies like Python and Docker.
- **Database Credentials**: Set the `PGPASSWORD` environment variable to avoid interactive prompts during automated workflows.

### 2. Database Initialization
You must initialize the schema before the first load if using an external database.
- **Standard Human Genome**: `vcf-pg-loader init-db --db postgresql://user:pass@host/dbname`
- **Non-Human Genomes**: Use the `--no-human-genome` flag to switch chromosome columns from ENUM to TEXT types.

### 3. Loading VCF Data
The tool supports two primary modes of operation:
- **Zero-Config Mode**: Automatically manages a local PostgreSQL instance via Docker.
  `vcf-pg-loader load sample.vcf.gz`
- **Custom Database Mode**: Connects to an existing PostgreSQL instance.
  `vcf-pg-loader load sample.vcf.gz --db postgresql://user:pass@host/dbname`

### 4. PRS Workflow Integration
For Polygenic Risk Score research, follow this sequence:
1. **Load Genotypes**: Load imputed VCFs containing dosages/GP fields.
2. **Import GWAS Stats**: `vcf-pg-loader import-gwas gwas_sumstats.tsv --study-id <ID>`
3. **Load Weights**: Integrate PGS Catalog scoring files to match variants against your loaded genotypes.

## Expert Tips and Best Practices

- **Variant Normalization**: By default, the tool uses the `vt` algorithm to left-align and trim variants. If your VCF is already normalized, use `--no-normalize` to increase loading speed.
- **Multi-allelic Handling**: The loader properly handles `Number=A/R/G` fields during decomposition. It extracts the specific values corresponding to each ALT allele rather than just duplicating the info string.
- **Performance Optimization**:
    - Use the binary COPY protocol (default) for the fastest inserts.
    - For very large datasets, ensure the database host has sufficient IOPS, as the tool uses asyncpg for high-concurrency writes.
- **Data Validation**: After a load completes, always run `vcf-pg-loader validate <batch-id>` to ensure the row counts in the database match the records parsed from the VCF.
- **Querying Data**: Use `vcf-pg-loader db shell` to quickly jump into a `psql` session pre-configured with your connection string.

## Reference documentation
- [vcf-pg-loader Overview](./references/anaconda_org_channels_bioconda_packages_vcf-pg-loader_overview.md)
- [vcf-pg-loader GitHub Repository](./references/github_com_Zacharyr41_vcf-pg-loader.md)