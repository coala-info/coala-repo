---
name: vcf-pg-loader
description: vcf-pg-loader automates the ingestion of VCF genomic data into PostgreSQL databases for structured analysis and polygenic scoring. Use when user asks to load VCF files into a database, initialize genomic database schemas, or annotate variants using reference databases.
homepage: https://github.com/Zacharyr41/vcf-pg-loader
---

# vcf-pg-loader

## Overview
The `vcf-pg-loader` is a specialized utility designed to bridge the gap between raw genomic variant files and relational databases. It automates the ingestion of VCF data into PostgreSQL, providing a structured foundation for downstream genomic analysis and polygenic scoring. This tool is essential for bioinformatics engineers who need to move beyond flat-file processing into scalable, queryable database architectures while maintaining strict security standards for protected health information (PHI).

## Installation and Setup
The tool can be installed via multiple package managers or directly from source:

- **Bioconda**: `conda install -c bioconda vcf-pg-loader`
- **PyPI**: `pip install vcf-pg-loader`
- **Development**: Use `uv` for fast environment setup: `uv sync`

## Database Configuration
The tool relies on environment variables for database connectivity. For HIPAA compliance, never include passwords in connection strings.

1. **Required Variables**:
   - `VCF_PG_LOADER_DB_PASSWORD`: The primary variable for the database password.
   - `PGHOST`, `PGPORT`, `PGUSER`, `PGDATABASE`: Standard PostgreSQL connection parameters.

2. **Security Fallbacks**:
   - If `VCF_PG_LOADER_DB_PASSWORD` is unset, the tool falls back to `PGPASSWORD`.
   - Supports fetching credentials from **AWS Secrets Manager** (via `VCF_PG_LOADER_AWS_SECRET_PREFIX`) or **HashiCorp Vault** (`VAULT_ADDR`).

## Common CLI Patterns
While specific flags depend on the version, the tool generally follows these functional patterns:

- **Standard Ingestion**:
  Point the loader to your VCF file and target database. Ensure the database schema is initialized before large-scale loads.
- **Docker Deployment**:
  Use the provided `docker-compose.yml` for a standard stack, or `docker-compose.hipaa.yml` for a hardened configuration that includes encrypted communication and stricter access controls.

## Expert Tips
- **HIPAA Compliance**: Always run the tool as a non-root user (the default container user is `vcfloader`). Use the `docker/certs/` directory to manage TLS certificates for encrypted database connections.
- **Performance**: When loading large VCFs (e.g., Whole Genome Sequencing data), ensure your PostgreSQL instance is tuned for high-volume inserts (adjust `max_wal_size` and `checkpoint_timeout`).
- **Integration**: This tool is compatible with `nf-core` modules. If building a Nextflow pipeline, use the `vcfpgloader/load` module to standardize the ingestion step.
- **Testing**: Use the `docker-compose.test.yml` to spin up a transient environment for validating VCF compatibility before committing to a production database.



## Subcommands

| Command | Description |
|---------|-------------|
| vcf-pg-loader annotate | Annotate loaded variants using reference databases. |
| vcf-pg-loader annotation-query | Execute an ad-hoc SQL query against annotation tables. |
| vcf-pg-loader benchmark | Run performance benchmarks on VCF parsing and loading. |
| vcf-pg-loader init-db | Initialize database schema. |
| vcf-pg-loader list-annotations | List all loaded annotation sources. |
| vcf-pg-loader load | Load a VCF file into PostgreSQL. |
| vcf-pg-loader load-annotation | Load an annotation VCF file as a reference database. The annotation source can then be used to annotate query VCFs via SQL JOINs. |
| vcf-pg-loader validate | Validate a completed load. |

## Reference documentation
- [Main Repository Overview](./references/github_com_Zacharyr41_vcf-pg-loader.md)
- [Environment Configuration Template](./references/github_com_Zacharyr41_vcf-pg-loader_blob_main_.env.example.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_vcf-pg-loader_overview.md)
- [HIPAA Security Review Process](./references/github_com_Zacharyr41_vcf-pg-loader_blob_main_.trivyignore.md)