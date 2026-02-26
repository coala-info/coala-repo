---
name: vcf2db
description: vcf2db transforms genomic variant data into a relational database format. Use when user asks to transform VCF data into a relational database, create a SQLite database, load data into PostgreSQL or MySQL, or expand genotype fields.
homepage: https://github.com/quinlan-lab/vcf2db
---


# vcf2db

## Overview
vcf2db is a specialized utility designed to transform genomic variant data into a relational database format. Unlike older versions of GEMINI that handled annotation during the loading process, vcf2db expects a pre-annotated VCF (via VEP, snpEff, or bcftools csq). It parses the INFO fields and genotype data to construct a database schema that allows for high-performance filtering and analysis of variants, impacts, and family relationships.

## Core Workflows

### Basic Database Creation
To create a standard SQLite database from an annotated VCF and a pedigree file:
```bash
python vcf2db.py input.annotated.vcf.gz input.ped output.db
```

### Using Remote Databases
vcf2db supports PostgreSQL and MySQL via connection strings. Note that using these backends requires a specific version of GEMINI (from GitHub) to query the resulting database.
- **PostgreSQL**: `python vcf2db.py input.vcf.gz input.ped "postgres://username:password@localhost/database_name"`
- **MySQL**: `python vcf2db.py input.vcf.gz input.ped "mysql://username:password@localhost/database_name"`

### Expanding Genotype Fields
By default, some genotype information is stored in a way that is optimized for GEMINI. To make specific genotype fields directly queryable via standard SQL INFO queries, use the `--expand` flag:
```bash
python vcf2db.py input.vcf.gz input.ped output.db \
    --expand gt_types \
    --expand gt_ref_depths \
    --expand gt_alt_depths
```

## Expert Tips and Best Practices

### Pre-Annotation Requirements
vcf2db does not annotate variants; it only loads them. Ensure your VCF is processed with one of the following before loading:
- **VEP**: Must include the `CSQ` tag.
- **snpEff**: Must include the `ANN` tag.
- **bcftools csq**: Supported for GFF3-based functional annotation.

### Performance and Storage
- **Insertion Speed**: Expect approximately 1,200 variants per second when using SQLite (including indexing time).
- **AWS Compatibility**: Do not use Amazon Elastic File Storage (EFS) for creating SQLite databases due to locking and latency issues. Use Elastic Block Storage (EBS) instead.

### Handling Large Datasets
For large-scale projects, prefer PostgreSQL over SQLite to handle concurrent access and larger data volumes more effectively. Ensure the database user has sufficient permissions to create tables and indexes.

## Reference documentation
- [vcf2db Main Documentation](./references/github_com_quinlan-lab_vcf2db.md)
- [vcf2db Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vcf2db_overview.md)